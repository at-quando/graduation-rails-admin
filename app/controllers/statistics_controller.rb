class StatisticsController < ApplicationController
  def create
    re = Product.all.sum(:number_review)
    pro = Product.all.count
    ra = Product.all.sum(:rating)
    Statistic.create(all_reviews: re , all_products: pro , all_rating: ra)
  end
end
