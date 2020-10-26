module Api
  module V1
    module Teams
      class BotsController < ApplicationController
        def create
          if current_team.bots.empty?
            render json: BotSerializer.new(current_team.generate_bots),
                   status: :created
          else
            render json: { error: 'Bots already generated' }, status: :conflict
          end
        end

        def index
          render json: BotSerializer.new(current_team.bots), status: :ok
        end
      end
    end
  end
end
