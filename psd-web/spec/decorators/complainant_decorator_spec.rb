require "rails_helper"

RSpec.describe ComplainantDecorator, :with_keycloak_config do
  let(:complainant) { build(:complainant) }

  subject { complainant.decorate }

  describe "#contact_details" do
    context "with contact details" do
      it "displays the contact details" do
        expect(subject.contact_details).to match(Regexp.escape(complainant.name))
        expect(subject.contact_details).to match(Regexp.escape(complainant.phone_number))
        expect(subject.contact_details).to match(Regexp.escape(complainant.email_address))
        expect(subject.contact_details).to match(Regexp.escape(complainant.other_details))
      end
    end

    context "without contact details" do
      let(:complainant) { Complainant.new }

      it { expect(subject.contact_details).to eq("Not provided") }
    end
  end

  describe "#other_details" do
    include_examples "a formated text", :complainant, :other_details
  end
end
