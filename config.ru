require_relative './config/environment'

require './config/environment'

# to use delete, patch, post
use Rack::MethodOverride
use SessionsController
use UserController
run ApplicationController

# db:create_migration NAME=create_users