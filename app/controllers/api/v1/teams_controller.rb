module Api
  module V1
    class TeamsController < ApplicationController
      def create
        team = Team.new(team_params)

        if team.save
          render json: TeamSerializer.new(team), status: :created
        else
          render json: {
            error: team.errors.full_messages.to_sentence
          }, status: :bad_request
        end
      end

      private

      def team_params
        params.permit(
          :email,
          :password,
          :password_confirmation,
          :team_name
        )
      end
    end
  end
end
