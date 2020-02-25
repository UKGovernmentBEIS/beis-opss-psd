class NotifyMailer < GovukNotifyRails::Mailer
  TEMPLATES =
    {
      reset_password_instruction: "e85c3c6c-272d-4c43-b8fb-e7d266bc2bd9",
      investigation_updated: "10a5c3a6-9cc7-4edb-9536-37605e2c15ba",
      investigation_created: "6da8e1d5-eb4d-4f9a-9c3c-948ef57d6136",
      alert: "47fb7df9-2370-4307-9f86-69455597cdc1",
      user_added_to_team: "e3b2bbf5-3002-49fb-adb5-ad18e483c7e4",
      welcome: "035876e3-5b97-4b4c-9bd5-c504b5158a85",
      invitation: "7b80a680-f8b3-4032-982d-2a3a662b611a"
    }.freeze

  def reset_password_instruction(user, token)
    set_template(TEMPLATES[:reset_password_instruction])
    set_reference("Password reset")
    set_personalisation(
      name: user.name,
      reset_url: edit_user_password_url(reset_password_token: token)
    )

    mail(to: user.email)
  end

  def invitation_email(user, inviting_user)
    set_template(TEMPLATES[:invitation])

    invitation_url = create_account_user_url(user.id, invitation: user.invitation_token)

    set_personalisation(invitation_url: invitation_url, inviting_team_member_name: inviting_user.name)
    mail(to: user.email)
  end

  def welcome(name, email)
    set_template(TEMPLATES[:welcome])
    set_reference("Welcome")

    set_personalisation(name: name)

    mail(to: email)
  end

  def investigation_updated(investigation_pretty_id, name, email, update_text, subject_text)
    set_template(TEMPLATES[:investigation_updated])
    set_reference("Case updated")

    set_personalisation(
      name: name,
      investigation_url: investigation_url(pretty_id: investigation_pretty_id),
      update_text: update_text,
      subject_text: subject_text
    )

    mail(to: email)
  end

  def alert(email, subject_text:, body_text:)
    set_template(TEMPLATES[:alert])
    set_reference("Alert")

    set_personalisation(
      subject_text: subject_text,
      email_text: body_text
    )

    mail(to: email)
  end

  def investigation_created(investigation_pretty_id, name, email, investigation_title, investigation_type)
    set_template(TEMPLATES[:investigation_created])
    set_reference("Case created")

    set_personalisation(
      name: name,
      case_title: investigation_title,
      case_type: investigation_type,
      case_id: investigation_pretty_id,
      investigation_url: investigation_url(pretty_id: investigation_pretty_id)
    )

    mail(to: email)
  end

  def user_added_to_team(email,
                         name:,
                         team_page_url:,
                         team_name:,
                         inviting_team_member_name:)
    set_template(TEMPLATES[:user_added_to_team])
    set_personalisation(
      name: name,
      team_page_url: team_page_url,
      team_name: team_name,
      inviting_team_member_name: inviting_team_member_name
    )
    mail(to: email)
  end
end
