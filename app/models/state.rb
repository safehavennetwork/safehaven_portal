class State < ActiveRecord::Base
  include LookupBy
  has_many :addresses
end
