FactoryGirl.define do
  factory :va5490, class: SavedClaim::EducationBenefits::VA5490 do
    form({
      benefit: 'chapter35',
      veteranSocialSecurityNumber: '111223333',
      relativeFullName: {
        first: 'Mark',
        last: 'Olson'
      },
      privacyAgreementAccepted: true
    }.to_json)
  end
end
