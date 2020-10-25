class ApplicationController < ActionController::API
  before_action :require_login

  def encode_token(payload)
    JWT.encode(payload, secret, algorithm)
  end

  def secret
    Rails.application.credentials.secret_key_base
  end

  def algorithm
    'HS256'
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    token = auth_header.split(' ')[1] if auth_header
    begin
      JWT.decode(token, secret, true, algorithm: algorithm)
    rescue JWT::DecodeError
      []
    end
  end

  def session_team
    return unless decode_token.present?

    team_id = decode_token[0]['team_id']
    @team = Team.find(team_id)
  end

  def logged_in?
    !!session_team
  end

  def require_login
    render json: { error: 'Please Login' }, status: :unauthorized unless logged_in?
  end
end
