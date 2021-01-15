class CustomerEntriesController < ApplicationController

    get '/customer_entries' do
        @customer_entries = CustomerEntry.all
        erb :'customer_entries/index'
    end

    
    get '/customer_entries/new' do 
        erb :'/customer_entries/new'
    end

    
    post '/customer_entries' do 
        
        if !logged_in?
            redirect '/'
        end 
        
        if params[:content] != ""
            
            flash[:message] = "Customer Created!"
            @customer_entry = CustomerEntry.create(content: params[:content], user_id: current_user.id, title: params[:title], phone: params[:phone])
            
            redirect "/customer_entries/#{@customer_entry.id}"
        else
            flash[:errors] = "Something went wrong. Cannot be blank"
            redirect '/customer_entries/new'
        end
    end

    
    get '/customer_entries/:id' do 
        set_customer_entry
        erb :'/customer_entries/show'
    end

    

    get '/customer_entries/:id/edit' do
        set_customer_entry
        redirect_if_not_logged_in
        if authorized_to_edit?(@customer_entry)
            erb :'/customer_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end
    end


    
    patch '/customer_entries/:id' do
        
        set_customer_entry
        if logged_in?
            if authorized_to_edit?(@customer_entry) && params[:content] != ""
                
                @customer_entry.update(content: params[:content], title: params[:title], phone: params[:phone])  
                flash[:message] = "Customer Updated!"           
                
                redirect "/customer_entries/#{@customer_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    delete '/customer_entries/:id' do
        set_customer_entry
        if authorized_to_edit?(@customer_entry)
            @customer_entry.destroy
            flash[:message] = "Successfully Deleted Entry"
            redirect '/customer_entries'
        else
            redirect '/customer_entries'
        end
    end

    

    private 

    def set_customer_entry
        @customer_entry = CustomerEntry.find(params[:id])
    end
end