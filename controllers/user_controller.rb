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

get('/:id/users/edit') do
  @user = User.find(params[:id])
  @account_id = @user.id
  @name = @user.name
  erb(:'users/edit')
end

get('/:id/users/show') do
  @user = User.find(params[:id])
  @account_id = @user.id
  @name = @user.name
  erb(:'users/show')
end



post('/users') do
   p params
    @user = User.new(params)
    p "id", params['id']
    @user.save()
    redirect to "/users"
end

post('/users/:id') do

    @user = User.new(params)
    p "id", params['id']
    @user.save()
    redirect to "/users"
end

post ('/:id/users/delete') do
  @user = User.find(params[:id].to_i)
  @user.delete
  redirect to "/users"
end
