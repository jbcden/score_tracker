# frozen_string_literal: true

class PlayerHistory
  attr_reader :player

  include ActiveModel::Serialization

  def self.model_name
    'player_history'
  end

  def initialize(player)
    @player = player
  end

  def exists?
    scores.exists?
  end

  def top_score
    scores.maximum(:score)
  end

  def low_score
    scores.minimum(:score)
  end

  def average_score
    scores.average(:score)
  end

  def scores
    @scores ||= Score.where(player: player)
  end
end
