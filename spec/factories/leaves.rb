FactoryBot.define do
  factory :leave do
    id { '4' }
    employee_id { '11' }
    to { '09/07/2019' }
    from { '07/07/2019' }
    reason { 'not feeling well' }
    leave_quotum_id { '1' }
  end
end
