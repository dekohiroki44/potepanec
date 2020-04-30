class Potepan::SearchsController < ApplicationController
  require 'httpclient'
  require 'json'
  def suggest
    url = Rails.application.credentials.api[:url]
    key = Rails.application.credentials.api[:api_key]
    header = { 'Authorization': "Bearer #{key}" }
    client = HTTPClient.new
    if params[:keyword].present?
      query = { 'keyword': params[:keyword], 'max_num': params[:max_num] }
      res = client.get(url, query, header)
      @result = JSON.parse(res.body)
      render json: @result
    else
      render body: nil
    end
  end
end
