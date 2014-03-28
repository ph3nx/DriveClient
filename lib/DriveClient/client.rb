module DriveClient
	class Client

		AUTH_URI   = 'https://accounts.google.com/o/oauth2/auth'
		TOKEN_URI  = 'https://accounts.google.com/o/oauth2/token'
		UPLOAD_URI = 'https://www.googleapis.com/upload/drive/v2/files?uploadType=media'
		BASE_URI   = 'https://www.googleapis.com/drive/v2/'

		attr_accessor :access_token, :refresh_token, :redirect_uri

		attr_reader :client_id, :client_secret

		def initialize client_id, client_secret
			@client_id     = client_id
			@client_secret = client_secret
		end

		def auth_uri
			params = {
				'response_type'   => 'code',
				'client_id'       => @client_id,
				'redirect_uri'    => @redirect_uri,
				'scope'           => 'https://www.googleapis.com/auth/drive',
				'access_type'     => 'offline',
				'approval_prompt' => 'force'
			}
			AUTH_URI + '?' + Query.new(params).to_s
		end

		def callback code
			params = {
				code:          code,
				client_id:     @client_id,
				client_secret: @client_secret,
				redirect_uri:  @redirect_uri,
				grant_type:    'authorization_code'
			}
			http = Curl.post TOKEN_URI, params
			res = Response.new http
			@access_token = res.data[:access_token]
			@refresh_token = res.data[:refresh_token]
		end

		def merge_params
			
		end

		def renew_token refresh_token
			params = {
				client_id:     @client_id,
				client_secret: @client_secret,
				refresh_token: refresh_token,
				grant_type:    'refresh_token'
			}
			http = Curl.post TOKEN_URI, params
			res = Response.new http
			@access_token = res.data[:access_token]
		end

		def about
			get 'about'
		end

		def upload body, mime = 'text/plain'
			headers = {
				'Content-Type' => mime
			}

			http = Curl.post UPLOAD_URI, body do |curl|
				curl.headers = merge_headers(headers)
			end

			Response.new(http).data[:id]
		end

		def post endpoint, body, headers = {}
			curl = Curl.post uri(endpoint), body do |curl|
				curl.headers = merge_headers headers
			end
			Response.new(curl).data
		end

		def get endpoint
			res = Curl.get uri(endpoint) do |g|
				g.headers['authorization'] = "Bearer #{@access_token}"
			end
			Response.new(res).data
		end

		def insert file_id, folder
			endpoint = "files/#{folder}/children"
			body = '{"id":"' + file_id +'"}'
			post endpoint, body
		end

		def merge_headers hash = {}
			({
				'authorization' => "Bearer #{@access_token}",
				'Content-Type' => 'application/json'
			}).merge hash
		end

		def file id
			get "files/#{id}"
		end

		def thumbnail id
			file(id)[:thumbnailLink]
		end

		private

		def uri endpoint
			"https://www.googleapis.com/drive/v2/#{endpoint}"
		end
		
	end
end