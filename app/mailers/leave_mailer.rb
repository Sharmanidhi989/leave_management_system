class LeaveMailer < ApplicationMailer
  default from: 'test0mailer0gen@gmail.com'

  # mails send by Admin
  def approved_email(leave)
    @leave = leave
    mail(to: @leave.employee.email, subject: 'Your Leave has been Approved.')
  end
  
  def canceled_leave(leave)
    @leave = leave
    mail(to: @leave.employee.email, subject: 'Leave Cancellation.')
  end
  
  def review_leave(leave, admin)
    @leave = leave
    @admin = admin
    mail(to: @admin.email, subject:'Leave Application')
  end

  # mails send by employee 
  def apply_leave(leave)
    @leave = leave
    mail(to: @leave.employee.email, subject: 'Leave Application')
  end
end
