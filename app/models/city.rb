class City < ActiveRecord::Base
  has_many :addresses
end
