require 'net/http'
require 'uri'
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "instagram"
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
    get '/' do
        if  session[:email] == nil || session[:email].empty?
            redirect "/login"
        else
            @you = User.find_by(:email => session[:email]) 

            #grabbing homepage posts
            @posts = []
            @posts += @you.posts
            @you.following.map do |user|
                @posts += user.posts
            end
            @posts = @posts.sort { |a,b| b.created_at <=> a.created_at}
            users_length = User.all.length 

            @users = []
            # puts "length of user base #{users_length}"
            i = 0
            while @users.length < 5
                random_user = User.all[rand(0..users_length-1)]
                if !@you.following.include?(random_user) && !@users.include?(random_user) && random_user != @you
                    @users << random_user
                end
                i += 1
                if i == 10
                    break
                end
            end
            erb :"home/homepage"
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
        @user = User.find_by(:email => session[:email]) 
        if valid_image?(params[:url])
            post = Post.new
            post.img_url = params[:url]
            post.description = params[:description]
            @user.posts << post 
            @user.save
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
        
    end
    
end