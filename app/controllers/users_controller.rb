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
        if @user && @user.authenticate(params[:password])
        # log the user in - create the user session
        session[:user_id] = @user.id #actually logging user in
        # redirect to the users show page 
        puts session 
        redirect "users/#{@user.id}"
        else 
        flash[:message] = "Your credentials did not work. Please sign up or try again!"
        # tell the user they entered invalid  credential
        # redirect to login page
        redirect '/login'
        end
    end

    #what routes do I need for signup?
    # this routes's job is to render the signup form
    get '/signup' do 
        # erb (render) a view 
        erb :signup 
    end

    post '/users' do
        # here is where we will create a new user and persisit the new user to the DB
        # params will look like this: 
        # {
        #     "name"=>"Corey", 
        #     "email"=>"corey@corey.com", 
        #     "password"=>"password"
        # }
        # Io nly want to persist a user that has a name email, AND password
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            # valid input
            @user = User.create(params)
            session[:user_id] = @user.id #actually logging user in
            # where do I go now?
            # go to user show page
            redirect "/users/#{@user.id}"
        else 
            # not valid input
            # it would be better to include a message to the user telling them what is wrong
            redirect '/signup'
        end 

    end

    # user SHOW route 
    get '/users/:id' do 
        # what do I need to do first?
        @user = User.find_by(id: params[:id])
        session[:user_id] = @user.id #actually logging user in
        erb :'/users/show'
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

end