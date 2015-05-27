class GetRecentActivity
  attr_accessor :activities

  def self.call
    @activities = []
    add_client_activities
    add_pet_activities
    add_user_activities
    add_organization_activities

    #activities.compact!
    @activities
  end  

  def self.add_client_activities
    Client.order(:updated_at).limit(5).pluck(:name, :client_id, :update_action, :updated_at).each do | client | 
      unless client[2].blank?
        @activities << OpenStruct.new(
          link: "/client/#{client[1]}",
          description: "Client #{client[0]} was #{client[2]} on #{client[3]}"  
        )
      end
    end
  end

  def self.add_pet_activities
    Pet.order(:updated_at).limit(5).pluck(:name, :pet_id, :update_action, :updated_at).each do | pet | 
      unless pet[2].blank?
        @activities << OpenStruct.new(
          link: "/pet/#{pet[1]}",
          description: "Pet #{pet[0]} was #{pet[2]} on #{pet[3]}"  
        )
      end
    end
  end

  def self.add_user_activities
    User.order(:updated_at).limit(5).pluck(:email, :user_id, :update_action, :updated_at).each do | user | 
      unless user[2].blank?        
        @activities << OpenStruct.new(
          link: '#', #"/user/#{user[1]}",
          description: "User  #{user[0]} was #{user[2]} on #{user[3]}"  
        )
      end
    end
  end

  def self.add_organization_activities
    Organization.order(:updated_at).limit(5).pluck(:name, :organization_id, :update_action, :updated_at).each do | organization | 
      unless organization[2].blank?
        @activities << OpenStruct.new(
          link: '#', #"/organization/#{organization[1]}",
          description: "Organization  #{organization[0]} was #{organization[2]} on #{organization[3]}"  
        )
      end
    end
  end
end
