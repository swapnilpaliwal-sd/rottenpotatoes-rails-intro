class Movie < ActiveRecord::Base
  def self.all_ratings
    self.select(:rating).distinct.order(:rating).pluck(:rating)
  end
end