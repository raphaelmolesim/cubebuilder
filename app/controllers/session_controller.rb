class SessionController < ApplicationController
  def logout
    # to make it work is need to review the authentication solution
    # this seems a nice way to do it https://gist.github.com/thebucknerlife/10090014
    cookies.delete :_cubebuilder_session
    session[:cube_id] = nil
    reset_session
    redirect_to '/'   
  end
end
