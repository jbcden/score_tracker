# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PlayerHistoriesController do
  describe 'GET #show' do
    context 'when the requested player does not exist' do
      it 'returns a 404' do
        get :show, params: { id: 'doesNotExist' }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the player exists' do
      it 'will return a summary of the history of the player' do
        create(:score, player: 'tester', score: 1)
        create(:score, player: 'tester', score: 2)
        create(:score, player: 'tester', score: 5)
        create(:score, player: 'tester', score: 2)
        create(:score, player: 'tester', score: 10)

        get :show, params: { id: 'tester' }

        parsed_response = JSON.parse(response.body)['player_history']

        expect(response).to have_http_status(:ok)
        expect(parsed_response['top_score']).to eq(10)
        expect(parsed_response['low_score']).to eq(1)
        expect(parsed_response['average_score']).to eq(4.0)
        expect(parsed_response['scores'].size).to eq(5)
      end
    end
  end
end
