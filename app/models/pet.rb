class Pet < ActiveRecord::Base
  extend FriendlyId
  belongs_to :client, counter_cache: true
  belongs_to :organization
  belongs_to :pet_type
  belongs_to :release_status
  friendly_id :name, use: :slugged

  def cat?
    pet_type.try(:pet_type) == 'cat'
  end

  def dog?
    pet_type.try(:pet_type) == 'dog'
  end

  def other?
    !cat? && !dog?
  end
end
