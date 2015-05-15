class Book < ActiveRecord::Base
  belongs_to :lender
  has_and_belongs_to_many :authors
  validates_presence_of :title

  scope :for_author, -> (author){ joins(:authors).where(:authors => {:name => author})}
  scope :for_lender, -> (lender_id){ where('lender_id = ?',lender_id) }
  
  before_destroy{ books.clear }
end
