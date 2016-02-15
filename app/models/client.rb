class Client < ActiveRecord::Base
  extend FriendlyId
  has_many   :pets
  belongs_to :address
  belongs_to :organization
  belongs_to :release_status
  belongs_to :phone_number
  has_one    :client_application
  friendly_id :name, use: :slugged

  #validates :email, presence: true, email: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #validates :phone, presence: true, phone: /\A(\(?(809|829|849)\)?[-. ]\d{3}[-.]\d{4})\z/

  #validates :email, presence: true #uniqueness: true
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #validates_format_of :phone, 
    #length: { in: 10 },
    #:with => /\A(\(?(809|829|849)\)?[-. ]\d{3}[-.]\d{4})\z/,
    #:message => "Invalid phone number!"

  #validates :name, :email, :best_way_to_reach, :address_id, :organization_id, presence: true
  #validates :phone_number_id, :release_status_id, :pets_count, :slug, presence: true

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