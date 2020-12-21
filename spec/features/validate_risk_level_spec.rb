require "rails_helper"

RSpec.feature "Validate risk level", :with_stubbed_elasticsearch, :with_stubbed_antivirus, :with_stubbed_mailer do
  let(:investigation) { create(:project, creator: creator_user) }
  let(:user) { create(:user, :activated) }
  let(:creator_user) { create(:user, :activated) }

  context "when user does not have `risk_level_validator` role" do
    it "does not show the validate button" do
      sign_in user
      visit investigation_path(investigation)

      expect(page).not_to have_link "Validate"
    end
  end

  context "when user has `risk_level_validator` role" do
    before do
      AddTeamToCase.call!(
        user: user,
        investigation: investigation,
        team: user.team,
        collaboration_class: Collaboration::Access::Edit
      )

      user.user_roles.create!(name: "risk_level_validator")
      sign_in user
      delivered_emails.clear
    end

    scenario "validate the level" do
      visit investigation_path(investigation)

      validation_link = page.find(:css, "a[href='/cases/#{investigation.pretty_id}/validate-risk-level/edit']")

      expect(validation_link.text).to eq "Validate"

      click_link "Validate"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}/validate-risk-level/edit")

      within_fieldset("Have you validated the case risk level?") do
        choose "Yes"
      end

      click_on "Continue"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}")
      expect(page).to have_content("Case risk level validated")
      expect(page).to have_content("Validated by #{user.team.name} on #{investigation.risk_validated_at}")
      expect(page).not_to have_link("Validate")

      click_on "Activity"
      expect(page).to have_content "Case risk level validation added"

      expect_email_with_correct_details_to_be_set("has been validated")
    end

    scenario "do not validate the level" do
      visit investigation_path(investigation)

      validation_link = page.find(:css, "a[href='/cases/#{investigation.pretty_id}/validate-risk-level/edit']")

      expect(validation_link.text).to eq "Validate"

      click_link "Validate"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}/validate-risk-level/edit")

      within_fieldset("Have you validated the case risk level?") do
        choose "No"
      end

      click_on "Continue"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}")
      expect(page).not_to have_content("Case risk level validated")
      expect(page).not_to have_content("Validated by #{user.team.name} on #{investigation.risk_validated_at}")
      expect(page).to have_link("Validate")

      click_on "Activity"
      expect(page).not_to have_content "Case risk level validation added"
    end

    scenario "remove validation" do
      visit("/cases/#{investigation.pretty_id}/validate-risk-level/edit")

      within_fieldset("Have you validated the case risk level?") do
        choose "Yes"
      end

      click_on "Continue"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}")

      validation_link = page.find(:css, "a[href='/cases/#{investigation.pretty_id}/validate-risk-level/edit']")
      expect(validation_link.text).to eq "Change"

      validation_link.click

      within_fieldset("Have you validated the case risk level?") do
        choose "No"
      end

      click_on "Continue"

      expect(page).to have_content("Enter details")

      within_fieldset("Have you validated the case risk level?") do
        choose "No"
        fill_in "Why?", with: "Mistake made by team member"
      end

      click_on "Continue"

      expect(page).to have_current_path("/cases/#{investigation.pretty_id}")
      expect(page).not_to have_content("Case risk level validated")
      expect(page).not_to have_content("Validated by #{user.team.name} on #{investigation.risk_validated_at}")
      expect(page).to have_link("Validate")

      click_on "Activity"
      expect(page).to have_content "Case risk level validation removed"
      expect(page).to have_content "Mistake made by team member"

      expect_email_with_correct_details_to_be_set("has had validation removed")
    end

    def expect_email_with_correct_details_to_be_set(action)
      email = delivered_emails.select {|email| email.recipient == creator_user.team.email}.last

      expect(email.recipient).to eq creator_user.team.email
      expect(email.action_name).to eq "risk_validation_updated"
      expect(email.personalization).to include(
        name: creator_user.team.name,
        case_title: investigation.user_title,
        case_type: "project",
        case_id: investigation.pretty_id,
        updater_name: user.name,
        updater_team_name: user.team.name,
        action: action
      )
    end
  end
end