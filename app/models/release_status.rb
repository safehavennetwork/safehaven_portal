class ReleaseStatus < ActiveRecord::Base
  include LookupBy
  has_many :pets
  has_many :clients
end
