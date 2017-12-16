class Statistic < ApplicationRecord
  def calculate_ranking(people, rating)
    binding.pry
    average_all_votes = Statistic.all[0].all_reviews / Statistic.all[0].all_products
    average_all_rating = Statistic.all[0].all_rating / Statistic.all[0].all_products
    return cal = ((average_all_votes * average_all_rating) + (people * rating)) / (average_all_votes + people)
  end
end
