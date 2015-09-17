class SearchSafeHaven
  attr_accessor :query

  def initialize(query)
    @query = query
  end

  def call
    return [] unless query.present?
    (search_user_by_first_name + search_user_by_last_name + search_user_by_email + search_pet_by_name).uniq
  rescue => e
    Rails.logger.info e.message
    Rails.logger.info e.backtrace[(0..5)].join '\n'
    Rails.logger.info "Errors saving user: #{user.errors.messages}"
    []
  end

  def search_user_by_first_name
    User.where("lower(first_name) like lower(?)", "%#{query}%")
                  .limit(4).pluck(:user_id, :first_name, :last_name)
                  .map{ |u| ["/user/#{u[0]}", "#{u[1]} #{u[2]}"] }.compact
  end

  def search_user_by_last_name
    User.where("lower(last_name) like lower(?)", "%#{query}%")
                  .limit(4).pluck(:user_id, :first_name, :last_name)
                  .map{ |u| ["/user/#{u[0]}", "#{u[1]} #{u[2]}"] }.compact
  end

  def search_user_by_email
    User.where("lower(email) like lower(?)", "%#{query}%")
      .limit(4).pluck(:user_id, :email)
      .map{ |u| ["/user/#{u[0]}", "#{u[1]}"] }.compact
  end

  def search_pet_by_name
    Pet.where("lower(name) like lower(?)", "%#{query}%")
      .limit(4).pluck(:pet_id, :name)
      .map{ |u| ["/pet/#{u[0]}", "#{u[1]}"] }.compact
  end

  def search_client_by_name
    Client.where("lower(name) like lower(?)", "%#{query}%")
      .limit(4).pluck(:client_id, :name)
      .map{ |u| ["/client/#{u[0]}", "#{u[1]}"] }.compact
  end
end
