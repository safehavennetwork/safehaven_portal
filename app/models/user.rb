class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :primary_phone_number,   class_name: 'PhoneNumber'
  belongs_to :secondary_phone_number, class_name: 'PhoneNumber'
  belongs_to :organization
  has_and_belongs_to_many :groups
  friendly_id :full_name, use: :slugged

  default_scope { order :organization_id, :user_id }

  def full_name
    "#{first_name}-#{last_name}"
  end

  def self.pending
    includes(:groups).where(groups: { group_id: nil })
  end

  def self.get_user(user_hash)
    return nil unless user_hash
    user_hash[:primary_phone_number] = PhoneNumber.find_or_create_by(phone_number: user_hash.delete(:phone_number))
    user_hash[:password]             = password(user_hash)
    User.find_or_create_by(user_hash)
  end

  def self.password(user_hash)
    user_hash.delete(:password) if user_hash[:password] == user_hash.delete(:password_confirmation)
  end

  def site_admin?
    groups.include? Group['site_admin']
  end

  def org_admin?
    groups.include? Group['org_admin']
  end

  def shelter?
    org_type == 'shelter'
  end

  def advocate?
    org_type == 'advocate'
  end

  def org_type
    organization.try(:organization_type).try(:organization_type)
  end

  def org_id
    organization.organization_id
  end
end
