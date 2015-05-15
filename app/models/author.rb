class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  validates_presence_of :name

  before_destroy{ books.clear }
end
