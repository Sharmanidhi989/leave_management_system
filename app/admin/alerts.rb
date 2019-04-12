ActiveAdmin.register Alert do
  permit_params :name, :employee_id

  form do |f|
      f.inputs 'Details' do
        f.input :name
        f.input :employee, :as => :select, :collection => Employee.all.collect {|employee| [ employee.email, employee.id] }
      end
    f.actions
  end

  controller do
    def create
      @alert = Alert.new(alert_params)
      if @alert.save
        redirect_to admin_alerts_path
      else
        redirect_to new_admin_alerts_path
      end
      ActionCable.server.broadcast 'web_notifications_channel', notification: @alert.name, employee_id: @alert.employee_id
    end

    def alert_params
      params[:alert].permit(:name, :employee_id)
    end
  end
end
