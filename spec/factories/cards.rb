FactoryGirl.define do
  factory :card do
    original_text "Test"
    translated_text "Тест"
    user
    deck
  end
end
