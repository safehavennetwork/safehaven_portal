class Verifier
  def initialize(subject)
    @subject = subject
  end

  def assert_attributes(attributes, *keys)
    keys.all? { |key| assert_attribute(attributes, key) }
  end

  def assert_attribute(attributes, key)
    if @subject[key] != attributes[key]
      raise AttributeNotEqualError.new("#{key} is not equal, was #{@subject[key]} expected #{attributes[key]}")
    else
      true
    end
  end

  def assert_equal(key, value)
    if @subject[key] != value
      raise AttributeNotEqualError.new("#{key} is not equal, was #{@subject[key]} expected #{value}")
    else
      true
    end
  end

  class AttributeNotEqualError < StandardError
  end
end
