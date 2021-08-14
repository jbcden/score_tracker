class DowncasedString < ActiveRecord::Type::String
  def serialize(value)
    return nil if value.nil?
    value.to_s.downcase
  end
end
