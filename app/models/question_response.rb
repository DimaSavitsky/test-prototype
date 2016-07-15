class QuestionResponse < ApplicationRecord
  belongs_to :question, optional: true

  validates :text, { presence: true }
  validates :points, { numericality: {only_integer: true, greater_than_or_equal_to: 0} }
end
