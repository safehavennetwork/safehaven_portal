class Group < ActiveRecord::Base
  include LookupBy
  has_and_belongs_to_many :users
end
