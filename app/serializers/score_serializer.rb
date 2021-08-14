class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :player, :score, :time

  def time
    object.time.iso8601
  end
end
