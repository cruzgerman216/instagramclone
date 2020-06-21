class SessionsController < ApplicationController
    get '/login' do
        if session[:email] && !session[:email].empty?
            redirect to "/"
        end
        erb :"sessions/login"
    end

    get '/logout' do
        session[:email].clear
        redirect to "/login"
    end

    get '/signup' do
        if session[:email] && !session[:email].empty?
            redirect to "/"
        end
        erb :"sessions/signup"
    end

 # TO DO
 # CAN'T HAVE DUPLICATE usernames 
 # if duplicate username return @error to page
    post '/signup' do 
        @user = User.new
        @duplicate_email= User.all.find_by(:email=>params[:email])
        @duplicate_username= User.all.find_by(:username=>params[:username])

        if @duplicate_email 
            @error = "email"
            erb :"sessions/signup"
        elsif @duplicate_username
            @error = "Username"
            erb :"sessions/signup"
        else
            @user.email = params[:email]
            @user.username = params[:username]
            @user.password = params[:password]
            @user.firstname = params[:firstname]
            @user.lastname = params[:lastname]
            @user.profile_img = "https://pecb.com/conferences/wp-content/uploads/2017/10/no-profile-picture.jpg"
            if @user.save 
                redirect '/login'
            else
                erb :"sessions/signup"
            end
        end
   
    end

    post '/sessions' do
        login(params[:email], params[:password])
    end
    
end