#!/usr/bin/env ruby
require_relative 'base'
module LogParser
	class Client < Base
		def maximum_called_api
			logs_hash = parse_log_file
			logs_hash = update_url(logs_hash)
			result = group_by_url_and_method(logs_hash)
			output = prepare_frequency_output(result)
			#output array is like "url","method","frequency"
			output = max_frequency(output,5) # only 5 top API
			save_in_excel(["Url","Method","Frequency"], output, "Frequency.csv")
		end

		def response_times
			logs_hash = parse_log_file
			logs_hash = update_url(logs_hash)
			result = group_by_url_and_method(logs_hash)
			output = prepare_arithmetic_outputs(result)
			#output array is like "url","method","Min", "Max", "Average"
			save_in_excel(["Url","Method","Min Time", "Max Time", "Average"],
			 output, "Log response time Arithemtic Values.csv")
		end
	end
end