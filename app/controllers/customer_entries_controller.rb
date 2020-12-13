class CustomerEntriesController < ApplicationController

    # get customer_entries/new to render a form to create new entry
    get '/customer_entries/new' do 
        erb :'/customer_entries/new'
    end

    # post customer_entres to create new customer entry
    post '/customer_entries' do 

    end

    # show route for a journal entry

    # index route for all customer entries

end