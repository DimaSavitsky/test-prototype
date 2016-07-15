class Test < ApplicationRecord

  validates :name, presence: true
  validates :test_variables, presence: true

  has_many :test_variables, dependent: :destroy
  has_many :questions, through: :test_variables, dependent: :destroy

  accepts_nested_attributes_for :test_variables, reject_if: :all_blank, allow_destroy: true

end
