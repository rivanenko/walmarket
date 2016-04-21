class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  validates :title, :description, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: 'Rate must be between 1 and 5'
  }

  after_save :recalculate_product_rating
  after_destroy :recalculate_product_rating

  scope :most_relevant, -> {  }
  scope :most_helpful, -> { order(helpful: :desc) }
  scope :newest_to_oldest, -> { order(created_at: :desc) }
  scope :oldest_to_newest, -> { order(created_at: :asc) }
  scope :high_to_low_rating, -> { order(rating: :desc) }
  scope :low_to_high_rating, -> { order(rating: :asc)}


  def recalculate_product_rating
    product.recalculate_rating if product
  end
end
