class Movie < ActiveRecord::Base
  def self.all_ratings
    x = self.select(:rating) #select elements 
    x = x.distinct #select only distinct elements
    return x.order(:rating).pluck(:rating) # order and pluck
  end
end