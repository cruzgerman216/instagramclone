require_relative './config/environment'

require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#     raise 'Migrations are pending, run rake db:migrate to resolve issues.'
# end

use Rack::MethodOverride
use SessionsController
use UserController
run ApplicationController

# db:create_migration NAME=create_users