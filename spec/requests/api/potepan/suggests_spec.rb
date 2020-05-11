require 'rails_helper'

RSpec.describe "suggest_api", type: :request do
  let!(:suggest1) { create(:potepan_suggest, keyword: 'ruby') }
  let!(:suggest2) { create(:potepan_suggest, keyword: 'ruby for women') }
  let!(:suggest3) { create(:potepan_suggest, keyword: 'ruby for men') }
  let!(:suggest4) { create(:potepan_suggest, keyword: 'rails') }
  let!(:suggest5) { create(:potepan_suggest, keyword: 'rails for women') }
  let!(:suggest6) { create(:potepan_suggest, keyword: 'rails for men') }
  let!(:key) { Rails.application.credentials.api[:api_key] }

  context 'When r and 5 parameters are received with authentication' do
    it 'returns 200 status and 5 suggestion about r' do
      get '/api/potepan/suggest/?keyword=r&max_num=5', headers: { 'Authorization': "Bearer #{key}" }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json).to include suggest1.keyword,
                              suggest2.keyword,
                              suggest3.keyword,
                              suggest4.keyword,
                              suggest5.keyword
    end
  end

  context 'When r and 5 parameters are received without authentication' do
    it 'returns 401 status and error message' do
      get '/api/potepan/suggest/?keyword=r&max_num=5'
      expect(response.status).to eq(401)
      expect(response.body).to eq 'unauthorized'
    end
  end
end
