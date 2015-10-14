class ReleasePets
  attr_accessor :request_hash, :errors

  def initialize(request_hash)
    @request_hash = request_hash
  end

  def call
    client.pets.each do |pet|
      pet.update_attributes(
        organization:   nil,
        release_status: ReleaseStatus[release_status],
        updated_at: Time.now,
        update_action: "released by #{shelter.name}"
      )
    end
    OrganizationMailer.pets_released(client).deliver
    true
  rescue => e
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    nil
  end

  private

  def release_status
    request_hash[:reason].underscore
  end

  def client
    request_hash[:client]
  end

  def shelter
    request_hash[:shelter]
  end
end
