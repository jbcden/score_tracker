# frozen_string_literal: true

class Score < ApplicationRecord
  validates_presence_of :player, :score, :time
  validates :score, numericality: { greater_than: 0 }
end
