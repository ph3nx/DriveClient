module DriveClient
	class Query

		def initialize hash
			@hash = hash
		end

		def to_s
			@hash.map{|k,v| "#{CGI.escape(k)}=#{CGI.escape(v)}"}.join('&')
		end
		
	end
end