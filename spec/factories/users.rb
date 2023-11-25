FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname              { Faker::Name.initials(number: 5) }
    email                 { Faker::Internet.email }
    password              { 'a3' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
    birthday              { Faker::Date.backward }
  end
end
