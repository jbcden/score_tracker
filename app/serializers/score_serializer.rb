class ScoreSerializer < ActiveModel::Serializer
  attributes :player, :score, :time

  def time
    object.time.iso8601
  end
end
