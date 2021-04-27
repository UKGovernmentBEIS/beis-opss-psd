class AuditActivity::Business::Base < AuditActivity::Base
  private_class_method def self.from(business, investigation, title, body)
    create!(
      body: body,
      source: UserSource.new(user: User.current),
      investigation: investigation,
      title: title,
      business: business
    )
  end
end
