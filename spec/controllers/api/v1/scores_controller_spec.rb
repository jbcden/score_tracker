# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ScoresController do
  describe 'POST #create' do
    context 'errors' do
      it 'fails to create the score when required fields are missing' do
        before_count = Score.count

        post :create, params: { player: 'test', score: 1 }
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        # NOTE: this could be handled differently if using translations
        # maybe improve format -- currently doesn't handle multiple errors well
        expect(parsed_response['errors']).to include("can't be blank")
        expect(Score.count).to eq(before_count)
      end

      it 'fails to create the score when the score is invalid' do
        before_count = Score.count

        post :create, params: { player: 'test', score: 0, time: '2021-08-12T09:46:00Z' }
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['errors']).to include('must be greater than 0')
        expect(Score.count).to eq(before_count)
      end
    end

    it 'creates a score' do
      before_count = Score.count

      post :create, params: { player: 'test', score: 1, time: '2021-08-12T09:46:00Z' }

      expect(response).to have_http_status(:success)
      expect(Score.count).to eq(before_count + 1)
    end
  end
end
