ActiveAdmin.register Employee do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :email, :first_name, :last_name, :department, :designation, :gender, :date_of_birth, :salary

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
    end
    actions
  end

  controller do
    def create
      @employee = Employee.new(employee_params)
      if @employee.email_valid?
        Employee.invite!(employee_params)
        redirect_to admin_employees_path
      else
        redirect_to new_admin_employee_path
      end
    end

    def employee_params
      params[:employee].permit(:email, :first_name, :last_name, :department, :designation, :gender, :date_of_birth, :salary)
    end
  end
end
