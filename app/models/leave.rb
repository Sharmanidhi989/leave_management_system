class Leave < ApplicationRecord
  belongs_to :employee
  validates :reason, presence: true
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
  
  after_initialize do
    if self.new_record?
      self.status = :pending
    end
  end

  enum status: [:pending, :approved, :denied]
end
