class Product < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :customers, through: :reviews

  def recalculate_rating
    reviews_count = reviews.count
    self.rating = reviews.sum(:rating).to_f / reviews_count
  end
end
