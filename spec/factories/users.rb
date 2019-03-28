# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'user@gmail.com' }
    password { 'q1wer21sdf6' }
  end
end
