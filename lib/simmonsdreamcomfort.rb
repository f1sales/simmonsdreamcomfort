# frozen_string_literal: true

require_relative 'simmonsdreamcomfort/version'
require 'f1sales_custom/hooks'

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      message = lead.message || ''
      source_name = lead.source ? lead.source.name : ''

      if message[moema_address[0]] || message[moema_address[1]] || message[moema_address[2]]
        moema_address
        "#{source_name} - Moema"
      elsif message['av._corifeu_de_azevedo_marques,_549_-_butantã']
        "#{source_name} - Corifeu"
      elsif message['av._braz_leme,_757_-_santana'] || message['Av. Braz Leme, 757 - Santana, São Paulo - SP']
        "#{source_name} - Braz Leme"
      else
        source_name
      end
    end

    def self.moema_address
      %w[
        av._ibirapuera,_2453_-_moema
        av._ibirapuera,_2.453_-_moema
        av._ibirapuera,_3000_-_moema
      ]
    end
  end
end
