FactoryBot.define do
  factory :user do
    nickname              {"suzuki"}
    email                 {"suzuki@gmail.com"}
    password              {"suzuki1990"}
    password_confirmation {"suzuki1990"}
    last_name             {"鈴木"}
    first_name            {"太一"}
    last_name_kana        {"スズキ"}
    first_name_kana       {"タイチ"}
    birthday              {"1990-05-15"}
  end
end