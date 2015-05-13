class ZipCode < ActiveRecord::Base
  has_many :addresses
end
