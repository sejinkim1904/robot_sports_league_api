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

        # After creating custom validators and coming to this controller to
        # update, I discovered using #update_all doesn't trigger ActiveRecord
        # callbacks or validations.

        # It also felt weird having a create action when it really isn't
        # creating any records since a bot being on a "Roster" is defined by
        # their role on the roster record. The update and create actions we're
        # essentially doing the same thing. For this reason I think we only
        # need an update action.

        # def create
        #   if current_team.current_roster.empty?
        #     current_team.rosters.appoint_roles(
        #       params['starters'],
        #       params['alternates']
        #     )

        #     render json: RosterSerializer.new(current_team.current_roster),
        #            status: :created
        #   else
        #     render json: { error: 'Roster already exists' }, status: :conflict
        #   end
        # end

        # def update
        #   current_team.delete_roster
        #   updated_roster = current_team.rosters.appoint_roles(
        #     params['starters'],
        #     params['alternates']
        #   )

        #   if updated_roster
        #     render json: RosterSerializer.new(updated_roster),
        #            status: :ok
        #   else
        #     render json: {
        #       error: updated_roster.errors.full_messages.to_sentence
        #     }, status: :conflict
        #   end
        # end

        def update
          roster = current_team.rosters.find(params[:id])

          if roster.update(roster_params)
            render json: RosterSerializer.new(roster), status: :ok
          else
            render json: {
              error: roster.errors.full_messages.to_sentence
            }, status: :conflict
          end
        end

        def destroy
          current_team.delete_roster

          render json: { message: 'Roster has been deleted.' }, status: :ok
        end

        private

        def roster_params
          params.permit(:role)
        end
      end
    end
  end
end
