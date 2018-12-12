FactoryBot.define do
  factory :user do
    email { "MyString" }
  end
  factory :item do
    description { "MyString" }
  end
   
    factory :list do
        name { "Shopping List" }
    end

end