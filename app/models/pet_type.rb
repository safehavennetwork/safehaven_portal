class PetType < ActiveRecord::Base
  has_many :pets
end
