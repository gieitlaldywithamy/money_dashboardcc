require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
require_relative('../models/user.rb')

get('/users') do
   # @user = User.find(id)
  @users = User.all()
  # @tag = Tag.all()[1]
  erb(:'users/index')
end

get('/users/new') do
  erb(:'users/new')
end

get('/users/show') do
  erb(:'users/show')
end

post('/users') do


    @user = User.new(params)
    @user.save()
    redirect to "/users"

end
