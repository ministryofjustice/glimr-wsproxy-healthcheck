require 'spec_helper'

describe 'main app' do
  let(:glimr_status) { double('glimr_call') }

  before do
    expect(GlimrApiClient::Available).to receive(:call).and_return(glimr_status)
  end

  context 'GLiMR can be reached' do
    before do
      allow(glimr_status).to receive(:available?).and_return(true)
      get '/healthcheck.json'
    end

    it 'returns a status of 200' do
      expect(last_response.status).to eq(200)
    end

    it 'returns `{"service_status":"ok","dependencies":{"glimr_status":"ok"}}`' do
      expect(last_response.body).to eq('{"service_status":"ok","dependencies":{"glimr_status":"ok"}}')
    end
  end

  context 'GLiMR cannot be reached' do
    before do
      allow(glimr_status).to receive(:available?).and_raise(GlimrApiClient::Unavailable)
      get '/healthcheck.json'
    end

    it 'returns a 502' do
      expect(last_response.status).to eq(502)
    end

    it 'returns `{"service_status":"failed","dependencies":{"glimr_status":"failed"}}`' do
      expect(last_response.body).to eq('{"service_status":"failed","dependencies":{"glimr_status":"failed"}}')
    end
  end
end
