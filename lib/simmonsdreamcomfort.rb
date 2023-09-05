# frozen_string_literal: true

require_relative 'simmonsdreamcomfort/version'
require 'f1sales_custom/hooks'

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      SOURCE_PATTERNS = {
        'Moema 1' => ['avibirapuera2453'],
        'Moema 2' => ['avibirapuera3000'],
        'Moema 3' => ['avibirapuera3399'],
        'Corifeu' => ['avcorifeudeazevedomarques'],
        'Braz Leme' => ['avbrazleme757'],
        'Sumaré' => ['avsumare'],
        'Morumbi' => ['avavenidamorumbi'],
      }.freeze

      def switch_source(lead)
        @lead = lead

        detected_source_message = detect_source_message
        return "#{source_name} - #{detected_source_message}" if detected_source_message

        return "#{source_name} - Moema 1" if moema_1?
        return "#{source_name} - Corifeu" if corifeu?
        return "#{source_name} - Sumaré" if sumare?
        return "#{source_name} - Morumbi" if morumbi?
        return "#{source_name} - Ibirapuera" if ibirapuera?
        return "#{source_name} - Indianópolis" if indianopolis?
        return "#{source_name} - Alphaville" if alphaville?

        source_name
      end

      private

      def detect_source_message
        SOURCE_PATTERNS.each do |source_name, patterns|
          return source_name if patterns.any? do |pattern|
            message[pattern]
          end
        end
        nil
      end

      def source_name
        @lead.source&.name || ''
      end

      def product_name
        @lead.product.name.downcase || ''
      end

      def message
        message_down = @lead.message&.downcase || ''
        message_down.gsub(/[^a-zA-Z\d]/, '')
      end

      def moema_1?
        product_name['moema']
      end

      def corifeu?
        product_name['corifeu']
      end

      def sumare?
        product_name['sumar']
      end

      def morumbi?
        product_name['morumbi']
      end

      def ibirapuera?
        product_name['ibirapuera']
      end

      def indianopolis?
        product_name['indian']
      end

      def alphaville?
        product_name['alphavi']
      end
    end
  end
end
