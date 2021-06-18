FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name "Aaron"
    last_name  "Sumner"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion-tights-furze"

    # Joe
    factory :user_joe, class: User do
      first_name { "Joe" }
      last_name  {"Tester"}
      email      {"joetester@example.com"}
      password   {"dottle-nouveau-pavilion-tights-furze"}
    end
  end
end
