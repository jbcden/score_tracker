# frozen_string_literal: true

module Api::V1
  class ScoresController < ApplicationController
    before_action :validate_datetime_params, only: [:create, :index]

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
      scores = scores.players(params[:players]) if params[:players]
      scores = scores.page(params.fetch(:page, 0)).per(params.fetch(:per, 20))

      render json: scores, status: :ok
    end

    private

    def score_params
      params.permit(:player, :score, :time)
    end

    def validate_datetime_params
      [:after, :before, :time].each do |param|
        if params[param]
          DateTime.iso8601(params[param])
        end
      end

    rescue ArgumentError
      render json: { errors: 'time must be iso8601 compliant' }, status: :unprocessable_entity
    end
  end
end
