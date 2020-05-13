class Api::Potepan::SuggestsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  def index
    if params[:keyword].present?
      if params[:max_num].blank?
        params[:max_num] = 5
      end
      suggests = Potepan::Suggest.
        where('keyword like ?', "#{params[:keyword]}%").
        limit(params[:max_num]).
        pluck(:keyword)
      render status: 200, json: suggests
    else
      render status: 422, json: {}
    end
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
