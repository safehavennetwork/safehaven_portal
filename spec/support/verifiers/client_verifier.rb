class ClientVerifier < Verifier
  def has_basic_info?(attributes)
    assert_attributes(attributes,
      :name,
      :phone,
      :email,
      :best_way_to_reach
    )
  end
end
