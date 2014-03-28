module DriveClient
	class Response

		attr_reader :data

		def initialize res
			@data = JSON.parse res.body, {symbolize_names: true}
		end
		
	end
end