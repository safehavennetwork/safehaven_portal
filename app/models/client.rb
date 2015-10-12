class Client < ActiveRecord::Base
  extend FriendlyId
  has_many   :pets
  belongs_to :address
  belongs_to :organization
  belongs_to :release_status
  belongs_to :phone_number
  has_one    :client_application
  friendly_id :name, use: :slugged

  validates :email, uniqueness: true

  def all_pets_released?
    pets.map(&:organization).compact.empty?
  end

  def all_pets_complete?
    self.pets.where(completed: [nil, false]).count == 0
  end

  def application_completed?
    client_application && all_pets_completed?
  end

  def all_pets_completed?
     pets.select{|p| p.completed}.count == pets.size
  end
end
