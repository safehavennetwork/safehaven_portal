class City < ActiveRecord::Base
  lookup_by :city, find_or_create: true
  has_many :addresses
end
