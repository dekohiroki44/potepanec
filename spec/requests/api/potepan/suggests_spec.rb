require 'rails_helper'

RSpec.describe "suggest_api", type: :request do
  let!(:suggest1) { create(:potepan_suggest, keyword: 'ruby') }
  let!(:suggest2) { create(:potepan_suggest, keyword: 'ruby for women') }
  let!(:suggest3) { create(:potepan_suggest, keyword: 'ruby for men') }
  let!(:suggest4) { create(:potepan_suggest, keyword: 'rails') }
  let!(:suggest5) { create(:potepan_suggest, keyword: 'rails for women') }
  let!(:suggest6) { create(:potepan_suggest, keyword: 'rails for men') }
  let!(:key) { Rails.application.credentials.api[:api_key] }

  before do
    get "/api/potepan/suggests/?keyword=#{keyword}&max_num=#{max_num}", headers: authentication
  end

  context 'When r and 5 parameters are received with authentication' do
    let(:keyword) { 'r' }
    let(:max_num) { 5 }
    let(:authentication) { { 'Authorization': "Bearer #{key}" } }

    it 'returns 200 status and 5 suggestion about r' do
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result).to eq ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]
    end
  end

  context 'When there is no keyword parameter with authentication' do
    let(:keyword) { '' }
    let(:max_num) { 5 }
    let(:authentication) { { 'Authorization': "Bearer #{key}" } }

    it 'returns 422 status and error message' do
      expect(response.status).to eq(422)
      expect(response.body).to eq 'Unprocessable Entity'
    end
  end

  context 'When there is no keyword parameter with authentication' do
    let(:keyword) { 'r' }
    let(:max_num) { '' }
    let(:authentication) { { 'Authorization': "Bearer #{key}" } }

    it 'returns 200 status and 5 suggestion about r' do
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result).to eq ["ruby", "ruby for women", "ruby for men", "rails", "rails for women"]
    end
  end

  context 'When r and 5 parameters are received with wrong authentication' do
    let(:keyword) { 'r' }
    let(:max_num) { 5 }
    let(:authentication) { { 'Authorization': "Bearer wrong_key" } }

    it 'returns 401 status and error message' do
      expect(response.status).to eq(401)
      expect(response.body).to eq 'unauthorized'
    end
  end

  context 'When r and 5 parameters are received without authentication' do
    let(:keyword) { 'r' }
    let(:max_num) { 5 }
    let(:authentication) { nil }

    it 'returns 401 status and error message' do
      expect(response.status).to eq(401)
      expect(response.body).to eq 'unauthorized'
    end
  end
end
