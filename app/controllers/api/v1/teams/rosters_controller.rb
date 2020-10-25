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
      end
    end
  end
end
