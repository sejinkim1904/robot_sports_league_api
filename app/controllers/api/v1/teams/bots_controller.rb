module Api
  module V1
    module Teams
      class BotsController < ApplicationController
        def create
          if @team.bots.empty?
            render json: BotSerializer.new(@team.generate_bots),
                   status: :created
          else
            render json: { error: 'Bots already generated' }, status: :conflict
          end
        end

        def index
          render json: BotSerializer.new(@team.bots), status: :ok
        end
      end
    end
  end
end
