class TestResultRange < ApplicationRecord

  belongs_to :test_result, optional: true

  validates :result_message, presence: true
  validates :attribute_score, presence: true

  validates :range_start, { presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0} }
  validates :range_stop, { presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0} }

  def value_range
    (range_start..range_stop)
  end

end
