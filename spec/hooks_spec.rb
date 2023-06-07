require 'ostruct'
require 'byebug'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:source_name) { 'Facebook - Simmons Dream Comfort' }
  let(:source) do
    source = OpenStruct.new
    source.name = source_name

    source
  end

  let(:product) do
    product = OpenStruct.new
    product.name = ''

    product
  end

  let(:lead) do
    lead = OpenStruct.new
    lead.source = source
    lead.product = product

    lead
  end

  context 'when message contains "av._ibirapuera,_2453_-_moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._ibirapuera,_2453_-_moema' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 1')
    end
  end

  context 'when message contains "av._ibirapuera,_2.453_-_moema"' do
    before { lead.message = 'a_loja_que_vai_te_atender_fica_na_av._ibirapuera,_2.453_-_moema: sim' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 1')
    end
  end

  context 'when message contains "av._ibirapuera,_3000_-_moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._ibirapuera,_3000_-_moema' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 2')
    end
  end

  context 'when message contains "av._ibirapuera,_3399_-_moema"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._ibirapuera,_3399_-_moema' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 3')
    end
  end

  context 'when message contains "av._corifeu_de_azevedo_marques,_549_-_butantã"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._corifeu_de_azevedo_marques,_549_-_butantã' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Corifeu')
    end
  end

  context 'when message contains "av._corifeu_de_azevedo_marques,_547_-_butantã"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._corifeu_de_azevedo_marques,_547_-_butantã' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Corifeu')
    end
  end

  context 'when message contains "av._braz_leme,_757_-_santana"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: av._braz_leme,_757_-_santana' }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Braz Leme')
    end
  end

  context 'when message contains "Av. Braz Leme, 757 - Santana, São Paulo - SP"' do
    before do
      lead.message = 'conditional_question_1: Santana; conditional_question_2: Av. Braz Leme, 757 - Santana, São Paulo - SP'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Braz Leme')
    end
  end

  context 'when message contains "av_sumare,_1101_- dream_comfort"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: perdizes_-_av_sumare,_1101_- dream_comfort' }

    it 'return source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Sumaré')
    end
  end

  context 'when message contains "morumbi_-_av_avenida_morumbi,_6930"' do
    before { lead.message = 'escolha_a_loja_por_onde_quer_ser_atendido: morumbi_-_av_avenida_morumbi,_6930' }

    it 'return source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Morumbi')
    end
  end

  context 'when message is nil' do
    before { lead.message = nil }

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort')
    end
  end

  context 'when source is nil' do
    before { lead.source = nil }

    it 'return source name' do
      expect(described_class.switch_source(lead)).to eq('')
    end
  end

  context 'when store name come in the field product name' do
    context 'when product contains LOJA CORIFEU' do
      before { product.name = 'LOJA CORIFEU - Form Brodway - 012022' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Corifeu')
      end
    end

    context 'when product contains Morumbi' do
      before { product.name = 'Loja Morumbi - Broadway - 24.05' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Morumbi')
      end
    end

    context 'when product contains Loja Moema' do
      before { product.name = 'Loja Moema 2453- Brodway - 24.05' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 1')
      end
    end

    context 'when product contains Loja Sumaré' do
      before { product.name = 'Loja Sumaré - Brodway - 24.05' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Sumaré')
      end
    end
  end

  context 'When lead does not go through Simmons' do
    context 'when message contains "Butanta - Av Corifeu de Azevedo Marques, 547 - Dream Confort"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Butanta - Av Corifeu de Azevedo Marques, 547 - Dream Confort'
      end

      it 'returns source - Corifeu' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Corifeu')
      end
    end

    context 'when message contains "Moema - Av Ibirapuera, 2453 - Dream Confort"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Moema - Av Ibirapuera, 2453 - Dream Confort'
      end

      it 'returns source - Moema 1' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 1')
      end
    end

    context 'when message contains "Moema - Av Ibirapuera, 3000 - Dream Confort"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Moema - Av Ibirapuera, 3000 - Dream Confort'
      end

      it 'returns source - Moema 1' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 2')
      end
    end

    context 'when message contains "Moema - Av Ibirapuera, 3399 - DreamComfort Colchoes"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Moema - Av Ibirapuera, 3399 - DreamComfort Colchoes'
      end

      it 'returns source - Moema 1' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Moema 3')
      end
    end

    context 'when message contains "Santana - Av Braz Leme, 757 - Dream Confort"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Santana - Av Braz Leme, 757 - Dream Confort'
      end

      it 'returns source - Moema 1' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Braz Leme')
      end
    end

    context 'when message contains "Perdizes - Av Sumare, 1101 - DreamComfort Colchoes"' do
      before do
        lead.message = 'conditional_question_1: São Paulo; conditional_question_2: São Paulo; conditional_question_3: Perdizes - Av Sumare, 1101 - DreamComfort Colchoes'
      end

      it 'returns source - Moema 1' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Sumaré')
      end
    end

    context 'when store information comes in product' do
      before do
        product.name = 'LOJA I.IBIRAPUERA - 2453 - Broadway - 06.06.23'
      end

      it 'returns Source - Ibirapuera' do
        expect(described_class.switch_source(lead)).to eq('Facebook - Simmons Dream Comfort - Ibirapuera')
      end
    end
  end
end
