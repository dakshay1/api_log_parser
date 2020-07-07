module Utilities
	module CommonUtilityMethods
		def mask_integer(url)
			url.gsub!(/\/\d+/,"/{id}")
		end

		def max(a,b)
			a>b ? a : b
		end
	end
end