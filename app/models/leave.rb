class Leave < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_quotum
  validates :reason, presence: true
  validates :to, presence: true
  validates :from, presence: true
  validates :leave_quotum_id, presence: true
  validate :from_leave_date, on: :create
  validate :to_leave_date, on: :create
  
  def from_leave_date
    if from.present? && from <= Date.today 
      errors.add(:from, "Leave dates cannot be in the past")
    end
  end

  def to_leave_date
    if  to.present? && to <= Date.today 
      errors.add(:to, "Leave dates cannot be in the past")
    end
  end
  
  after_update do
    if self.canceled?
      deduction = self.to - self.from
      self.leave_quotum.leave_number += deduction.to_i
      self.leave_quotum.save!
    end
  end
  
  before_save do
    if self.approved?
      deduction = self.to - self.from
      self.leave_quotum.leave_number -= deduction.to_i
      self.leave_quotum.save!
    end
  end
  
  after_initialize do
    self.status = :pending if self.new_record?
  end

  enum status: [ :pending, :approved, :denied, :canceled ]
end
