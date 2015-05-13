class PhoneNumber < ActiveRecord::Base
  has_one :user
end
