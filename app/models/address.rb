class Address < ActiveRecord::Base
  has_one :client

  belongs_to :city
  belongs_to :state
  belongs_to :zip_code
end
