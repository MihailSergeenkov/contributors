FactoryBot.define do
  factory :search do
    url { 'https://github.com/rails/rails' }

    factory :other_search do
      url { 'https://github.com/airbnb/javascript' }
    end

    factory :invalid_url_search do
      url { 'https://yandex.ru/rails/rails' }
    end

    factory :invalid_search do
      url { nil }
    end
  end
end
