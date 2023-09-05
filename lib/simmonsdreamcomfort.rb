# frozen_string_literal: true

require_relative 'simmonsdreamcomfort/version'
require 'f1sales_custom/hooks'

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead
        return "#{source_name} - Moema 1" if moema_1?
        return "#{source_name} - Moema 2" if moema_2?
        return "#{source_name} - Moema 3" if moema_3?
        return "#{source_name} - Corifeu" if corifeu?
        return "#{source_name} - Braz Leme" if braz_leme?
        return "#{source_name} - Sumaré" if sumare?
        return "#{source_name} - Morumbi" if morumbi?
        return "#{source_name} - Ibirapuera" if ibirapuera?
        return "#{source_name} - Indianópolis" if indianopolis?
        return "#{source_name} - Alphaville" if alphaville?

        source_name
      end

      private

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
        message[moema_address[0]] || product_name['moema']
      end

      def moema_2?
        message[moema_address[1]]
      end

      def moema_3?
        message[moema_address[2]]
      end

      def moema_address
        %w[avibirapuera2453 avibirapuera3000 avibirapuera3399]
      end

      def corifeu?
        message['avcorifeudeazevedomarques'] || product_name['corifeu']
      end

      def braz_leme?
        message['avbrazleme757']
      end

      def sumare?
        message['avsumare'] || product_name['sumar']
      end

      def morumbi?
        message['avavenidamorumbi'] || product_name['morumbi']
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
