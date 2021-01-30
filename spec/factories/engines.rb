FactoryBot.define do
  factory :engine do
    name { "" }
  end
  factory :google_engine, parent: :engine do
    name { "google" }
  end
  factory :bing_engine, parent: :engine do
    name { "bing" }
  end
  factory :yahoo_engine, parent: :engine do
    name { "yahoo" }
  end
end
