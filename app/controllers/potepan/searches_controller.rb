require 'httpclient'

class Potepan::SearchesController < ApplicationController
  def suggest
    url = 'https://presite-potepanec-task5.herokuapp.com/potepan/api/suggests'
    client = HTTPClient.new
    response = client.get(url, query, headers)
    result = JSON.parse(response.body)
    if response.status == 200
      if params[:keyword].present?
        render status: 200, json: result
      else
        render status: 200, body: nil
      end
    else
      render status: response.status, json: response.body
    end
  end

  private

  def query
    { 'keyword': params[:keyword], 'max_num': params[:max_num] }
  end

  def headers
    key = Rails.application.credentials.api[:api_key]
    { 'Authorization': "Bearer #{key}" }
  end
end
