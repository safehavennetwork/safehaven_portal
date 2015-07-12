class PetVerifier < Verifier
  def has_basic_info?(pet_type, attributes)
    assert_equal(:pet_type_id, pet_type.id)
    assert_attributes(attributes,
      :breed,
      :weight
    )
  end
end
