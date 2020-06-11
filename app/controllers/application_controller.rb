require 'net/http'
require 'uri'
# puts valid_image?('https://www.google.com/search?q4568M')
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "mexican_grill_user"
    end
    get '/test' do
        @url = params[:url]
        erb :'/test'
    end

    get '/:url' do
        @url = params[:url]
        erb :'/users/unavailable'
    end

    get '/' do
        if  session[:email] && session[:email].empty?
            redirect "/login"
        else
            @user = User.find_by(:email => session[:email]) 

            users_length = User.all.length 

            @users = []
            # puts "length of user base #{users_length}"
            i = 0
            while @users.length < 5
                random_user = User.all[rand(0..users_length-1)]
                if !@user.following.include?(random_user) && !@users.include?(random_user) && random_user != @user
                    @users << random_user
                end
                i += 1
                if i == 10
                    break
                end
            end
            #  @users.map do |user|
            #     puts user.id
            #     puts user
            #  end
            erb :"home/homepage"
        end
    end

    helpers do 
        def logged_in?
            !!session[:email]
        end

        def login(email,password)
            user = User.find_by(:email => email) 
            if user && user.authenticate(password)
              session[:email] = email
              redirect to '/'
            else
                puts"test"
                redirect'/login'
            end
        end

        def logout!
            session.clear
        end

        def working_url?(url)
            uri = URI.parse(url)
            uri.is_a?(URI::HTTP) && !uri.host.nil?
            rescue URI::InvalidURIError 
            false
        end
        
        def valid_image?(image_url)
            if working_url?(image_url)
                uri = URI.parse(URI.encode(image_url))
                res = Net::HTTP.get_response(uri)
                puts res.code
                return true
            else
                return false
            end
        end
        
    end
end