require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:source_name) { 'Facebook - Simmons Dream Comfort' }
  let(:source) do
    source = OpenStruct.new
    source.name = source_name

    source
  end

  let(:lead) do
    lead = OpenStruct.new
    lead.source = source

    lead
  end

  context 'when message contains "av._ibirapuera,_2453._moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._ibirapuera,_2453._moema' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema Loja 1')
    end
  end

  context 'when message contains "av._ibirapuera,_3000._moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._ibirapuera,_3000._moema' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema Loja 2')
    end
  end

  context 'when message contains "av._ibirapuera,_2453._moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._corifeu_de_azevedo_marques,_549_-_butantã' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Corifeu')
    end
  end
end
