FactoryBot.define do
  factory :leave_quotum do
    id { '1' }
    employee_id { '11' }
    leave_category { 'paid leave' }
    count { '5' }
  end
end
