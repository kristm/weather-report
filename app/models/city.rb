class City < ApplicationRecord
  validates_presence_of :name, :long, :lat
end
