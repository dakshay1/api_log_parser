
require 'csv'

class Base
	include Utilities
	attr_accessor :file_path

	FILE_BASE_PATH = "temp"
	def initialize(options={})
		@file_path = options[:file_path]
	end

	def parse_log_file
		table = CSV.parse(File.read(@file_path), headers: true)
		return table.map(&:to_h)
	end

	def update_url(hash)
		hash.each do |i|
			i.each_with_object({}) do |(k,v),memo|
				memo[k] = mask_integer(v) if k=="url"
			end
		end
	end

	def group_by_url_and_method(hash)
		result = []
		hash.group_by{|i| i.values_at(*["url","method"])}.each do |(k,v), value|
			result <<{
				url: k,
				method: v,
				parameters: value
			}
		end
		return result
	end

	def prepare_frequency_output(result)
		output = []
		result.each do |hash|
			output << [
				hash[:url],
				hash[:method],
				hash[:parameters].size
			]
		end
		return output
	end

	def prepare_arithmetic_outputs(result)
output = []
result.each do |hash|
output << [
hash[:url],
hash[:method],
hash[:parameters].min_by{|hash| hash["response_time"].to_i}["response_time"],
hash[:parameters].max_by{|hash| hash["response_time"].to_i}["response_time"],
(hash[:parameters].inject(0.0){|sum,hash| sum+hash["response_time"].to_i})/(hash[:parameters].size)
]
end
		return output
	end

	def max_frequency(output_array,size)
		return output_array.sort_by(&:last).reverse[0..size-1]
	end

	def save_in_excel(title_array, output_array, file_name)
		save_path = File.join(Dir.pwd,FILE_BASE_PATH, file_name)
		dirname = File.dirname(save_path)
		unless File.directory?(dirname)
			FileUtils.mkdir_p(dirname)
		end
		CSV.open(save_path,'wb') do |csv|
			csv<<title_array
			csv<<output_array
		end	
	end
end