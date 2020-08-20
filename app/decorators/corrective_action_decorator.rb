class CorrectiveActionDecorator < ApplicationDecorator
  delegate_all
  include SupportingInformationHelper

  MEDIUM_TITLE_TEXT_SIZE_THRESHOLD = 62

  def details
    return if object.details.blank?

    h.simple_format(object.details)
  end

  def supporting_information_title
    CorrectiveAction.actions[other? ? other_action : action]
  end

  def date_of_activity
    date_decided.to_s(:govuk)
  end

  def date_of_activity_for_sorting
    date_decided
  end

  def date_added
    created_at.to_s(:govuk)
  end

  def show_path
    h.investigation_action_path(investigation, object)
  end

  def measure_type
    object.measure_type&.upcase_first
  end

  def duration
    object.duration.upcase_first
  end

  def file_attached?
    documents.any?
  end

  def display_medium_title_text_size?
    return false if other_action.nil?

    other_action.length > MEDIUM_TITLE_TEXT_SIZE_THRESHOLD
  end
end
