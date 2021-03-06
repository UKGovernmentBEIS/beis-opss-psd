require "rails_helper"

RSpec.describe RemoveProductFromCase, :with_test_queue_adapter do
  subject(:result) { described_class.call(investigation: investigation, product: product, user: user, reason: reason) }

  let(:investigation) { create(:allegation, products: [product], creator: creator) }
  let(:product)       { create(:product_washing_machine) }
  let(:reason)        { Faker::Hipster.sentence }
  let(:user)          { create(:user) }
  let(:creator)       { user }
  let(:owner)         { user }

  describe ".call" do
    context "with stubbed elasticsearh", :with_stubbed_elasticsearch do
      context "with no parameters" do
        let(:result) { described_class.call }

        it "returns a failure" do
          expect(result).to be_failure
        end
      end

      context "with no investigation parameter" do
        let(:result) { described_class.call(product: product, user: user) }

        it "returns a failure" do
          expect(result).to be_failure
        end
      end

      context "with no product parameter" do
        let(:result) { described_class.call(investigation: investigation, user: user) }

        it "returns a failure" do
          expect(result).to be_failure
        end
      end

      context "with no user parameter" do
        let(:result) { described_class.call(investigation: investigation, product: product) }

        it "returns a failure" do
          expect(result).to be_failure
        end
      end

      context "with required parameters" do
        def expected_email_subject
          "Allegation updated"
        end

        def expected_email_body(name)
          "Product was removed from the allegation by #{name}."
        end

        it "returns success" do
          expect(result).to be_success
        end

        it "removes the product from the case" do
          result
          expect(investigation.reload.products).not_to include(product)
        end

        it "creates an audit activity", :aggregate_failures do
          result
          activity = investigation.reload.activities.find_by!(type: AuditActivity::Product::Destroy.name)
          expect(activity).to have_attributes(title: nil, body: nil, product_id: product.id, metadata: { "reason" => reason, "product" => JSON.parse(product.attributes.to_json) })
          expect(activity.source.user).to eq(user)
        end

        it_behaves_like "a service which notifies the case owner"
      end
    end

    context "when searching for product once removed from the case", :with_elasticsearch do
      let(:records) { Product.full_search(ElasticsearchQuery.new(product.name, {}, {})).records }

      before do
        product
        Product.import(refresh: :wait_for)
      end

      it "the product should remain searchable" do
        result

        expect(records.to_a).to include(product)
      end
    end
  end
end
