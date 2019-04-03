class Leave < ApplicationRecord
  belongs_to :employee
  belongs_to :leave_quotum
  validates :reason, presence: true
  validates :to, presence: true
  validates :from, presence: true
  validates :leave_quotum_id, presence: true
  validate :from_leave_date, on: :create
  validate :to_leave_date, on: :create
  validate :from_greater_than_to, on: :create
  
  def from_greater_than_to
    if from.present? && to.present? && from > to
      errors.add(:from, "leave days cannot be negative.")
    end
  end

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
      byebug
      days = (self.to - self.from).to_i + self.half_day
      byebug
      self.leave_quotum.count += days
      self.leave_quotum.save!
    end
  end
  
  before_save do
    if self.approved?
      days = (self.to - self.from).to_i + self.half_day
      self.leave_quotum.count -= days
      self.leave_quotum.save!
    end
  end

  after_initialize do
    self.status = :pending if self.new_record?
  end

  enum status: [ :pending, :approved, :canceled ]
end
