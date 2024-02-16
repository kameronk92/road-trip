require 'rails_helper'

RSpec.describe 'forecast facade' do
  describe '#get_summary' do
    it 'returns a summary of the forecast for a given location' do
      VCR.use_cassette('forecast_summary') do
        summary = ForecastFacade.get_summary('san luis obispo, ca')

        expect(summary).to be_a(Hash)
        expect(summary).to have_key(:summary)
        expect(summary[:summary]).to be_a(String)
        expect(summary).to have_key(:temperature)  
        expect(summary[:temperature]).to be_a(String)
      end
    end
  end
end