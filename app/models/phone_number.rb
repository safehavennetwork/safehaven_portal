class PhoneNumber < ActiveRecord::Base
  has_one :user
  has_one :client
end
