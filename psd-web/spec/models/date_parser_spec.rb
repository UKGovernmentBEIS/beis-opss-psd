require "rails_helper"

RSpec.describe DateParser do
  subject { described_class.new(input).date }

  context "when given a date object" do
    let(:input) { Date.new(2020, 1, 20) }

    it { is_expected.to eql(input) }
  end

  context "when given a hash containing a valid year, month and day" do
    let(:input) { { year: "2020", month: "1 ", day: "20 " } }

    it { is_expected.to eql(Date.new(2020, 1, 20)) }
  end

  context "when given ha ash containing invalid year, month and day numbers" do
    let(:input) { { year: "2020", month: "1", day: "32" } }

    it { is_expected.to eql(OpenStruct.new(year: "2020", month: "1", day: "32")) }
  end

  context "when given a hash containing non-numeric strings" do
    let(:input) { { year: "2020", month: "1", day: "20?" } }

    it { is_expected.to eql(OpenStruct.new(year: "2020", month: "1", day: "20?")) }
  end

  context "when given blank strings" do
    let(:input) { { year: "", month: "", day: "" } }

    it { is_expected.to be_nil }
  end

  context "when given nil" do
    let(:input) { nil }

    it { is_expected.to be_nil }
  end
end