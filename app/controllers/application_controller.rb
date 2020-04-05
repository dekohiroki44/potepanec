class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :request_path
  def request_path
    @path = "#{controller_path}##{action_name}"
    def @path.is(*str)
      str.map { |s| include?(s) }.include?(true)
    end
  end
end
