class GetAddress
  def self.call(_address_hash)
    address_hash = _address_hash
    address_hash[:city]     = City.find_or_create_by(city:     address_hash[:city])
    address_hash[:state]    = State.find_or_create_by(state:    address_hash[:state])
    address_hash[:zip_code] = ZipCode.find_or_create_by(zip_code: address_hash[:zip_code])
    Address.find_or_create_by!(address_hash)
  end
end
