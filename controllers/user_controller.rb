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

get('/users/:id/show') do
  @user = User.find(params[:id])
  erb(:'users/show')
end

get('/users/:id/edit') do
  @user = User.find(params[:id])
  erb(:'users/edit')
end

post('/users') do
   p params
    @user = User.new(params)
    p "id", params['id']
    @user.save()
    redirect to "/users"

end
