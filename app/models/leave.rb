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
  
  LEAVETYPES = %w[all_leaves approved canceled].freeze

  def from_greater_than_to
    errors.add(:from, 'leave days cannot be negative.') if from.present? && to.present? && from > to
  end

  def from_leave_date
    errors.add(:from, 'Leave dates cannot be in the past') if from.present? && from <= Date.today
  end

  def to_leave_date
    errors.add(:to, 'Leave dates cannot be in the past')if  to.present? && to <= Date.today
  end

  after_update do
    if canceled?
      days = (to - from).to_i + half_day
      leave_quotum.count += days
      leave_quotum.save!
    end
  end

  before_save do
    if approved?
      days = (to - from).to_i + half_day
      leave_quotum.count -= days
      leave_quotum.save!
    end
  end

  after_initialize do
    status = :pending if new_record?
  end

  enum status: %w[pending approved canceled]
end
