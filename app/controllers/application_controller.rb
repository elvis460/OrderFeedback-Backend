class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request


  private
  def authenticate_request
    render json: {msg: 'Not Authorized'}, status: 401 unless request.headers['Auth-Token']
  end
end
