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


    post '/user/profile_img' do
        @user = User.find_by(:email => session[:email])
        puts params[:url]

        if valid_image?(params[:url])
            @user.profile_img = params[:url]
            @user.save
            redirect to '/user/' + @user.username
        else

            redirect to '/'
        end
    end


    get '/user/:username/followers' do
        @user = User.find_by(:username => params[:username]) 
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

    get '/post/:id' do
        @you = User.find_by(:email => session[:email])
        @post = Post.find_by(:id => params[:id])
        @user = @post.user
        if @post 
            erb :'/users/post'
        else
            erb :'/users/unavailable'
        end
    end

    #account 
    get '/accounts/edit' do
        @you = User.find_by(:email => session[:email])
        erb :'/users/account/edit'    
    end

    get '/accounts/password/change/' do
        @you = User.find_by(:email => session[:email])
        erb :'/users/account/passwordchange'    
    end

    post '/accounts/password/change' do 
        @you = User.find_by(:email=>session[:email])
        if @you.authenticate(params[:oldpassword])
            if params[:newpassword] == params[:confirmpassword]
                @you.password = params[:newpassword]
                @you.save
                erb :'/users/account/passwordchange'
            else
                @error = "New password does not match with confirm password"
                erb :'/users/account/passwordchange'
            end
        else
            @error = "Wrong password."
            erb :'/users/account/passwordchange'
        end
    end
    post '/accounts/edit' do 
        @duplicate_email= User.find_by(:email=>params[:email])
        @duplicate_username= User.find_by(:username=>params[:username])
        id = params[:user]
        @you = User.find(id)
        puts params
        if @duplicate_email && @duplicate_email.email != @you.email
            @error = "Email is already taken."
            erb :'/users/account/edit'  
        elsif @duplicate_username && @duplicate_username.username != @you.username
            @error = "Username is already taken."
            erb :'/users/account/edit'  
        else
            @you.email = params[:email]
            @you.username = params[:username]
            @you.firstname = params[:firstname]
            @you.lastname = params[:lastname]
            @you.bio = params[:bio]

            @you.save 
            erb :'/users/account/edit'  
        end

    end

    post '/post/:id' do
        @you = User.find_by(:email => session[:email])
        @post = Post.find_by(:id => params[:id])
        @user = @post.user
        c = Comment.new 
        c.comment = params[:comment]
        c.post = @post 
        c.user = @you 
        @you.save 
        @post.save 
        c.save
        puts c
        if @post 
            erb :'/users/post'
        else
            erb :'/users/unavailable'
        end
    end

    post '/comment/delete' do
        @you = User.find_by(:email => session[:email])
        @post = Post.find(params[:postid])
        @user = @post.user
        c = Comment.find(params[:commentid])
        c.destroy
        erb :'/users/post'
    end
    get '/logout' do
        params[:email].clear
        redirect to '/login'
    end
    #FRIENDING
    post '/user/:username' do
        puts params
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