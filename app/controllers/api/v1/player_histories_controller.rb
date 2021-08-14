# frozen_string_literal: true

module Api::V1
  class PlayerHistoriesController < ApplicationController
    def show
      player_history = PlayerHistory.new(params[:id])

      if player_history.exists?
        render json: player_history, status: :ok
      else
        render json: {}, status: :not_found
      end
    end
  end
end
