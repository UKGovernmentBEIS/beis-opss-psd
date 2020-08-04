class AuditActivity::Investigation::UpdateCoronavirusStatus < AuditActivity::Investigation::Base
  def self.from(investigation)
    super(investigation, I18n.t(".title.#{investigation.coronavirus_related?}", scope: i18n_scope), I18n.t(".body.#{investigation.coronavirus_related?}", scope: i18n_scope))
  end

  def email_update_text(viewer = nil)
    I18n.t(
      ".email_update_text.#{investigation.coronavirus_related?}",
      scope: self.class.i18n_scope,
      case_type: investigation.case_type.upcase_first,
      name: source&.show(viewer),
      pretty_id: investigation.pretty_id
    )
  end

  def email_subject_text
    I18n.t(".email_subject_text", scope: self.class.i18n_scope, case_type: investigation.case_type.downcase)
  end
end
