class Business < ApplicationRecord
  include BusinessesHelper
  include Searchable
  include Documentable
  include AttachmentConcern

  index_name [ENV.fetch("ES_NAMESPACE", "default_namespace"), Rails.env, "business"].join("_")

  settings do
    mappings do
      indexes :company_number, type: :keyword
      indexes :company_type_code, type: :keyword, fields: { sort: { type: "keyword" } }
      indexes :company_status_code, type: :keyword, fields: { sort: { type: "keyword" } }
    end
  end

  validates :trading_name, presence: true

  has_many_attached :documents

  has_many :investigation_businesses, dependent: :destroy
  has_many :investigations, through: :investigation_businesses

  has_many :locations, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :corrective_actions, dependent: :destroy
  has_many :risk_assessments, dependent: :destroy, foreign_key: :assessed_by_business_id

  accepts_nested_attributes_for :locations, reject_if: :all_blank
  accepts_nested_attributes_for :contacts, reject_if: :all_blank

  has_one :source, as: :sourceable, dependent: :destroy

  def supporting_information
    corrective_actions + risk_assessments
  end

  def primary_location
    locations.first
  end

  def primary_contact
    contacts.first
  end

  def pretty_description
    "Business: #{trading_name}"
  end

  def contacts_have_errors?
    contacts&.any? { |contact| contact.errors.any? } || false
  end

  def locations_have_errors?
    locations&.any? { |location| location.errors.any? } || false
  end
end
