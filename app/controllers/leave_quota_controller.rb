class LeaveQuotaController < ApplicationController
  def index
    @leave_quota = LeaveQuotum.all.where(employee_id: current_employee.id)
  end
end
