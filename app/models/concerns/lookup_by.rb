module LookupBy
  extend ActiveSupport::Concern

  def to_s
    attributes[self.class.to_s.underscore].to_s
  rescue => e
    Rails.logger.info "LookupBy nil value error"
    nil
  end

  module ClassMethods
    def [] value
      return nil unless value
      find_or_create_by("#{to_s.underscore}" => value)
    end
  end
end
