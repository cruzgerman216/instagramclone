class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "mexican_grill_user"
    end

    get '/' do
        if session[:email].empty?
            redirect "/login"
        else
            erb :"home/homepage"
        end
    end


    helpers do 
        def logged_in?
            !!session[:email]
        end

        def login(email,password)
            user = User.find_by(:email => email) 
            puts user
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


    end
    
end