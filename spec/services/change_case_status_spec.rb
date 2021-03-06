require "rails_helper"

RSpec.describe ChangeCaseStatus, :with_stubbed_elasticsearch, :with_test_queue_adapter do
  describe ".call" do
    # Create the case before test run to ensure we only check activity generated by the test
    subject(:result) { described_class.call!(investigation: investigation, new_status: new_status, rationale: rationale, user: user) }

    let!(:investigation) { create(:enquiry, is_closed: false, creator: user) }

    let(:previous_status) { "open" }
    let(:new_status) { "closed" }
    let(:rationale) { "Test" }
    let(:user) { create(:user, :activated) }

    context "with no investigation parameter" do
      subject(:result) { described_class.call(user: user, new_status: new_status) }

      it "fails" do
        expect(result).to be_failure
      end
    end

    context "with no user parameter" do
      subject(:result) { described_class.call(investigation: investigation, new_status: new_status) }

      it "fails" do
        expect(result).to be_failure
      end
    end

    context "with no new_status parameter" do
      subject(:result) { described_class.call(investigation: investigation, user: user) }

      it "fails" do
        expect(result).to be_failure
      end
    end

    context "when the previous status and the new status are the same" do
      let(:new_status) { previous_status }

      it "succeeds" do
        expect(result).to be_success
      end

      it "does not create a new activity" do
        expect { result }.not_to change(Activity, :count)
      end

      it "does not send an email" do
        expect { result }.not_to have_enqueued_mail(NotifyMailer, :investigation_updated)
      end
    end

    context "when the previous status and the new status are different" do
      def expected_email_subject
        "Enquiry was closed"
      end

      def expected_email_body(name)
        "Enquiry was closed by #{name}."
      end

      it "succeeds" do
        expect(result).to be_success
      end

      it "changes the status for the investigation" do
        expect { result }.to change(investigation, :is_closed).from(false).to(true)
      end

      it "changes the date closed for the investigation" do
        expect { result }.to change(investigation, :date_closed).from(nil).to(kind_of(ActiveSupport::TimeWithZone))
      end

      it "creates a new activity for the change", :aggregate_failures do
        expect { result }.to change(Activity, :count).by(1)
        activity = investigation.reload.activities.first
        expect(activity).to be_a(AuditActivity::Investigation::UpdateStatus)
        expect(activity.source.user).to eq(user)
        expect(activity.metadata).to include("updates" => { "is_closed" => [false, true], "date_closed" => [nil, kind_of(String)] })
        expect(activity.metadata).to include("rationale" => rationale)
      end

      it_behaves_like "a service which notifies the case owner"
      it_behaves_like "a service which notifies the case creator"
    end
  end
end
