FactoryGirl.define do
  factory :user do
    provider "github"
    sequence(:uid) { |n| "#{n}" }
    sequence(:email) { |n| "#{n}"}
    sequence(:password) { |n| "#{n}"}
  end
end
