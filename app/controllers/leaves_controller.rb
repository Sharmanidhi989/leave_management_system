class LeavesController < ApplicationController
  before_action :authenticate_employee!

  def index
    @leaves = current_employee.leaves
                              .page(params[:page]).per_page(5)
    @leaves = filter_leaves(@leaves, params[:type]) if params[:type]
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @leave = Leave.new
    @leave_quota = current_employee.leave_quota
  end

  def create
    @leave = Leave.create(leave_params)
    @leave_quota = current_employee.leave_quota
    @leave.employee_id = current_employee.id
    if @leave.save
      redirect_to @leave
      LeaveMailer.apply_leave(@leave).deliver_now
    else
      render 'new'
    end
  end
  
  def edit
    @leave = Leave.find(params[:id])
  end

  def update
    @leave = Leave.find(params[:id])
    @leave.has_requested_cancellation = true
    LeaveMailer.review_leave(@leave).deliver_now
    if @leave.update(leave_params)
      redirect_to @leave
    else
      render 'edit'
    end
  end
  
  def show
    @leave = Leave.find(params[:id])
  end

  private

  def leave_params
    params.require(:leave).permit(:status, :to, :from, :reason, :leave_quotum_id, :half_day)
  end

  def filter_leaves(leaves, type)
    case type
    when 'canceled'
      leaves.where(status: 'canceled')
    when 'approved'
      leaves.where(status: 'approved')
    else
      leaves
    end
  end
end
