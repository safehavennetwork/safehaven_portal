class Pet < ActiveRecord::Base
  belongs_to :client, counter_cache: true
  belongs_to :organization
  belongs_to :pet_type
  belongs_to :release_status

  def cat?
    pet_type.pet_type == 'cat'
  end

  def dog?
    pet_type.pet_type == 'dog'
  end

  def other?
    pet_type.pet_type == 'other'
  end
end
