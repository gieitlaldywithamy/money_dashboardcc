require 'sinatra'
require('sinatra/contrib/all') if development?
enable :sessions

require_relative('./controllers/transaction_controller.rb')
require_relative('./controllers/category_controller.rb')
require_relative('./controllers/user_controller.rb')

require_relative('./models/transaction.rb')
require_relative('./models/category.rb')
require_relative('./models/merchant.rb')
require_relative('./models/user.rb')

get '/' do
  @users = User.all
  erb(:index)
end

get '/sessions/login' do
  erb(:'/users/registrations/login')
end

get '/sessions/logout' do
  session.clear
  redirect to '/'
end

get '/registrations/signup' do
    erb (:'/users/registrations/signup')
end
