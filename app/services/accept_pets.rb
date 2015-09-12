class AcceptPets
  attr_accessor :request_hash, :errors

  def initialize(request_hash)
    @request_hash = request_hash
  end

  def call
    client.pets.each do |pet|
      pet.update_attributes(organization: shelter)
    end
    true
  rescue => e
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    nil
  end

  private

  def client
    request_hash[:client]
  end

  def shelter
    request_hash[:shelter]
  end
end
