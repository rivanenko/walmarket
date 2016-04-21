class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:customer).where(product_id: params[:product_id])
    @reviews = @reviews.send(scope_mapping[params[:sort]])
    @reviews = @reviews.limit(per_page).offset(page)
  end

  private

  def scope_mapping
    { 'submission-desc' => 'newest_to_oldest', 'relevancy' => 'most_relevant',
      'helpful' => 'most_helpful', 'submission-asc' => 'oldest_to_newest',
      'rating-desc' => 'high_to_low_rating', 'rating-asc' => 'low_to_high_rating'}
  end

  def page
    @page = params[:page] || 1
  end

  def per_page
    @per_page = params[:offset] || 5
  end
end
