class Question < ApplicationRecord

  validates :test, presence: true

  belongs_to :test

end
