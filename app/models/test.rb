class Test < ApplicationRecord

  validates :name, presence: true

  has_many :questions

end
