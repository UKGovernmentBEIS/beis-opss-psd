class InviteUserToTeam
  include Interactor

  delegate :user, :team, :inviting_user, to: :context

  def call
    context.fail!(error: "No email or user supplied") unless email || user
    context.fail!(error: "No team supplied") unless team

    context.user ||= find_or_create_user

    send_invite
  end

private

  def find_or_create_user
    existing_user = User.find_by email: email
    existing_user&.team == team ? existing_user : create_user
  end

  def create_user
    User.create!(
      email: email,
      organisation: team.organisation,
      skip_password_validation: true,
      team: team
    )
  end

  def send_invite
    if !user.invitation_token || (user.invited_at < 1.hour.ago)
      user.update! invitation_token: (user.invitation_token || SecureRandom.hex(15)), invited_at: Time.zone.now
    end

    SendUserInvitationJob.perform_later(user.id, inviting_user&.id)
  end

  def email
    # User emails are forced to lower case when saved, so we must compare case insensitively
    context.email&.downcase
  end
end
