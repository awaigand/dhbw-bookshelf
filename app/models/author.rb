class Author < ActiveRecord::Base
  has_and_belongs_to_many :books

  before_destroy{ books.clear }
end
