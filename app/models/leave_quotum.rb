class LeaveQuotum < ApplicationRecord
  belongs_to :employee
  has_many :leaves
end
