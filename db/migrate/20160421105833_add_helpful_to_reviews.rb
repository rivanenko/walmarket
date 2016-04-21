class AddHelpfulToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :helpful, :integer
  end
end
