class CreateClientWithPets
  attr_accessor :errors, :client
  def self.call(client_hash, pet_hash)
    address_hash = client_hash[:address]
    @client = Client.find_or_create_by!(
      name: client_hash[:client_name],
      phone: PhoneNumber.find_or_create_by!(phone_number: client_hash[:client_phone_number]),
      email: client_hash[:email],
      best_way_to_reach: client_hash[:best_way_to_reach],
      address: Address.find_or_create_by!(
        line1:    address_hash[:line1],
        city:     City.find_or_create_by!(city:        address_hash[:city]),
        state:    State.find_or_create_by!(state:      address_hash[:state]),
        zip_code: ZipCode.find_or_create_by!(zip_code: address_hash[:zip_code])
      )
    )

    unless !pet_hash || pet_hash.empty?
      pet_hash.each do |pet|
        @client.pets << Pet.create(pet)
      end
    end
    UserMailer.new_client(@client).deliver
    @client
  end
end
