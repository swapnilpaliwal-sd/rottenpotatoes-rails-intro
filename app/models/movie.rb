class Movie < ActiveRecord::Base
  def self.all_ratings
    x = self.select(:rating) #select entries
    x = x.distinct #ensure distinct entries
    return x.order(:rating).pluck(:rating) #order and pluck
  end
end