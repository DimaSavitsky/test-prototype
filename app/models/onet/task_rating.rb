module Onet
  class TaskRating < Base

    self.table_name = :task_ratings

    belongs_to :occupation, class_name: Onet::Occupation, foreign_key: :onetsoc_code
    belongs_to :task_category, class_name: Onet::TaskCategory, foreign_key: :category
    belongs_to :task_statement, class_name: Onet::TaskStatement, foreign_key: :task_id

    delegate :category_description, to: :task_category

  end
end
