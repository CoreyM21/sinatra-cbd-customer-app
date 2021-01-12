class CustomerEntriesController < ApplicationController

    get '/customer_entries' do
        @customer_entries = CustomerEntry.all
        erb :'customer_entries/index'
    end

    # get customer_entries/new to render a form to create new entry
    get '/customer_entries/new' do 
        erb :'/customer_entries/new'
    end

    # post customer_entres to create new customer entry
    post '/customer_entries' do 
        # I want to create a new customer entrye and save to the DB
        # I only want to create an entry if the user is logged in
        if !logged_in?
            redirect '/'
        end 
        # I only want to save the entry if it has some content
        if params[:content] != ""
            # create a new entry
            flash[:message] = "Customer Created!"
            @customer_entry = CustomerEntry.create(content: params[:content], user_id: current_user.id, title: params[:title], phone: params[:phone])
            # @customer_entry = CustomerEntry.create(params)
            redirect "/customer_entries/#{@customer_entry.id}"
        else
            flash[:errors] = "Something went wrong. Cannot be blank"
            redirect '/customer_entries/new'
        end
    end

    # show route for a customer entry
    get '/customer_entries/:id' do 
        set_customer_entry
        erb :'/customer_entries/show'
    end


    #major problems!!
    # 1. Anyone can edit anyones customer entires
    # 2. also, edit an entry to be blank

    # This route should send us to /customer_entries/edit.erb 
    # render an edit form

    get '/customer_entries/:id/edit' do
        set_customer_entry
        if logged_in?
            if authorized_to_edit?(@customer_entry)
                erb :'/customer_entries/edit'
            else
                redirect "users/#{current_user.id}"
            end
        else 
            redirect '/'    
        end
    end


    # This action's job is to 
    patch '/customer_entries/:id' do
        # 1. find cutomer entry
        set_customer_entry
        if logged_in?
            if authorized_to_edit?(@customer_entry) && params[:content] != ""
                # 2. Modify (update) the entry
                @customer_entry.update(content: params[:content], title: params[:title], phone: params[:phone])  
                flash[:message] = "Customer Updated!"           
                # 3. redirect to show page
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

    # index route for all customer entries

    private 

    def set_customer_entry
        @customer_entry = CustomerEntry.find(params[:id])
    end
end