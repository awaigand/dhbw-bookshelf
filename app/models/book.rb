class Book < ActiveRecord::Base
  belongs_to :lender
  has_and_belongs_to_many :authors
  validates_presence_of :title
end
