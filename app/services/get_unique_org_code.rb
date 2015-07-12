class GetUniqueOrgCode
  def self.execute
    unique_code
  end

  private

  def self.unique_code
    code = SecureRandom.hex(3).upcase
    is_used?(code) ? code : unique_code
  end

  def self.is_used?(code)
    Organization.where(code: code).count < 1
  end
end
