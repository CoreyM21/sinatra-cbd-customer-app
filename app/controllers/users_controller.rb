class UsersController < ApplicationController

    # what routes do I need for login?

    # the purpose of this route is to render the login page (form)
    get '/login' do
        erb :login
    end

    # the purpose of this route is to receive the login form,
    # find the user, and log the user in (create a session)
    post '/login' do 
        # params looks like: (email: user@user.com, password: "password")
        #find the user
        @user = User.find_by(email: params[:email]) #dont forget your key!!
        # authenticate the user
        ## they have credentials - email/password combo
        if @user.authenticate(params[:password])
        # log the user in - create the user session
        session[:user_id] = @user.id #actually logging user in
        # redirect to the users show page 
        puts session 
        redirect "users/#{@user.id}"
        else 
        # tell the user they entered invalid  credential
        # redirect to login page
        end
    end

    #what routes do I need for signup?
    get '/signup' do 

    end

    # user SHOW route 
    get '/users/:id' do 
        "This will be the user show route"
    end


end