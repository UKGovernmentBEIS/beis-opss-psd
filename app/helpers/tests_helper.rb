module TestsHelper
  def test_result_summary_rows(test_result)
    rows = [
      {
        key: { text: "Date of test" },
        value: { text: test_result.date.to_s(:govuk) }
      },
      {
        key: { text: "Product tested" },
        value: { html: link_to(test_result.product.name, product_path(test_result.product)) }
      },
      {
        key: { text: "Legislation" },
        value: { text: test_result.legislation }
      }
    ]
    if test_result.standards_product_was_tested_against.present?
      rows << {
        key: { text: "Standards" },
        value: { text: test_result.standards_product_was_tested_against }
      }
    end

    rows << {
      key: { text: "Result" },
      value: { text: test_result.result.upcase_first }
    }

    if test_result.result == "failed"
      rows << {
        key: { text: "Reason for failure" },
        value: { text: test_result.failure_details }
      }
    end

    if test_result.details.present?
      rows << {
        key: { text: "Further details" },
        value: { text: test_result.details }
      }
    end

    attachment_description = test_result.document.blob.metadata["description"]
    if attachment_description.present?
      rows << {
        key: { text: "Attachment description" },
        value: { text: attachment_description }
      }
    end

    rows
  end

  def result_items(form)
    [
      { text: Test::Result.results["passed"], value: "passed" },
      { text: Test::Result.results["failed"], value: "failed", conditional: { html: form.govuk_text_area(:failure_details, label: "How the product failed", hint: "Describe how the product was tested and how it failed to meet the requirements", label_classes: "govuk-label") } },
      { text: Test::Result.results["other"], value: "other" }
    ]
  end
end
