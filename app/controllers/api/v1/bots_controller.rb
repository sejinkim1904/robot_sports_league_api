module Api
  module V1
    class BotsController < ApplicationController
      def create
        bots = @team.generate_bots

        if bots
          render json: BotSerializer.new(bots), status: :created
        else
          render json: bots.errors.full_messages.to_sentence
        end
      end
    end
  end
end
