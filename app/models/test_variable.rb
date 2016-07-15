class TestVariable < ApplicationRecord

  belongs_to :test, optional: true
  has_many :questions

  validates :name, { presence: true, uniqueness: { scope: :test } }
end
