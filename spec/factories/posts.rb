# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    published { false }
    user
    content { 'Amazing content' }
    title { 'Authorization blog :trol:' }
  end
end
