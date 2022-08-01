# frozen_string_literal: true

require_relative "simmonsdreamcomfort/version"

require "f1sales_custom/hooks"

module Simmonsdreamcomfort
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      message = lead.message || ''
      source_name = lead.source ? lead.source.name : ''

      if message.include?('av._ibirapuera,_2453_-_moema') || message.include?('av._ibirapuera,_2.453_-_moema')
        "#{source_name} - Moema Loja 1"
      elsif message.include?('av._ibirapuera,_3000_-_moema')
        "#{source_name} - Moema Loja 2"
      elsif message.include?('av._corifeu_de_azevedo_marques,_549_-_butantã')
        "#{source_name} - Corifeu"
      elsif message.include?('av._braz_leme,_757_-_santana')
        "#{source_name} - Braz Leme"
      else
        lead.source.name
      end
    end
  end
end
