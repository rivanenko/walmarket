class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :product_id
      t.integer :customer_id
      t.integer :rating
      t.string :title
      t.string :description
      t.boolean :recommend

      t.timestamps
    end
  end
end
