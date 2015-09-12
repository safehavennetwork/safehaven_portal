class Client < ActiveRecord::Base
  has_many   :pets
  belongs_to :address
  belongs_to :organization
  has_one    :client_application

  validates :email, uniqueness: true

  def all_pets_complete?
    self.pets.where(completed: [nil, false]).count == 0
  end
end
