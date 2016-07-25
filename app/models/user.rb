class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :test_attempts

  has_many :user_internal_abilities

  accepts_nested_attributes_for :user_internal_abilities, reject_if: :all_blank, allow_destroy: true

end
