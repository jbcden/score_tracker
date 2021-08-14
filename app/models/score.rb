# frozen_string_literal: true

class Score < ApplicationRecord
  validates_presence_of :player, :score, :time
  validates :score, numericality: { greater_than: 0 }

  scope :after, ->(after_date) do
    where('time > ?', after_date.end_of_day)
  end
end
