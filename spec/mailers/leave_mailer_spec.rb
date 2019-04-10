require "rails_helper"

RSpec.describe LeaveMailer, type: :mailer do
  employee = let(:employee) { create(:employee) }
  @leave = let(:leave) { create(:leave) }
  describe "Apply leave" do
    let(:mail) { LeaveMailer.apply_leave(leave) }
    it "Notify admin if Leave has been appiled" do
      mail =LeaveMailer.apply_leave(@leave)
    end
    it "checks subject" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.subject).to match("Leave Application")
    end
    it "checks body" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.body.encoded).to match("applied")
    end
  end
  describe "Cancel" do
    let(:mail) { LeaveMailer.review_leave(leave) }
    it "Notify admin if Leave Cancelation Requested" do
      mail =LeaveMailer.review_leave(@leave)
    end
    it "checks subject" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.subject).to match("Request to Leave Cancellation")
    end
    it "checks body" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.body.encoded).to match("cancellation")
    end
  end
  describe "Approval" do
    let(:mail) { LeaveMailer.approved_email(leave) }
    it "Notify user if Leave is Approved" do
      mail =LeaveMailer.approved_email(@leave)
    end
    it "checks subject" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.subject).to match("Your Leave has been Approved")
    end
    it "checks body" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.body.encoded).to match("approved")
    end
  end
  describe "Cancellation" do
    let(:mail) { LeaveMailer.canceled_leave(leave) }
    it "Notify user if Leave is Cancelled" do
     mail = LeaveMailer.canceled_leave(@leave)
    end
    it "checks subject" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.subject).to match("Leave has been Cancelled.")
    end
    it "checks body" do
      @employee = create(:employee) 
      @leave_quotum = create(:leave_quotum)
      expect(mail.body.encoded).to match("cancelled")
    end
  end
end
