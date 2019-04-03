require 'rails_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

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

RSpec.describe Leave, type: :model do

  # positive test cases

  it "is valid with attributes" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id , to: '09/07/2019', from: '07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to be_valid
  end

  # negative test cases

  # for associations

  it "is invalid without an employee_id" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(to: '07/07/2019', from: '07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it "is invalid without a leave quota" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id, to: '07/07/2019', from: '07/07/2019', reason: "not feeling well")
    expect(leave).to_not be_valid
  end

  # for validations
  
  it "is invalid without to date" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id ,from: '07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it "is invalid without from date" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id , to:'07/07/2019', reason: "not feeling well", leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it "is invalid without a reason" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id , to:'07/07/2019', from: '07/07/2019' , leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it "is invalid for negative no of days" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(employee_id: employee.id , to:'05/05/2019', from: '06/06/2020' , leave_quotum_id: leave_quotum.id, reason: 'very sick')
    expect(leave).to_not be_valid
  end
  
  # callbacks
  it "should update the leave count if approved" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create!(employee_id: employee.id ,from:'2019-04-25', to: '2019-04-27' , leave_quotum_id: leave_quotum.id, reason: 'very sick')
    leave.status = 1
    leave.save!
    puts leave.leave_quotum.count
  end

  it "should update the leave count if cancelled" do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create!(employee_id: employee.id ,from:'2019-04-25', to: '2019-04-27' , leave_quotum_id: leave_quotum.id, reason: 'very sick')
    leave.status = 2
    leave.save!
    puts leave.leave_quotum.count
  end
end
