class UserController < ApplicationController
    get '/direct/inbox' do
  
    end

    get '/user/:username' do
        @user = User.find_by(:username => params[:username]) 
        @you = User.find_by(:email => session[:email])

        if @user 
            erb :'/users/profile'
        else
            @url = params[:url]
            erb :'/users/unavailable'
        end
    end

    get '/user/:username/followers' do
        @user = User.find_by(:username => params[:username]) 
        puts params
        puts @user.followers[0].username
        if @user 
            erb :'/users/followers'
        else
            @url = params[:url]
            erb :'/users/unavailable'
        end
    end

    get '/user/:username/following' do
        @user = User.find_by(:username => params[:username]) 
        puts params
        if @user 
            erb :'/users/following'
        else
            @url = params[:url]
            erb :'/users/unavailable'
        end
    end

    #FRIENDING
    post '/user/:username' do
        @user1 = User.find_by(:email => session[:email])
          if session[:email] && session[:email].empty?
            redirect to '/login'
        end
        puts params
        if params[:follow]
            @user2 = User.find(params[:follow])
            @user1.following << @user2
            redirect to '/user/'+params[:username]
        elsif params[:unfollow]
            @user2 = User.find(params[:unfollow])
            @user1.following.delete(@user2)
            redirect to '/user/'+params[:username]
        end
    end
end