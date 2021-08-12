# frozen_string_literal: true

module Api::V1
  class ScoresController < ApplicationController
    def create
      render json: {}, status: :bad_request
    end
  end
end
