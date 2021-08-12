# frozen_string_literal: true

module Api::V1
  class ScoresController < ApplicationController
    def create
      score = Score.new(score_params)

      if score.save
        render json: score, status: :ok
      else
        errors = score.errors.full_messages.join(', ')
        render json: { errors: errors }, status: :bad_request
      end
    end

    private

    def score_params
      params.permit(:player, :score, :time)
    end
  end
end
