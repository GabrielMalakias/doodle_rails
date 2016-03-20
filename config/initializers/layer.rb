Layer::Client.configure do |config|
  config.app_id = "layer:///apps/staging/151aa76a-ce72-11e5-ac55-80e4720f6b18"
  config.token = "H6EvCKXyPpXuQtBDU07TdgLguNMatEQcOKBmQqpJTVsg5Gdj"
end

Layer::IdentityToken.layer_provider_id = "layer:///providers/1519612a-ce72-11e5-ac55-80e4720f6b18"
Layer::IdentityToken.layer_key_id = "layer:///keys/0ff36abc-d0d2-11e5-b2af-61c9960f423b"

key = File.readlines("#{Rails.root}/config/private_key.pem").join('')
Layer::IdentityToken.layer_private_key = OpenSSL::PKey::RSA.new(key)


