class UpdateOrgContactInfo
  attr_accessor :request_hash, :errors, :org

  def initialize(org, request_hash)
    @org          = org
    @request_hash = request_hash
  end

  def call
    raise 'BOOM!'
    update_contact_info
    update_address
    true
  rescue => e
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    nil
  end

  private

  def update_address
    org.update_attributes(address: get_address)
  end

  def update_contact_info
    org.update_attributes(contact_params)
  end

  def get_address
    address = org.address || Address.new
    address_hash = request_hash['address']
    address.line1    = address_hash['line1']
    address.line2    = address_hash['line2']
    address.city     = City[address_hash['city']]
    address.state    = State[address_hash['state']]
    address.zip_code = ZipCode[address_hash['zip_code']]
    address.save
    address
  end

  def contact_params
    request_hash.slice(:phone, :email)
  end
end