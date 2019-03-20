require 'rails_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :employee do
    first_name { 'John' }
    last_name  { 'Doe' }
    email {'emp@example.com'}
    password  { '123456' }
    id { '1' }
  end
end

FactoryBot.define do
  factory :leave_quotum do
  id { '1' }
  employee_id {'1'}
  end
end

RSpec.describe Leave, type: :model do
  
  # it "is invalid without an employee_id" do
  #   leave = Leave.create(employee_id: nil, to: '07/07/2019', from: '07/07/2019', reason: "not feeling well")
  #   expect(leave).to_not   be_valid
  # end
  
  it "is invalid without to" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create!(employee_id: employee.id , to: nil, from: '07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end
  
  it "is invalid without from" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create!(employee_id: employee.id , to:'07/07/2019', from: nil , reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  # it "is invalid without a reason" do
  #   leave = Leave.create(employee_id: '1' , to: '07/07/2019', from: nil, reason: "not feeling well")
  #   expect(leave).to_not be_valid
  # end
end