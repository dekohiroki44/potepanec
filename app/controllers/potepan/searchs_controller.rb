require 'httpclient'
class Potepan::SearchsController < ApplicationController
  def suggest
    url = 'https://presite-potepanec-task5.herokuapp.com/potepan/api/suggests'
    key = Rails.application.credentials.api[:api_key]
    headers = { 'Authorization': "Bearer #{key}" }
    client = HTTPClient.new
    query = { 'keyword': params[:keyword], 'max_num': params[:max_num] }
    response = client.get(url, query, headers)
    @result = JSON.parse(response.body)
    if response.status == 200
      if params[:keyword].present?
        render status: 200, json: @result
      else
        render status: 200, body: nil
      end
    else
      render status: response.status, json: response.body
    end
  end
end
