class ProductDecorator < ApplicationDecorator
  include FormattedDescription
  delegate_all
  decorates_association :investigations

  def pretty_description
    "Product: #{name}"
  end

  def summary_list
    rows = [
      { key: { text: "Category" }, value: { text: category } },
      { key: { text: "Product subcategory" }, value: { text: subcategory } },
      { key: { text: "Product authenticity" }, value: { text: authenticity } },
      { key: { text: "Product marking" }, value: { text: markings } },
      { key: { text: "Units affected" }, value: { text: units_affected } },
      { key: { text: "Product brand" }, value: { text: object.brand } },
      { key: { text: "Product name" }, value: { text: object.name } },
      { key: { text: "Barcode number" }, value: { text: gtin13 } },
      { key: { text: "Batch number" }, value: { text: batch_number } },
      { key: { text: "Other product identifiers" }, value: { text: product_code } },
      { key: { text: "Webpage" }, value: { text: object.webpage } },
      { key: { text: "Description" }, value: { text: description } },
      { key: { text: "Country of origin" }, value: { text: country_from_code(country_of_origin) } },
      { key: { text: "When placed on market" }, value: { text: when_placed_on_market } }
    ]
    rows.compact!
    h.render "components/govuk_summary_list", rows: rows
  end

  def authenticity
    I18n.t(object.authenticity || :missing, scope: Product.model_name.i18n_key)
  end

  def when_placed_on_market
    I18n.t(object.when_placed_on_market || :missing, scope: Product.model_name.i18n_key)
  end

  def product_type_and_category_label
    product_and_category = [product_type.presence, category.presence].compact

    if product_and_category.length > 1
      "#{product_and_category.first} (#{product_and_category.last.downcase})"
    else
      product_and_category.first
    end
  end

  def units_affected
    case object.affected_units_status
    when "exact"
      object.number_of_affected_units
    when "approx"
      object.number_of_affected_units
    when "unknown"
      I18n.t(".product.unknown")
    when "not_relevant"
      I18n.t(".product.not_relevant")
    else
      I18n.t(".product.not_provided")
    end
  end

  def markings
    return I18n.t(".product.not_provided") unless object.has_markings
    return I18n.t(".product.unknown") if object.markings_unknown?
    return I18n.t(".product.none") if object.markings_no?

    object.markings.join(", ")
  end
end
