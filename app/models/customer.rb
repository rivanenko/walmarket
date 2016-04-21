class Customer < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews
end
