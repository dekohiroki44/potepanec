class Potepan::SearchsController < ApplicationController
  require 'httpclient'
  def suggest
    url = Rails.application.credentials.api[:url]
    key = Rails.application.credentials.api[:api_key]
    headers = { 'Authorization': "Bearer #{key}" }
    client = HTTPClient.new
    if params[:keyword].present?
      query = { 'keyword': params[:keyword], 'max_num': params[:max_num] }
      response = client.get(url, query, headers)
      @result = JSON.parse(response.body)
      if response.status == 200
        render status: 200, json: @result
      elsif response.status == 500
        render status: 500, json: response.body
      end
    else
      render body: nil
    end
  end
end
