require 'rails_helper'

RSpec.describe 'API key' do
  describe 'generation' do
    it 'can generate an API key' do
      key = ApiKey.generator
      expect(key).to be_a(String)
    end
  end
end