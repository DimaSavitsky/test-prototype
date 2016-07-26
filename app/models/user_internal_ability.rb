class UserInternalAbility < ApplicationRecord
  belongs_to :user
  belongs_to :internal_ability

  validates :level, { presence: true, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 7.0 } }
  validates :internal_ability_id, uniqueness: { scope: :user }


  def self.collected_search_criteria
    self.includes(:internal_ability).map do |link|
      {
        element_id: link.internal_ability.onet_content_element_id,
        specific_value: link.level
      }
    end
  end

end
