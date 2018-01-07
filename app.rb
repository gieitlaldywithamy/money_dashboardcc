require 'sinatra'
# require('sinatra/contrib/all') if development?
enable :sessions

require_relative('./controllers/transaction_controller.rb')
require_relative('./controllers/category_controller.rb')
require_relative('./controllers/user_controller.rb')

require_relative('./models/transaction.rb')
require_relative('./models/category.rb')
require_relative('./models/user.rb')

get '/' do
  erb(:index)
end

get '/sessions/logout' do
  session.clear
  redirect to '/'
end

get '/registrations/signup' do
    erb (:'/users/new')
end
