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
      get '/api/potepan/suggests/?keyword=r&max_num=5', headers: { 'Authorization': "Bearer #{key}" }
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result).to eq ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]
    end
  end

  context 'When there is no keyword parameter with authentication' do
    it 'returns 422 status and blank' do
      get '/api/potepan/suggests/?keyword=&max_num=5', headers: { 'Authorization': "Bearer #{key}" }
      expect(response.status).to eq(422)
      expect(response.body).to eq '{}'
    end
  end

  context 'When r and 5 parameters are received with wrong authentication' do
    it 'returns 401 status and error message' do
      get '/api/potepan/suggests/?keyword=r&max_num=5', headers: { 'Authorization': 'Bearer wrong_key' }
      expect(response.status).to eq(401)
      expect(response.body).to eq 'unauthorized'
    end
  end

  context 'When r and 5 parameters are received without authentication' do
    it 'returns 401 status and error message' do
      get '/api/potepan/suggests/?keyword=r&max_num=5'
      expect(response.status).to eq(401)
      expect(response.body).to eq 'unauthorized'
    end
  end
end
