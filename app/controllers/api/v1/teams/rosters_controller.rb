module Api
  module V1
    module Teams
      class RostersController < ApplicationController
        def generate_roster
          if @team.bots.present?
            @team.delete_roster if @team.current_roster.present?
            @team.generate_roster

            render json: RosterSerializer.new(@team.current_roster),
                   status: :created
          else
            render json: { error: 'Please generate bots' }, status: :conflict
          end
        end

        def index
          render json: RosterSerializer.new(@team.current_roster), status: :ok
        end

        def create
          if @team.current_roster.empty?
            @team.rosters.appoint_roles(
              params['starters'],
              params['alternates']
            )

            render json: RosterSerializer.new(@team.current_roster),
                   status: :created
          else
            render json: { error: 'Roster already exists' }, status: :conflict
          end
        end

        def update
          @team.delete_roster
          @team.rosters.appoint_roles(
            params['starters'],
            params['alternates']
          )

          render json: RosterSerializer.new(@team.current_roster),
                 status: :ok
        end

        def destroy
          @team.delete_roster

          render json: { message: 'Roster has been deleted.' }, status: :ok
        end
      end
    end
  end
end
