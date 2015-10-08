FactoryGirl.define do
  sequence :email do |n|
    "u#{n}@mail.com"
  end

  factory :user do
    email
    password "123"
    password_confirmation "123"
  end
end
