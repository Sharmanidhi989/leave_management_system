class LeavesController < ApplicationController
  before_action :authenticate_employee!

  def index
    @leaves = Leave.all.where(employee_id: current_employee.id)
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.create(leave_params)
    @leave.employee_id = current_employee.id
    if @leave.save
      redirect_to @leave
    else
      render 'new'
    end
  end

  def show
    @leave = Leave.find(params[:id])
  end

  private
    def leave_params
      params.require(:leave).permit(:status, :to, :from, :reason, :category)
    end
end
