require 'DriveClient'

describe DriveClient::Client do

	before(:each) do
		@dc = DriveClient::Client.new '1081667172958-ajbselflij2h4kdcapsfv9nakd6s4ls9.apps.googleusercontent.com', 'UV5WLrjfe0DSJQ6spCO8lBcN'
		@dc.access_token = 'ya29.1.AADtN_Vif6DZ5vnxQFzaxZLZjpYGA6dUgwTIFsbwkvAC7us-cnQaiAJjC8Ktz_c'
		@dc.redirect_uri = 'http://localhost'
	end

	it 'client id get set and is accessable' do
		@dc.client_id.should eql('1081667172958-ajbselflij2h4kdcapsfv9nakd6s4ls9.apps.googleusercontent.com')
	end

	it 'client secret get set and is accessable' do
		@dc.client_secret.should eql('UV5WLrjfe0DSJQ6spCO8lBcN')
	end

	it 'auth_uri is right' do
		@dc.redirect_uri = 'http://localhost'
		uri = 'https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=1081667172958-ajbselflij2h4kdcapsfv9nakd6s4ls9.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&access_type=offline&approval_prompt=force'
		@dc.auth_uri.should eql(uri) 
	end

=begin
	it 'callback' do
		p @dc.auth_uri
		p 'code: '
		code = gets.chomp
		@dc.callback(code)
		p @dc.refresh_token
		@dc.access_token.should eql('foo')
	end
=end

=begin	
	it 'renew' do
		refresh_token = '1/ZnSmWXke4gatqQI9iPx1ZIiOTmnowqR4_KnZkkqsMVg'
		redirect_uri = 'http://localhost'
		@dc.redirect_uri = redirect_uri
		access_token = @dc.renew_token refresh_token
		p "Refreshed Token is #{access_token}"
		access_token.length.should eq(70)
	end
=end

#=begin
	it 'upload' do
		id = @dc.upload 'Hallo das ist eine Test Datei!'
		id.length.should eq(28)
	end
#=end

=begin
	it 'ul img' do
		id = @dc.upload IO.read('mila.gif'), 'image/gif'
		p "Image ID: #{id}"
		id.length.should eq(28)
	end
=end

	it 'about' do
		p @dc.about
	end

	it 'insert' do
		res = @dc.insert '0BwAAT9Rkk5g0a2Y3eUVkTTJobTQ', '0BwAAT9Rkk5g0MFE5RlphcXZmUGc'
		p "Insert response:"
		p res
	end

	it 'file' do
		res = @dc.file '0BwAAT9Rkk5g0a2Y3eUVkTTJobTQ'
		p "Info about file:"
		p res
	end

	it 'thumbnail' do
		p @dc.thumbnail '0BwAAT9Rkk5g0a2Y3eUVkTTJobTQ'
	end

end