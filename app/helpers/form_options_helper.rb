module FormOptionsHelper
  LEGISLATION_CACHE_KEY = "relevant_legislation".freeze

  def relevant_legislation
    Rails.application.config.legislation_constants["legislation"]&.sort
  end

  def hazard_types
    Rails.application.config.hazard_constants["hazard_type"]
  end

  def product_categories
    Rails.application.config.product_constants["product_category"]
  end

  def corrective_action_geographic_scope
    Rails.application.config.corrective_action_constants["geographic_scope"]
  end

  def corrective_action_summary_radio_items(form)
    items = Rails.application
              .config
              .corrective_action_constants["summary"].map { |summary| { text: summary.upcase_first, value: summary } }
    items << {
      text: "Other",
      value: "other",
      conditional: {
        html: form.govuk_text_area(
          :other_action,
          label: "Other action",
          label_classes: "govuk-visually-hidden"
        )
      }
    }
    items
  end
end
