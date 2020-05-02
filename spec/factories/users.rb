# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    password { 'q1wer21sdf6' }
    role { :writer }
  end
end
