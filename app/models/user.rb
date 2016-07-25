class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :test_attempts

  has_many :user_internal_abilities

  accepts_nested_attributes_for :user_internal_abilities, reject_if: :all_blank, allow_destroy: true

  validate :internal_abilities_uniqueness

  private

  def internal_abilities_uniqueness
    ability_ids = user_internal_abilities.map(&:internal_ability_id)
    repeating_ids = ability_ids.select {|element| ability_ids.count(element) > 1 }

    InternalAbility.where(id: repeating_ids).each do |duplicated_ability|
      errors.add(:base, "can't have '#{duplicated_ability.name}' specified twice")
    end

  end

end
