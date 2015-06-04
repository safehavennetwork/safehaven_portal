class Client < ActiveRecord::Base
  has_many :pets
  belongs_to :address
  belongs_to :organization
  has_one    :client_application
end
