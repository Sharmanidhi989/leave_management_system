  class LeaveMailer < ApplicationMailer
  default from: 'test0mailer0gen@gmail.com'

  # mails send by Admin
  def approved_email(leave)
    @leave = leave
    mail(to: @leave.employee.email, subject: 'Your Leave has been Approved.')
  end
  
  def canceled_leave(leave)
    @leave = leave
    mail(to: @leave.employee.email, subject: 'Leave has been Cancelled.')
  end

  # mails send by employee 
  def apply_leave(leave)
    @leave = leave
    @recipients = AdminUser.all
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails , subject: 'Leave Application')
  end

  def review_leave(leave)
    @leave = leave
    @recipients = AdminUser.all
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails , subject: 'Request to Leave Cancellation')
  end
end
