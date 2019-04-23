require 'administrate/field/string'
require 'administrate/field/hyperlink/version'
require 'rails/engine'

module Administrate
  module Field
    class Hyperlink < Administrate::Field::String
      include HyperlinkVersion
      class Engine < ::Rails::Engine
      end

      def present?
        (data.presence || options.fetch(:fallback_href) { nil }).present?
      end

      def to_s
        options.fetch(:label) do
          data.presence || options.fetch(:fallback_href) { nil }
        end
      end

      def href
        return options.fetch(:fallback_href) { nil } unless data.present?
        return data if data.include?('://') || data.start_with?('//')

        "#{options.fetch(:scheme) { 'https://' }}#{data}"
      end
    end
  end
end
