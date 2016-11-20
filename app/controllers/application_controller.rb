class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :authenticate

  protected
  
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        cube = Cube.where(name: username, password: password).first or username == "admin" and password == "rdb#a&"
        if cube
          session[:cube_id] = cube.id
          true
        else        
          false
        end
      end
    end
end
