ActiveAdmin.register LeaveQuotum do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :leave_category, :count, :employee_id

  form do |f|
      f.inputs 'Details' do
        f.input :leave_category
        f.input :count, label: 'Count'
        f.input :employee, :as => :select, :collection => Employee.all.collect {|employee| [ employee.email, employee.id] }
      end
      f.actions
    end
end
