require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_app"
  end

  get "/" do
    if logged_in?
      redirect "users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user # !! converts to a boolean
    end

    def current_user
      @current_udser ||= User.find_by(id: session[:user_id])
      session[user:user_id]
    end
  end

end