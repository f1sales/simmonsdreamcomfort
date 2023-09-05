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
        @lead.message&.gsub('.', '') || ''
      end

      def moema_1?
        message[moema_address[0]] || message[moema_address[1]] || product_name['moema']
      end

      def moema_2?
        message[moema_address[2]] || message[moema_address[3]]
      end

      def moema_3?
        message[moema_address[4]] || message[moema_address[5]]
      end

      def moema_address
        [
          'av_ibirapuera,_2453_-_moema',
          'Av Ibirapuera, 2453',
          'av_ibirapuera,_3000_-_moema',
          'Av Ibirapuera, 3000',
          'av_ibirapuera,_3399_-_moema',
          'Av Ibirapuera, 3399'
        ]
      end

      def corifeu?
        message['av_corifeu_de_azevedo_marques'] || product_name['corifeu'] || message['Av Corifeu de Azevedo Marques']
      end

      def braz_leme?
        message['av_braz_leme,_757_-_santana'] || message['Av Braz Leme, 757']
      end

      def sumare?
        message['av_sumare'] || message['Av Sumare, 1101'] || product_name['sumar']
      end

      def morumbi?
        message['av_avenida_morumbi,_6930'] || product_name['morumbi']
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
