module Api
  module V1
    module Teams
      class RostersController < ApplicationController
        def generate_roster
          if current_team.bots.present?
            current_team.delete_roster if current_team.current_roster.present?
            current_team.generate_roster

            render json: RosterSerializer.new(current_team.current_roster),
                   status: :created
          else
            render json: { error: 'Please generate bots' }, status: :conflict
          end
        end

        def index
          render json: RosterSerializer.new(current_team.current_roster),
                 status: :ok
        end

        def create
          if current_team.current_roster.empty?
            current_team.rosters.appoint_roles(
              params['starters'],
              params['alternates']
            )

            render json: RosterSerializer.new(current_team.current_roster),
                   status: :created
          else
            render json: { error: 'Roster already exists' }, status: :conflict
          end
        end

        def update
          current_team.delete_roster
          current_team.rosters.appoint_roles(
            params['starters'],
            params['alternates']
          )

          render json: RosterSerializer.new(current_team.current_roster),
                 status: :ok
        end

        def destroy
          current_team.delete_roster

          render json: { message: 'Roster has been deleted.' }, status: :ok
        end
      end
    end
  end
end
