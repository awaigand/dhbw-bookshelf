class Book < ActiveRecord::Base
  belongs_to :lender

  validates_presence_of :title
end
