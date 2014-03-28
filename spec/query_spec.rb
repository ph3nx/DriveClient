require 'DriveClient'

describe DriveClient::Query do

	it 'hash is not' do
		@q = DriveClient::Query.new({'name' => 'test', 'user' => 'okay'})
		@q.to_s.should eql('name=test&user=okay')
	end

end