FactoryGirl.define do

  factory :card do
    original_text "Test"
    translated_text "Тест"

    after(:create) do |card|
      card.update_attributes(review_date: Time.now)
    end
  end

end
