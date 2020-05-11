class Api::Potepan::SuggestsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  def suggest
    suggest = Potepan::Suggest.
      where('keyword like ?', "#{params[:keyword]}%").
      limit(params[:max_num]).
      pluck(:keyword)
    render json: suggest
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      token == Rails.application.credentials.api[:api_key]
    end
  end

  def render_unauthorized
    render json: 'unauthorized', status: 401
  end
end
