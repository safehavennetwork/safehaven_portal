class PetType < ActiveRecord::Base
  lookup_by :pet_type, find_or_create: true
  has_many :pets
end
