class Client < ActiveRecord::Base
  has_many :pets
  belongs_to :address
  belongs_to :organization
end
