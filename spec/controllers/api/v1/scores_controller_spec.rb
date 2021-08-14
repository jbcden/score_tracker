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

  describe 'GET #show' do
    context 'when the score does not exist' do
      it 'returns a 404 response' do
        get :show, params: { id: 9999 }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the score exists' do
      it 'returns the score' do
        score = create(:score, player: 'tester', score: 150, time: 1.hour.ago)

        get :show, params: { id: score.id }
        parsed_response = JSON.parse(response.body)['score']

        expect(response).to have_http_status(:success)

        expect(parsed_response['score']).to eq(score.score)
        expect(parsed_response['player']).to eq(score.player)
        expect(parsed_response['time']).to eq(score.time.iso8601)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the record does not exist' do
      it 'returns a 404' do
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the record exists' do
      it 'returns a 200' do
        score = create(:score)

        delete :destroy, params: { id: score.id }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #index' do
    context 'when no matching data exists' do
      it 'returns an empty array of scores' do
        get :index, params: { player: 'doesNotExist' }

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['scores']).to be_empty
      end
    end

    context 'when data exists' do
      it 'returns all players when no additional filters are provided' do
        create_list(:score, 10)

        get :index

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['scores'].size).to eq(10)
      end

      it 'can be filtered by time' do
        january_2020 = create(:score, player: '2020', time: '2020-01-01')
        january_2021 = create(:score, player: '2021', time: '2021-01-01')

        get :index, params: { after: '2020-01-01' }

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['scores'].size).to eq(1)
        players = parsed_response['scores'].map { |score| score['player'] }
        expect(players).to include(january_2021.player)

        get :index, params: { before: '2021-01-01' }

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['scores'].size).to eq(1)
        players = parsed_response['scores'].map { |score| score['player'] }
        expect(players).to include(january_2020.player)

        create(:score, player: '2019', time: '2019-01-01')

        get :index, params: { after: '2019-12-31', before: '2021-01-02' }

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed_response['scores'].size).to eq(2)
        players = parsed_response['scores'].map { |score| score['player'] }
        expect(players).to include(january_2020.player)
        expect(players).to include(january_2021.player)
      end
      end
    end
  end
end
