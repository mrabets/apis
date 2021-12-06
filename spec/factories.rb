FactoryBot.define do
  factory :user, class: User do
    username { "example1" }
    password { "example1" }
  end

  factory :photo, class: Photo do
    name { "My photo" }
    user factory: :user, username: "myexample"
  end
end