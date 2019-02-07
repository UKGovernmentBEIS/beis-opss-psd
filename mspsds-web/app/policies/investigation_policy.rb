class InvestigationPolicy < ApplicationPolicy
  def destroy?
    @user.has_role? :admin
  end

  def show?(user: @user)
    visible_to(user: user)
  end

  def assign?(user: @user)
    can_be_assigned_by(user: user)
  end

  def visibility?(user: @user)
    visible_to(user: user, private: true)
  end

  def visible_to(user:, private: @record.is_private)
    return true unless private
    return true if @record.assignee.present? && (@record.assignee&.organisation == user.organisation)
    return true if @record.source.respond_to?(:user) && @record.source&.user&.present? && (@record.source&.user&.organisation == user.organisation)
    return true if user.is_opss?

    false
  end

  def can_be_assigned_by(user: @user)
    return true if @record.assignee.blank?
    return true if @record.assignee.is_a?(Team) && (user.teams.include? @record.assignee)
    return true if @record.assignee.is_a?(User) && (user.teams && @record.assignee.teams).any? || @record.assignee == user

    false
  end

end
