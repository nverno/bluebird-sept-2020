FactoryBot.define do
  factory :user do
    username { Faker::Movies::HarryPotter.character }
    password { 'password' }
    age { 42 }
    political_affiliation { Faker::Movies::HarryPotter.house }

    factory :Harry_Potter do
      username { "Harry Potter" }
      # password { 'password' }
      # age { 42 }
      # political_affiliation { Faker::Movies::HarryPotter.house }
    end
  end
end
