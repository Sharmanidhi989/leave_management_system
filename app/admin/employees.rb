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
  
  action_item do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end 
  
  collection_action :send_invitation, :method => :post do
    @employee = Employee.invite!(params[:employee], current_employee)
    if @employee.errors.empty?
      flash[:success] = "employee has been successfully invited." 
      redirect_to admin_employees_path
    else
      messages = @employee.errors.full_messages.map { |msg| msg }.join
      flash[:error] = "Error: " + messages
      redirect_to new_invitation_admin_employees_path
    end
  end
end
