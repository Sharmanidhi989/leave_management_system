ActiveAdmin.register Employee do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :email, :first_name, :last_name, :department, :designation, :gender, :date_of_birth, :salary, :password, :password_confirmation, :registration_id

  index do
    selectable_column
    id_column
    column :email
    column :registration_id
    column :verified
    column :created_at
    actions
  end

  form title: 'Employee' do |f|
    inputs 'Details' do
      input :email
      input :first_name
      input :last_name
      input :department
      input :designation
      input :gender
      input :date_of_birth
      input :salary
      input :password
      input :password_confirmation
    end
    actions
  end
end
