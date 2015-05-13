class Lender < ActiveRecord::Base
  has_many :books

  validates_presence_of :name, :street
end
