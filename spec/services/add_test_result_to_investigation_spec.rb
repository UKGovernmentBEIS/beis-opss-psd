require "rails_helper"

RSpec.describe AddTestResultToInvestigation, :with_stubbed_elasticsearch, :with_stubbed_mailer, :with_stubbed_antivirus, :with_test_queue_adapter do
  let(:user)                                 { create(:user, :activated) }
  let!(:investigation)                       { create :allegation, creator: user }

  let(:document)                             { ActiveStorage::Blob.create_and_upload!(io: StringIO.new("files/test_result.txt"), filename: "test_result.txt") }
  let(:file_description)                     { Faker::Hipster.sentence }
  let(:date)                                 { Date.current }
  let(:details)                              { Faker::Hipster.sentence }
  let(:legislation)                          { Rails.application.config.legislation_constants["legislation"].sample }
  let(:test_result)                          { Test::Result.results[:passed] }
  let(:standards_product_was_tested_against) { %w[EN71] }
  let(:product_id)                           { create(:product).id }
  let(:params) do
    {
      investigation: investigation,
      user: user,
      document: document,
      date: date,
      details: details,
      legislation: legislation,
      result: test_result,
      standards_product_was_tested_against: standards_product_was_tested_against,
      product_id: product_id
    }
  end

  def expected_email_body(user, viewing_user)
    "Test result was added to the #{investigation.case_type} by #{UserSource.new(user: user).show(viewing_user)}."
  end

  def expected_email_subject
    "#{investigation.case_type.upcase_first} updated"
  end

  describe "when provided with a user and an investigation" do
    let(:command) { described_class.call(params) }

    it "creates the test result", :aggregate_failures do
      expect(command).to be_a_success

      expect(command.test_result).to have_attributes(
        date: date, details: details, legislation: legislation, result: "passed", product_id: product_id,
        standards_product_was_tested_against: standards_product_was_tested_against,
        document_blob: document
      )
    end

    it "creates an audit log", :aggregate_failures do
      test_result = command.test_result
      audit = investigation.activities.find_by!(type: "AuditActivity::Test::Result", product_id: product_id)
      expect(audit.source.user).to eq(user)
      expect(audit.metadata["test_result"]["id"]).to eq(test_result.id)
    end

    it_behaves_like "a service which notifies teams with access" do
      let(:result) { described_class.call(params) }
    end
  end
end
