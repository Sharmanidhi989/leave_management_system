class LeavesController < ApplicationController
  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.create(leave_params)
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
      params.require(:leave).permit(:status, :employee_id, :to, :from, :reason, :category)
    end
end
