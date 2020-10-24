module Api
  module V1
    class SessionsController < ApplicationController
      def create
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
    end
  end
end
