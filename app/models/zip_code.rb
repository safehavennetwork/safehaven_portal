class ZipCode < ActiveRecord::Base
  lookup_by :zip_code, find_or_create: true
  has_many :addresses
end
