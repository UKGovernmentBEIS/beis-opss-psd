module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_touch { __elasticsearch__.index_document }

    # The following dynamic templates define custom mappings for the major data types
    # that automatically generate appropriate sort fields for each type.
    settings do
      mapping dynamic_templates: [
        {
          strings: {
            match_mapping_type: "string",
            mapping: {
              type: "text"
            }
          }
        },
        {
          numbers: {
            match_mapping_type: "long",
            mapping: {
              "type": "long",
              fields: {
                sort: {
                  type: "long"
                }
              }
            }
          }
        },
        {
          dates: {
            match_mapping_type: "date",
            mapping: {
              type: "date",
              fields: {
                sort: {
                  type: "date"
                }
              }
            }
          }
        },
        {
          booleans: {
            match_mapping_type: "boolean",
            mapping: {
              type: "boolean",
              fields: {
                sort: {
                  type: "boolean"
                }
              }
            }
          }
        }
      ]
    end

    def self.full_search(query)
      __elasticsearch__.search(query.build_query(highlighted_fields, fuzzy_fields, exact_fields))
    end

    # "prefix" may be changed to a more appropriate query. For alternatives see:
    # https://www.elastic.co/guide/en/elasticsearch/reference/current/term-level-queries.html
    def self.prefix_search(params, field)
      query = {}
      if params[:query].present?
        query[:query] = {
          prefix: {
            "#{field}": params[:query]
          }
        }
      end
      query[:sort] = sort_params(params) if params[:sort].present?

      __elasticsearch__.search(query)
    end

    def self.sort_params(params)
      sort_field = "#{params[:sort]}.sort"
      [{ "#{sort_field}": { order: params[:direction] } }]
    end

    def self.highlighted_fields
      # To be overwritten by the model using it, defaults to all sent fields
      %w[*]
    end

    def self.fuzzy_fields
      # To be overwritten by the model using it, defaults to all fields
      []
    end

    def self.exact_fields
      # To be overwritten by the model using it, defaults to all fields
      # Bear in mind that if you have a field both here and in fuzzy_fields, your result will just be fuzzy
      []
    end
  end
end
