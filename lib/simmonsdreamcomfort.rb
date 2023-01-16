# frozen_string_literal: true

require_relative 'simmonsdreamcomfort/version'
require 'f1sales_custom/hooks'

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @message = lead.message || ''
        source_name = lead.source ? lead.source.name : ''

        return "#{source_name} - Moema 1" if moema_1?

        return "#{source_name} - Moema 2" if moema_2?

        return "#{source_name} - Moema 3" if moema_3?

        return "#{source_name} - Corifeu" if corifeu?

        return "#{source_name} - Braz Leme" if braz_leme?

        return "#{source_name} - Sumaré" if sumare?

        source_name
      end

      def moema_1?
        @message[moema_address[0]] || @message[moema_address[1]]
      end

      def moema_2?
        @message[moema_address[2]]
      end

      def moema_3?
        @message[moema_address[3]]
      end

      def moema_address
        %w[
          av._ibirapuera,_2453_-_moema
          av._ibirapuera,_2.453_-_moema
          av._ibirapuera,_3000_-_moema
          av._ibirapuera,_3399_-_moema
        ]
      end

      def corifeu?
        @message['av._corifeu_de_azevedo_marques']
      end

      def braz_leme?
        @message['av._braz_leme,_757_-_santana'] || @message['Av. Braz Leme, 757 - Santana, São Paulo - SP']
      end

      def sumare?
        @message['av_sumare']
      end
    end
  end
end
