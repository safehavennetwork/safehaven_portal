class State < ActiveRecord::Base
  lookup_by :state, find_or_create: true
  has_many :addresses
end
