FactoryBot.define do
  factory :employee do
    first_name { 'Jane' }
    last_name  { 'Doe' }
    email { 'jane@example.com' }
    password { '123456' }
    id { '11' }
  end
end
