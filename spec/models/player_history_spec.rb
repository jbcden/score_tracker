# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerHistory do
  describe '#exists?' do
    context 'when the player does not exist' do
      it 'returns false' do
        history = PlayerHistory.new("doesNotExist")

        expect(history.exists?).to be_falsey
      end
    end

    context 'when the player exists' do
      it 'returns true' do
        create(:score, player: 'tester')

        history = PlayerHistory.new('tester')

        expect(history.exists?).to be_truthy
      end
    end
  end

  describe '#top_score' do
    it 'returns the top score achieved by a player' do
      create(:score, player: 'tester', score: 1)
      create(:score, player: 'tester', score: 5)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 10)

      history = PlayerHistory.new('tester')

      expect(history.top_score).to eq(10)
    end
  end

  describe '#low_score' do
    it 'returns the lowest score achieved by a player' do
      create(:score, player: 'tester', score: 1)
      create(:score, player: 'tester', score: 5)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 10)

      history = PlayerHistory.new('tester')

      expect(history.low_score).to eq(1)
    end
  end

  describe '#average_score' do
    it 'returns the average score achieved by a player' do
      create(:score, player: 'tester', score: 1)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 5)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 10)

      history = PlayerHistory.new('tester')

      expect(history.average_score).to eq(4)
    end
  end

  describe '#scores' do
    it 'returns all of the scores of a player' do
      create(:score, player: 'tester', score: 1)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 5)
      create(:score, player: 'tester', score: 2)
      create(:score, player: 'tester', score: 10)

      history = PlayerHistory.new('tester')

      expect(history.scores.size).to eq(5)
    end
  end
end
