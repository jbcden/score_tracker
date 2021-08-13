# frozen_string_literal: true

module Api::V1
  class ScoresController < ApplicationController
    def create
      score = Score.new(score_params)

      if score.save
        render json: score, status: :created
      else
        errors = score.errors.full_messages.join(', ')
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end

    def show
      score = Score.where(id: params[:id]).first

      if score
        render json: score, status: :ok
      else
        render json: {}, status: :not_found
      end
    end

    def destroy
      score = Score.where(id: params[:id]).first

      if score&.destroy
        render json: {}, status: :ok
      else
        render json: {}, status: :not_found
      end
    end

    private

    def score_params
      params.permit(:player, :score, :time)
    end
  end
end
