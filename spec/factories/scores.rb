FactoryBot.define do
  factory :score do
    sequence :player do |n|
      "test#{n}"
    end
    score { rand(1..100) }
    time { Time.now }
  end
end
