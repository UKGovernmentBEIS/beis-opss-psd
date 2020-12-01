module ActiveModel
  module Types
    class CommaSeparatedList < ActiveRecord::Type::Value
      def cast(value)
        return value if value.is_a?(Array)
        return [] if value.nil?

        value.split(",").map(&:squish)
      end
    end
  end
end