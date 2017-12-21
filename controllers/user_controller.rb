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
  @users = User.all()
  @error = env['sinatra.error']
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
    if params["name"].nil? || params["annual_income"].nil?
      params['error'] = "Try again! Need more information"
      redirect to '/users/new'
    else
      @user = User.new(params)
      p "created new user"
      @user.save()
      p "saved new user"
      redirect to "/users"
    end


end

post('/users/:id') do
  if params["name"].nil? || params["annual_income"].nil?
    params['error'] = "Some fields were empty!"
    @user = User.find(params[:id])
    @account_id = @user.id
    @name = @user.name
    erb(:'users/edit')
  else
    @user = User.new(params)
    @user.save()
    redirect to "/users"
  end
end

post ('/:id/users/delete') do
  @user = User.find(params[:id].to_i)
  @user.delete
  redirect to "/users"
end
