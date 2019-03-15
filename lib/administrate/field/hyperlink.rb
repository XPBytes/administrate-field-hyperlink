require 'administrate/field/hyperlink/version'
require 'rails'

module Administrate
  module Field
    class Hyperlink < Administrate::Field::String
      class Engine < ::Rails::Engine
      end

      def to_s
        data
      end

      def href
        return data if data.include?('://') || data.start_with?('//')

        "#{options.fetch(:scheme) { 'https://' }}#{data}"
      end
    end
  end
end
