class Question < ApplicationRecord

  belongs_to :test_variable
  has_one :test, through: :test_variable
  has_many :question_responses, dependent: :destroy

  accepts_nested_attributes_for :question_responses, reject_if: :all_blank, allow_destroy: true

  validate :has_enough_responses
  validate :has_unique_responses

  private

  def has_enough_responses
    self.errors.add(:base, 'has not enough response variants') if ( self.question_responses.size < 2 )
  end

  def has_unique_responses
    texts = []
    self.question_responses.each do |response|
      if response.text.in?(texts)
        self.errors.add(:base, 'all responses must be unique')
        response.errors.add(:text, 'must be unique')
      end
      texts.push(response.text)
    end
  end

end
