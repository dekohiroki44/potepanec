require 'httpclient'

class Potepan::SearchesController < ApplicationController
  def suggest
    if params[:keyword].present?
      url = Rails.application.credentials.api[:url]
      client = HTTPClient.new
      response = client.get(url, query, headers)
      result = JSON.parse(response.body)
      if response.status == 200
        render status: 200, json: result
      else
        render status: response.status, json: response.body
      end
    else
      render status: 200, json: {}
    end
  end

  private

  def query
    params.permit(:keyword, :max_num).to_h
  end

  def headers
    key = Rails.application.credentials.api[:api_key]
    { 'Authorization': "Bearer #{key}" }
  end
end
