require 'spec_helper'
require 'capybara/rails'

feature "Signing in" do
  background do
    Employee.create(email: 'employee@example.com', password: 'caplin')
  end

  # positive test cases
  scenario "Signing in with correct credentials" do
    visit new_employee_session_path
    within("form") do
      fill_in 'Email', with: 'employee@example.com'
      fill_in 'Password', with: 'caplin'
    end
    click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end

  scenario "Logging out" do
    visit new_employee_session_path
    within("form") do
      fill_in 'Email', with: 'employee@example.com'
      fill_in 'Password', with: 'caplin'
    end
    click_button 'Log in'
    click_link 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end
  
  # negative test cases
  scenario "Signing in with incorrect credentials" do
    visit new_employee_session_path
    within("form") do
      fill_in 'Email', with: 'employee@example.com'
      fill_in 'Password', with: 'caplin@12233333'
    end
    click_button 'Log in'
    expect(page).to have_content 'Log in'
  end
end

feature "Reseting password" do

  scenario 'it should send reset password instructions' do
      employee = Employee.create(email: 'one@example.com', password: '123456')
      visit new_employee_session_path

      click_link 'Forgot your password?'
      fill_in 'Email', with: employee.email

      expect do
        click_button 'Send me reset password instructions'
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end

feature "Update Settings" do
  background do
    Employee.create(email: 'example@example.com', password: '123456')
  end
  # positive test case
  scenario 'it should update the employee profile' do
    visit new_employee_session_path
    within("form") do
      fill_in 'Email', with: 'example@example.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    click_link 'Settings'
    visit edit_employee_registration_path
    fill_in 'First name', with: 'Nidhi'
    fill_in 'Last name', with: 'Sharma'
    fill_in 'Current password', with: '123456'
    click_button 'Update'
    expect(page).to have_content 'Your account has been updated successfully.'
  end

  # negative test case
  scenario 'it should not update the employee profile' do
    visit new_employee_session_path
    within("form") do
      fill_in 'Email', with: 'example@example.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    click_link 'Settings'
    visit edit_employee_registration_path
    fill_in 'First name', with: 'Nidhi'
    fill_in 'Last name', with: 'Sharma'
    fill_in 'Current password', with: '123456wweqweqweq'
    click_button 'Update'
    expect(page).to have_content 'Current password is invalid'
  end
end
