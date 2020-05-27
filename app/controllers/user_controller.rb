class UserController < ApplicationController
    get '/direct/inbox' do
  
    end

    get '/username' do
        
    end

    post '/test' do
        puts params
        erb :'/users/profile'
    end
end