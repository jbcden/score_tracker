# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ScoresController do
  describe 'POST #create' do
    context 'when requried fields are missing' do
      it 'fails to create the score' do
        before_count = Score.count

        post :create, params: { player: 'test', score: 1 }

        expect(response).to have_http_status(:bad_request)
        expect(Score.count).to eq(before_count)
      end
    end
  end
end
