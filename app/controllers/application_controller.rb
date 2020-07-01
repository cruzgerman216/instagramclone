require 'net/http'
require 'uri'
# That reminds me, I don't have to include "redirect_if_not_logged_in" in every get response. The user can actually go to profile pages even when not logged in.
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "instagram"
    end
    
    get '/' do
        if  session[:email] == nil || session[:email].empty?
            redirect "/login"
        else
            @you = User.find_by(:email => session[:email]) 

            # homepage posts
            @posts = @you.homepage_posts
            
            # suggested friends 
            @users = @you.suggest_friends()
            erb :"home/homepage"
        end
    end

    get '/:url' do
        if  session[:email] == nil || session[:email].empty?
            @error = "Page unavailable, please login or signup."
            erb :"/sessions/login"
        else
            @you = User.find_by(:email => session[:email]) 
            erb :"users/unavailable"
        end
    end

    post '/' do
        @user = User.find_by(:email => session[:email]) 
        p = Post.find(params[:post])
        if Heart.all.select{|a| @user.hearts.include?(a) && p.hearts.include?(a)}.empty?
            h = Heart.new 
            h.user = @user 
            h.post = p
            p.save 
            @user.save 
            h.save 
        else
            Heart.find(params[:heart]).destroy
        end
            redirect to "/"
    end

    post '/post' do
            puts "inside"
        @user = User.find_by(:email => session[:email]) 
        if valid_image?(params[:img_url])
            puts "test"
            @user.posts.create(params)
        end
        redirect to '/'
    end

    helpers do 
        def login(email,password)
            user = User.find_by(:email => email) 
            if user && user.authenticate(password)
              session[:email] = email
              redirect to '/'
            else
                redirect'/login'
            end
        end

        def logout!
            session.clear
        end

        def working_url?(url)
            # parse makes a uri http object
            uri = URI.parse(url)
            # is a valid http object and if the object gives us a host 
            uri.is_a?(URI::HTTP) && !uri.host.nil?
            # if valid url return true, otherwise return false
            rescue URI::InvalidURIError 
            false
        end
        
        def valid_image?(image_url)
            if working_url?(image_url)
                uri = URI.parse(URI.encode(image_url))
                res = Net::HTTP.get_response(uri)
                if res.code == "200"
                    return true 

                else 
                    return false
                end
            else
                return false
            end
        end
        
        def suggest_friends()

        end
    end
    
end