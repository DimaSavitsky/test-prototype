module Onet
  class TaskStatement < Base

    self.table_name = :task_statements

    belongs_to :occupation, class_name: Onet::Occupation, foreign_key: :onetsoc_code


  end
end
