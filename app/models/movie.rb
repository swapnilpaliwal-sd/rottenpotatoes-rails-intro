class Movie < ActiveRecord::Base
  def self.all_ratings
    x = self.select(:rating)
    x = x.distinct #ensure distinct entries
    return x.order(:rating).pluck(:rating)
  end
end