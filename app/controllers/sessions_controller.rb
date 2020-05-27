class SessionsController < ApplicationController
    get '/login' do
        if !session[:email].empty?
            redirect to "/"
        end
        erb :"sessions/login"
    end

    get '/logout' do
        session[:email].clear
        redirect to "/login"
    end

    get '/signup' do
        if !session[:email].empty?
            redirect to "/"
        end
        erb :"sessions/signup"
    end

    post '/signup' do 
        @user = User.new
        puts params
        @user.email = params[:email]
        @user.password = params[:password]
        if @user.save 
            redirect '/login'
        else
            erb :"sessions/signup"
        end
    end

    post '/sessions' do
        login(params[:email], params[:password])
    end
    
end