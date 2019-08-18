FactoryBot.define do
  factory :todo do
    title { "My Factory Title" }
    body { "My Facrory Text" }
    user { nil }
  end
end
