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

    def index
      scores = Score.all
      scores = scores.after(DateTime.iso8601(params[:after])) if params[:after]
      scores = scores.before(DateTime.iso8601(params[:before])) if params[:before]

      render json: scores, status: :ok
    end

    private

    def score_params
      params.permit(:player, :score, :time)
    end
  end
end
