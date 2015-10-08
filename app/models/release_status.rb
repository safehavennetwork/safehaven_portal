class ReleaseStatus < ActiveRecord::Base
  lookup_by :release_status, find_or_create: true
  has_many :pets
  has_many :clients
end
