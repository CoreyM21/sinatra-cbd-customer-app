class CustomerEntriesController < ApplicationController

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
            @customer_entry = CustomerEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/customer_entries/#{@customer_entry.id}"
        else
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
            if @customer_entry.user == current_user
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
            if @customer_entry.user == current_user
                # 2. Modify (update) the entry
                @customer_entry.update(content: params[:content])
                # 3. redirect to show page
                redirect "/customer_entries/#{@customer_entry.id}"
            else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end

    # index route for all customer entries

    private 

    def set_customer_entry
        @customer_entry = CustomerEntry.find(params[:id])
    end
end