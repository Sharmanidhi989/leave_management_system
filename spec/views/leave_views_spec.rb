# require 'spec_helper'
# require 'capybara/rspec'

# feature 'creating a new leave', type: :feature do
#   background do
#     Employee.create(email: 'employee@example.com', password: 'caplin')
#   end
  
#   # positive test cases

#   scenario 'it visits index of leave' do
#     visit leaves_path
#     fill_in 'Email', with: 'employee@example.com'
#     fill_in 'Password', with: 'caplin'
#     click_button 'Log in'
#     visit leaves_path
#     expect(page).to have_content 'Summary'
#   end

#   scenario 'it visits show of @leave' do
#     @employee = create(:employee)
#     @leave_quotum = create(:leave_quotum)
#     @leave = create(:leave)
#     visit leave_path(@leave)
#     fill_in 'Email', with: 'employee@example.com'
#     fill_in 'Password', with: 'caplin'
#     click_button 'Log in'
#     expect(page).to have_content 'Leave Status'
#   end

#   scenario 'Applying for Cancellation' do
#     @employee = create(:employee)
#     @leave_quotum = create(:leave_quotum)
#     @leave = create(:leave)
#     visit edit_leave_path(@leave)
#     fill_in 'Email', with: 'employee@example.com'
#     fill_in 'Password', with: 'caplin'
#     click_button 'Log in'
#     fill_in 'Reason' , with: 'very sick'
#     click_button 'Update Leave' 
#     expect(page).to have_content 'Leave Status'
#   end
  
#   scenario 'Applying for a leave' do
#     visit new_leave_path
#     @employee = create(:employee)
#     @leave_quotum = create(:leave_quotum)
#     fill_in 'Email', with: @employee.email
#     fill_in 'Password', with: @employee.password
#     click_button 'Log in'
#     find_field('leave_leave_quotum_id').find("option[value='1']").text
#     fill_in 'From', with: '12/12/2019'
#     fill_in 'To', with: '12/12/2019'
#     fill_in 'Reason', with: 'Very Sick'
#     click_button 'Create Leave'
#     expect(page).to have_content 'Leave Status'
#   end

#   # negative test cases
#   scenario 'Applying for a leave without proper values' do
#     visit new_leave_path
#     @employee = create(:employee)
#     @leave_quotum = create(:leave_quotum)
#     fill_in 'Email', with: @employee.email
#     fill_in 'Password', with: @employee.password
#     click_button 'Log in'
#     find_field('leave_leave_quotum_id').find("option[value='1']").text
#     fill_in 'From', with: '12/12/2019'
#     fill_in 'To', with: '11/11/2019'
#     fill_in 'Reason', with: ''
#     click_button 'Create Leave'
#     expect(page).to have_content 'errors prohibited this leave from being saved'
#   end
# end