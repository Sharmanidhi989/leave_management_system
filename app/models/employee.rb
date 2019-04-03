class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invite_for => 2.weeks
  has_many :leaves, dependent: :destroy
  has_many :leave_quota, dependent: :destroy
  validates :email , uniqueness: true
  # checks is an email already exists or not
  def email_valid?
    if self.class.exists?(email: self.email)
      false
    else
      true
    end
  end
end
