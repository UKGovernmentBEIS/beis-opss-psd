FactoryBot.define do
  factory :audit_activity_test_result, class: "AuditActivity::Test::Result" do
    title { Faker::Hipster.word }
    investigation
    product
  end

  factory :legacy_audit_activity_test_result, class: "AuditActivity::Test::Result" do
    title { Faker::Hipster.word }
    metadata { nil }
    investigation
    product
  end

  factory :legacy_audit_activity_corrective_action, class: "AuditActivity::CorrectiveAction::Base" do
    metadata { nil }
    investigation { create :allegation }
    product
  end

  factory :legacy_audit_add_activity_corrective_action, class: "AuditActivity::CorrectiveAction::Add", parent: :legacy_audit_activity_corrective_action
  factory :legacy_audit_update_activity_corrective_action, class: "AuditActivity::CorrectiveAction::Update", parent: :legacy_audit_activity_corrective_action

  factory :legacy_audit_investigation_update_status, class: "AuditActivity::Investigation::UpdateStatus" do
    investigation { create :allegation }
    title { "Allegation closed" }
  end

  factory :legacy_audit_investigation_visibility_status, class: "AuditActivity::Investigation::UpdateVisibility" do
    investigation { create :allegation }
    title { "Allegation visibility\n            restricted" }
  end
end
