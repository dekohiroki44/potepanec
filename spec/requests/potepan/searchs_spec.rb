require "rails_helper"
require 'webmock/rspec'
WebMock.allow_net_connect!
url = Rails.application.credentials.api[:url]
key = Rails.application.credentials.api[:api_key]
query = { 'keyword': 'r', 'max_num': 5 }
headers = { 'Authorization': "Bearer #{key}" }
WORDS_SUGGESTED_BY_R = ['ruby', 'ruby for women', 'ruby for men', 'rails', 'rails for women']

RSpec.describe "Potepan::Searchs", type: :request do
  describe "api_suggests" do
    before do
      WebMock.stub_request(:get, url).
        with(query: hash_including(query), headers: headers).
        to_return(status: 200, body: WORDS_SUGGESTED_BY_R)
      get potepan_suggest_url, params: query
    end

    it 'returns 200 status and correct suggestion' do
      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)).to eq WORDS_SUGGESTED_BY_R
    end
  end
end
