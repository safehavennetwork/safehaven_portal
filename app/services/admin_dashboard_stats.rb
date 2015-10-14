class AdminDashboardStats
  delegate :url_helpers, to: 'Rails.application.routes'

  def self.call
    OpenStruct.new({
      user_signups:             User.where(  last_sign_in_at: 7.days.ago..Time.now).count,
      client_signups:           Client.where(created_at: 7.days.ago..Time.now).count,
      acceptances:              Client.where(updated_at: 7.days.ago..Time.now, update_action: 'accepted').count,
      oldest_unaccepted_client: oldest_unaccepted_client
    })
  end

  def self.oldest_unaccepted_client
    client = Client.where(release_status: nil, organization: nil).order(:created_at).first
    return nil unless client
    OpenStruct.new({
      days_in_waiting: (DateTime.now.to_date - client.created_at.to_date).to_i,
      client_name:     client.name,
      link:            "/client/#{client.id}"
    })
  end
end
