require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_app"
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user # !! converts to a boolean
    end

    def current_user
      @current_udser = User.find_by(id: session[:user_id])
    end

end
