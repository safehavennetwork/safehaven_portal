class UpdateUser
  attr_accessor :errors, :user, :user_hash

  def initialize(update_hash, user)
    @user      = user
    @user_hash = update_hash
  end

  def call
    user_hash[:primary_phone_number]   = PhoneNumber.find_or_create_by(phone_number: user_hash.delete(:primary_phone_number))
    user_hash[:secondary_phone_number] = PhoneNumber.find_or_create_by(phone_number: user_hash.delete(:secondary_phone_number))
    user.update_attributes(user_hash)
    user
  rescue => e
    Rails.logger.info e.message
    Rails.logger.info e.backtrace[(0..5)].join '\n'
    Rails.logger.info "Errors saving user: #{user.errors.messages}"
    user
  end
end
