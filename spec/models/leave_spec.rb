require 'rails_helper'
RSpec.describe Leave, type: :model do
  let(:employee) { create(:employee) }
  let(:leave_quotum) { create(:leave_quotum) }

  it 'is valid with attributes' do
    leave = employee.leaves.create(to: '09/07/2039',
                                   from: '07/07/2039',
                                   reason: 'not feeling well',
                                   leave_quotum_id: leave_quotum.id)
    expect(leave).to be_valid
  end

  # negative test cases

  # for associations

  it 'is invalid without an employee_id' do
    employee = create(:employee)
    leave_quotum = create(:leave_quotum)
    leave = Leave.create(to: '07/07/2019',
                         from: '07/07/2019',
                         reason: 'not feeling well',
                         leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it 'is invalid without a leave quota' do
    leave = employee.leaves.create(to: '07/07/2019',
                                   from: '07/07/2019',
                                   reason: 'not feeling well')
    expect(leave).to_not be_valid
  end

  # for validations

  it 'is invalid without to date' do
    leave = employee.leaves.create(from: '07/07/2039',
                                   reason: 'not feeling well',
                                   leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it 'is invalid without from date' do
    leave = employee.leaves.create(to: '07/07/2039',
                                   reason: 'not feeling well',
                                   leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it 'is invalid without a reason' do
    leave = employee.leaves.create(to: '07/07/2039',
                                   from: '07/07/2039',
                                   leave_quotum_id: leave_quotum.id)
    expect(leave).to_not be_valid
  end

  it 'is invalid for negative no of days' do
    leave = employee.leaves.create(to: '05/05/2039',
                                   from: '06/06/2049',
                                   leave_quotum_id: leave_quotum.id,
                                   reason: 'very sick')
    expect(leave).to_not be_valid
  end

  # callbacks
  it 'should update the leave count if approved' do
    leave = employee.leaves.create(from: '2039-04-25',
                                   to: '2039-04-27',
                                   leave_quotum_id: leave_quotum.id,
                                   reason: 'very sick')
    leave.status = 1
    leave.save!
    puts leave.leave_quotum.count
  end

  it 'should update the leave count if cancelled' do
    leave = employee.leaves.create(from: '2039-04-25',
                                   to: '2039-04-27',
                                   leave_quotum_id: leave_quotum.id,
                                   reason: 'very sick')
    leave.status = 2
    leave.save!
    puts leave.leave_quotum.count
  end
end
