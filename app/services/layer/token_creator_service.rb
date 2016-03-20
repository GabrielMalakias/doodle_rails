class Layer::TokenCreatorService
  def initialize(login)
    @login = login
  end

  def token
    client = Layer::Client.authenticate do |nonce|
      Layer::IdentityToken.new(@login, nonce)
    end
    client.token
  end

end
