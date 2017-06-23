shared_context "initialized client" do
  let(:authorization_token) { "78a8ca4e934b6147556c3a793e2ecce53e50a718bac21f7a178b3d4d6a1b257804028bf000b2514af3bcdebd091a1659f26c335aea34d71a81cf376c3d8402b0" }

  before do
    Telleroo.configure do |config|
      config.authorization_token = authorization_token
    end
  end

  let(:client) { Telleroo::Client.new }
end
