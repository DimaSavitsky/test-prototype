module Onet
  class Base < ApplicationRecord
    self.abstract_class = true

    after_initialize :readonly!
  end
end
