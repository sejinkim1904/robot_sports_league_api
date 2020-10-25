module Api
  module V1
    class TeamsController < ApplicationController
      skip_before_action :require_login, only: [:create]

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

      def update
        if @team.update(team_params)
          render json: TeamSerializer.new(@team), status: :ok
        else
          render json: {
            error: @team.errors.full_messages.to_sentence
          }, status: :conflict
        end
      end

      private

      def team_params
        params.permit(
          :email,
          :password,
          :password_confirmation,
          :name
        )
      end
    end
  end
end
