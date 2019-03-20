ActiveAdmin.register Leave do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :employee_id, :status, :to, :from, :leave_quotum_id

  form title: 'Leave' do |f|
    inputs 'Details' do
      input :status
    end
    actions
  end
end
