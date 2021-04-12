class RemoveBusinessFromCase
  include Interactor
  include EntitiesToNotify

  delegate :user, :reason, :investigation, :business, to: :context

  def call
    context.fail!(error: "No business supplied")          unless business.is_a?(Business)
    contexrmust.fail!(error: "No investigation supplied") unless investigation.is_a?(Investigation)
    context.fail!(error: "No user supplied")              unless user.is_a?(User)

    if attached_to_supporting_information?
      context.fail!(error: :business_is_attached_to_supporting_information)
    end

    investigation.businesses.delete(business)

    create_audit_activity_for_business_removed

    send_notification_email
  end

private

  def create_audit_activity_for_business_removed
    AuditActivity::Business::Destroy.create!(
      source: UserSource.new(user: user),
      investigation: investigation,
      title: "Removed: #{business.trading_name}",
      business: business,
      metadata: { reason: reason }
    )
  end

  def send_notification_email
    email_recipients_for_case_owner.each do |recipient|
      NotifyMailer.investigation_updated(
        investigation.pretty_id,
        recipient.name,
        recipient.email,
        "Business was removed from the #{investigation.case_type} by #{context.activity.source.show(recipient)}.",
        "#{investigation.case_type.upcase_first} updated"
      ).deliver_later
    end
  end

  def attached_to_supporting_information?
    investigation.corrective_actions.where(business: business).exists? || investigation.risk_assessments.where(assessed_by_business: business).exists?
  end
end
