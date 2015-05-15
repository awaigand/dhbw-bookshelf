class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :image_link
      t.integer :lender_id

      t.timestamps
    end
  end
end
