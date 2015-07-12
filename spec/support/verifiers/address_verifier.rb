class AddressVerifier < Verifier
  def has_basic_address?(attributes, city, state, zip_code)
    assert_attributes(attributes,
      :line1
    )
    assert_equal(:city_id, city.id)
  end
end
