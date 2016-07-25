class UserInternalAbility < ApplicationRecord
  belongs_to :user
  belongs_to :internal_ability

  validates :level, { presence: true, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 7.0 } }
end
