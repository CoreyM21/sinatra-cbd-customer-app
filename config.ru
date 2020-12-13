require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# in order to send PATCH and DELETE requests, I will need to add aline of code here..
use Rack::MethodOverride

# here is where I mount other controllers with "use"
use UsersController
use CustomerEntriesController

run ApplicationController


