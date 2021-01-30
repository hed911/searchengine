FactoryBot.define do
  factory :text do
    value { "" }
  end
  factory :short_text, parent: :text do
    value { CGI.escape(Faker::Alphanumeric.alphanumeric(number: 2))  }
  end
  factory :long_text, parent: :text do
    value { CGI.escape(Faker::JapaneseMedia::Naruto.character)  }
  end
end
