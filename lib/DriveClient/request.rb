module DriveClient
	class Request

		attr_accessor :client_id, :client_secret

		def initialize params = {}, headers = {}
			@http = Curl.simple
		end

		def merge_headers headers = {}
			{}
		end

	end
end