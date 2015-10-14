class Group < ActiveRecord::Base
  lookup_by :name, find_or_create: true
  has_and_belongs_to_many :users
end
