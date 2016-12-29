class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!

  protected
  
    #def authenticate
    #  authenticate_or_request_with_http_basic do |username, password|
    #    cube = Cube.where(name: username, password: password).first
    #    if cube
    #      session[:cube_id] = cube.id
    #      true
    #    else        
    #      false
    #    end
    #  end
    #end
end
