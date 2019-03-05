require "application_system_test_case"

class AlertTest < ApplicationSystemTestCase
  setup do
    sign_in_as_user
    @investigation = investigations(:one)
    @alert = alerts :one
    visit investigation_path(@investigation)

    first(:link, "Add activity").click
  end

  teardown do
    logout
  end

  test "prepopulates email content with link to case" do
    fill_in_activity_selection
    click_on "Compose new alert"
    assert_includes(find_field(:alert_description).value, investigation_path(@investigation))
  end

  test "sends notify email" do
    stub_email_alert
    fill_in_activity_selection
    click_on "Compose new alert"

    fill_in_compose_alert @alert

    assert_text "Preview your alert"
    assert_text @alert.summary
    assert_text @alert.description

    click_on "Send to XXXX people"

    expected_number_of_emails_sent = User.all.length
    assert_equal(expected_number_of_emails_sent, @number_of_emails_sent)
    assert_text @investigation.title
    assert_text "Alert sent XXXX"
  end

  test "requires a restricted case be derestricted before raising an alert" do
    @private_investigaton = investigations :private
    fill_in_activity_selection
    assert_selector :h1, text: "You cannot send an alert about a restricted case"

    click_on "Change case visibility"
    assert_selector :h1, text: "Legal privelege"
  end

  def fill_in_activity_selection
    choose "activity_type_alert", visible: false
    click_on "Continue"
  end

  def fill_in_compose_alert alert
    fill_in :alert_summary, with: alert.summary
    fill_in :alert_description, with: alert.description
    click_on "Preview alert"
  end

  def stub_email_alert
    result = ""
    @number_of_emails_sent = 0
    allow(result).to receive(:deliver_later)
    allow(NotifyMailer).to receive(:alert) do |_id, _user_name, _user_email, _text|
      @number_of_emails_sent += 1
      result
    end
  end
end
