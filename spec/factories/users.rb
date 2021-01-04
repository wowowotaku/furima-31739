FactoryBot.define do
  factory :user do
    nickname              { 'suzuki' }
    email                 { Faker::Internet.free_email }
    password              { 'aaaaa1' }
    password_confirmation { 'aaaaa1' }
    last_name             { '鈴木' }
    first_name            { '太一' }
    last_name_kana        { 'スズキ' }
    first_name_kana       { 'タイチ' }
    birthday              { '1990-05-15' }
  end
end
