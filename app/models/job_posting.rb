class JobPosting < ApplicationRecord
  belongs_to :onet_occupation, class_name: 'Onet::Occupation', foreign_key: :onetsoc_code, primary_key: :onetsoc_code
  belongs_to :user

  validates :onet_occupation, presence: true

  default_scope { includes(onet_occupation: :occupation_abilities) }

  after_initialize :init_arrays_for_occupation

  def display_title
    ( title.present? && title ) || onet_occupation.title
  end

  def display_description
    ( description.present? && description ) || onet_occupation.description
  end

  private

  def init_arrays_for_occupation
    if self.onet_occupation
      unless self.abilities
        self.abilities = Array.new(self.onet_occupation.occupation_abilities.length, true)
      end
    end
  end

end
