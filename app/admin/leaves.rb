ActiveAdmin.register Leave do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :employee_id, :status, :to, :from, :leave_quotum_id, :reason

  form title: 'Leave' do |f|
    inputs 'Details' do
      input :reason, input_html: { disabled: true }
      input :from, input_html: { disabled: true }
      input :to, input_html: { disabled: true }
      input :status
    end
    actions
  end
  controller do
    def update
      @leave = Leave.find(params[:id])
      if @leave.update(leave_params)
        if @leave.approved?
        LeaveMailer.approved_email(@leave).deliver_now
      end
      if @leave.canceled?
        LeaveMailer.canceled_leave(@leave).deliver_now
      end
        redirect_to admin_leave_path(@leave)
      else
        render 'edit'
      end
    end

    def leave_params
      params[:leave].permit(:employee_id, :status, :to, :from, :leave_quotum_id, :reason, :id)
    end
  end
end
