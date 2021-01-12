class UsersController < ApplicationController

    

    
    get '/login' do
        erb :login
    end

    
    post '/login' do 
       
        @user = User.find_by(email: params[:email]) 
        
        if @user && @user.authenticate(params[:password])
        
        session[:user_id] = @user.id 
        
        puts session 
        flash[:message] = "Welcome, #{@user.name}!"
        redirect "users/#{@user.id}"
        else 
        flash[:errors] = "Your credentials did not work. Please sign up or try again!"
        
        redirect '/login'
        end
    end

    
    get '/signup' do 
        
        erb :signup 
    end

    post '/users' do
        
        @user = User.new(params)
        if @user.save
            
            session[:user_id] = @user.id 
            
            flash[:message] = "You have successfully created an account, #{@user.name}!"
            redirect "/users/#{@user.id}"
        else 
            
            
            flash[:errors] = "Account Create Failure: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end 

    end

    
    get '/users/:id' do 
        
        @user = User.find_by(id: params[:id])
        session[:user_id] = @user.id 
        erb :'/users/show'
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

end