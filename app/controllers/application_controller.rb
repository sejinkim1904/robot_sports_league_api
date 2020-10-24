class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, secret)
  end

  def secret
    Rails.application.credentials.secret_key_base
  end
end
