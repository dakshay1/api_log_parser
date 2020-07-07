#!/usr/bin/env ruby
require_relative 'log_parser/client'
class Caller
	def self.perform_log_parsing_operations
		LogParser::Client.new({file_path: "log.csv"}).maximum_called_api
		LogParser::Client.new({file_path: "log.csv"}).response_times
	end
end
