require 'jwt'
class JsonWebToken
  def self.decode(token) 
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0] 
  rescue JWT::ExpiredSignature, JWT::DecodeError => e
    puts e.inspect
    raise InvalidToken, e.message
  end

  def self.encode(payload, exp = 8.hours.from_now) 
    payload[:exp] = exp.to_i 
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end

class InvalidToken < StandardError; end