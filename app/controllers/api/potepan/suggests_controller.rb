class Api::Potepan::SuggestsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  def index
    if params[:keyword].present?
      params[:max_num] = 5 if params[:max_num].blank?
      suggests = Potepan::Suggest.
        where('keyword like ?', "#{params[:keyword]}%").
        limit(params[:max_num]).
        pluck(:keyword)
      render status: 200, json: suggests
    else
      render status: 422, json: 'Unprocessable Entity'
    end
  end

  private

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _|
      token == Rails.application.credentials.api[:api_key]
    end
  end

  def render_unauthorized
    render status: 401, json: 'unauthorized'
  end
end
