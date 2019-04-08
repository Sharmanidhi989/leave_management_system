FactoryBot.define do
  factory :employee do
    first_name { 'Jane' }
    last_name  { 'Doe' }
    email {'jane@example.com'}
    password  { '123456' }
    id { '1' }
  end
end

FactoryBot.define do
  factory :leave do
    id {'4'}
    employee_id {'1'}
    to {'09/07/2019'}
    from {'07/07/2019'}
    reason {'not feeling well'}
    leave_quotum_id {'1'}
  end
end

FactoryBot.define do
  factory :leave_quotum do
  id { '1' }
  employee_id {'1'}
  leave_category {'paid leave'}
  count {'5'}
  end
end
