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
        @customer_entry = CustomerEntry.find(params[:id])
        erb :'/customer_entries/show'
    end

    # This route should send us to /customer_entries/edit.erb 
    # render an edit form

    get '/customer_entries/:id/edit' do
        erb :'/customer_entries/edit'
    end

    # index route for all customer entries

end