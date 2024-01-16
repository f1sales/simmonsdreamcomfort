# frozen_string_literal: true

require_relative 'simmonsdreamcomfort/version'
require 'f1sales_custom/hooks'

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      SOURCE_PATTERNS_MESSAGE = {
        'Moema 1' => ['avibirapuera2453'],
        'Moema 2' => ['avibirapuera3000'],
        'Moema 3' => ['avibirapuera3399'],
        'Corifeu' => ['avcorifeudeazevedomarques'],
        'Braz Leme' => ['avbrazleme757'],
        'Sumaré' => ['avsumare'],
        'Morumbi' => ['avavenidamorumbi']
      }.freeze

      SOURCE_PATTERNS_PRODUCT = {
        'Moema 1' => ['moema'],
        'Corifeu' => ['corifeu'],
        'Sumaré' => ['sumar'],
        'Morumbi' => ['morumbi'],
        'Ibirapuera' => ['ibirapuera'],
        'Indianópolis' => ['indian'],
        'Alphaville' => ['alphavi'],
        'Ipiranga' => ['ipiranga']
      }.freeze

      def switch_source(lead)
        @lead = lead

        return "#{source_name} - 4Art" if fourart_utm?

        detected_source_message = detect_source_message
        return "#{source_name} - #{detected_source_message}" if detected_source_message

        detected_source_product = detect_source_product
        return "#{source_name} - #{detected_source_product}" if detected_source_product

        source_name
      end

      private

      def detect_source_message
        SOURCE_PATTERNS_MESSAGE.each do |source_name, patterns|
          return source_name if patterns.any? { |pattern| message[pattern] }
        end
        nil
      end

      def detect_source_product
        SOURCE_PATTERNS_PRODUCT.each do |source_name, patterns|
          return source_name if patterns.any? { |pattern| product_name[pattern] }
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

      def fourart_utm?
        @lead.customer.utm&.medium == '4art'
      end
    end
  end
end
