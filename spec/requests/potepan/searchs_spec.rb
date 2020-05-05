require 'rails_helper'
require 'webmock/rspec'
require 'httpclient'
WebMock.allow_net_connect!
url = Rails.application.credentials.api[:url]
key = Rails.application.credentials.api[:api_key]
query = { 'keyword': 'r', 'max_num': 5 }
headers = { 'Authorization': "Bearer #{key}" }

RSpec.describe "Potepan::Searchs", type: :request do
  describe 'api_suggests' do
    context 'when works normally' do
      it 'returns 200 status and correct suggestion' do
        WebMock.stub_request(:get, url).
          with(query: query, headers: headers).
          to_return(status: 200, body: ['ruby', 'ruby for women', 'ruby for men', 'rails', 'rails for women'])
        client = HTTPClient.new
        response = client.get(url, query, headers)
        expect(response.status).to eq 200
        expect(response.body).to eq ['ruby', 'ruby for women', 'ruby for men', 'rails', 'rails for women']
      end
    end

    context 'when a system error occurs' do
      it 'returns 500 status and error message' do
        WebMock.stub_request(:get, url).
          with(query: query, headers: headers).
          to_return(status: 500, body: 'Internal Server Error')
        client = HTTPClient.new
        response = client.get(url, query, headers)
        expect(response.status).to eq 500
        expect(response.body).to eq 'Internal Server Error'
      end
    end
  end
end
