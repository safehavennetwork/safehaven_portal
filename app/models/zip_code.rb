class ZipCode < ActiveRecord::Base
  include LookupBy
  has_many :addresses
end
