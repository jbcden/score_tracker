# frozen_string_literal: true

class PlayerHistorySerializer < ActiveModel::Serializer
  attributes :top_score, :low_score

  attribute :average_score do
    object.average_score.to_f
  end

  has_many :scores
end
