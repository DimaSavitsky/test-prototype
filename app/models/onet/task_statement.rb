module Onet
  class TaskStatement < Base

    self.table_name = :task_statements

    belongs_to :occupation, class_name: Onet::Occupation, foreign_key: :onetsoc_code

    has_many :task_ratings, inverse_of: :task_statement, foreign_key: :task_id

    def frequency_category
      frequency ? frequency.category : 0
    end

    def frequency_description
      frequency ? frequency.category_description : ''
    end

    private

    def frequency
      task_ratings.order(data_value: :desc).first
    end

  end
end
