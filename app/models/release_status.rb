class ReleaseStatus < ActiveRecord::Base
  include LookupBy
  has_many :pets
end
