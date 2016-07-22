class TestResult < ApplicationRecord

  belongs_to :test_variable

  has_many :test_result_ranges, -> { order(:range_start) }

  accepts_nested_attributes_for :test_result_ranges, reject_if: :all_blank, allow_destroy: true

  validates :test_variable_id, uniqueness: true
  validates :attribute_name, presence: true

  validate :check_result_ranges

  def covers?(max_value)
    valid? && ( test_result_ranges.maximum(:range_stop) == max_value )
  end

  def range_for(score)
    test_result_ranges.find {|range| range.value_range.include? score }
  end

  private

  def check_result_ranges
    ranges = test_result_ranges.to_a
    check_overlap(ranges)
    check_lacking(ranges)
  end

  def check_overlap(ranges)
    overlap = false
    ranges.combination(2).each do |two_ranges|
      if two_ranges.first.value_range.overlaps?(two_ranges.last.value_range)
        overlap = true
        two_ranges.last.errors.add(:base, 'overlaps with another range')
      end
    end
    errors.add(:base, 'Result ranges overlap') if overlap
  end

  def check_lacking(ranges)
    set = Set.new

    ranges.each do|range|
      range.value_range.each do |element|
        set << element
      end
    end

    ordered_sets = set.divide { |i,j| (i - j).abs == 1 }

    lacking = ordered_sets.count > 1 || !set.include?(0)

    errors.add(:base, 'Result ranges are not complete') if lacking
  end

end
