class Movie < ActiveRecord::Base
  def self.all_ratings
    x = self.select(:rating).distinct.order(:rating)
    return x.pluck(:rating)
  end
end