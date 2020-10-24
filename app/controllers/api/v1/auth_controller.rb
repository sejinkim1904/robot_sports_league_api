module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :require_login, only: [:login, :auto_login]
      def login
        team = Team.find_by(email: params[:email])

        if team && team.authenticate(params[:password])
          token = encode_token(team_id: team.id)

          render json: { token: token }, status: :ok
        else
          render json: {
            error: 'Your email or password is incorrect.'
          }, status: :bad_request
        end
      end

      def auto_login
        if session_team
          render json: TeamSerializer.new(session_team), status: :ok
        else
          render json: {
            error: 'No user logged in'
          }, status: :unauthorized
        end
      end
    end
  end
end
