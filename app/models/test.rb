class Test < ApplicationRecord

  validates :name, presence: true
  validates :test_variables, presence: true

  validate :publication_available

  has_many :test_variables, dependent: :destroy
  has_many :questions, through: :test_variables
  has_many :test_results, through: :test_variables

  has_many :test_attempts, dependent: :destroy

  accepts_nested_attributes_for :test_variables, reject_if: :all_blank, allow_destroy: true

  scope :published, -> { where( published: true ) }

  def ready_to_publish?
    test_variables.all?(&:results_complete? )
  end

  private

  def publication_available
    if self.published
      errors.add(:published, 'Is not ready to be published') unless ready_to_publish?
    end
  end

end
