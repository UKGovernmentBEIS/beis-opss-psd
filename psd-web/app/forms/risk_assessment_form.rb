class RiskAssessmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :investigation
  attribute :current_user

  attribute :assessed_on
  attribute :risk_level
  attribute :custom_risk_level

  attribute :assessed_by
  attribute :assessed_by_team_id
  attribute :assessed_by_business_id
  attribute :assessed_by_other

  attribute :product_ids

  attribute :risk_assessment_file

  attribute :details

  validates :assessed_on, presence: true
  validates :risk_level, presence: true

  validates :risk_assessment_file, presence: true

  validates :assessed_by, presence: true
  validate :at_least_one_product_associated

  validates :assessed_by_team_id, presence: true, if: -> { assessed_by == "another_team" }
  validates :assessed_by_business_id, presence: true, if: -> { assessed_by == "business" }
  validates :assessed_by_other, presence: true, if: -> { assessed_by == "other" }

  validates :assessed_on,
            real_date: true,
            complete_date: true

  validate :assessed_on_cannot_be_in_future
  validate :assessed_on_cannot_be_older_than_1970

  def risk_levels
    {
      serious: "serious",
      high: "high",
      medium: "medium",
      low: "low",
      other: "other"
    }
  end

  def assessed_by_team_id
    if assessed_by == "my_team"
      current_user.team_id
    else
      super
    end
  end

  # Expects either a date object, or a hash containing
  # year, month and day, for example:
  #
  # {year: "2019", month: "01", day: "20"}
  def assessed_on=(assessed_on)
    super(DateParser.new(assessed_on).date)
  end

private

  def assessed_on_cannot_be_in_future
    if assessed_on.is_a?(Date) && assessed_on > Date.today

      errors.add(:assessed_on, :in_future)
    end
  end

  def assessed_on_cannot_be_older_than_1970
    if assessed_on.is_a?(Date) && assessed_on < Date.parse("1970-01-01")
      errors.add(:assessed_on, :too_old)
    end
  end

  def at_least_one_product_associated
    return unless product_ids.to_a.empty?

    errors.add(:product_ids, :blank)
  end
end
