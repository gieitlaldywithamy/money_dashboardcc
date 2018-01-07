require 'pry-byebug' if development?
require 'sinatra'
# require('sinatra/contrib/all') if development?

require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/user.rb')


get('/users/edit') do
  @user = User.find(session[:id])
  erb(:'users/edit')
end

get('/users/show') do
  @user = User.find(session[:id])
  erb(:'users/show')
end

post('/registrations') do
  @user = User.new(params)
  @user.save()
  session[:id] = @user.id
  redirect to "/users"
end

get('/dashboard') do
  @user = User.find(session[:id])
  @transactions = @user.transactions()
  erb(:'users/dashboard')
end

post('/sessions') do
  @user = User.login(params["name"], params["password"])
  if @user
    session[:id] = @user.id
    redirect to "/dashboard"
  else
    params['error'] = "No user found"
    erb(:index)
  end
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
      session[:id] = @user.id
      p "saved new user"
      redirect to "/users"
    end


end

post ('/users/delete') do
  @user = User.find(session[:id])
  @user.delete
  session.clear
  redirect to "/"
end

post('/users/:id') do
  if params["name"].nil? || params["annual_income"].nil? || params["password"].nil?
    params['error'] = "Some fields were empty!"
    @user = User.find(session[:id])
    erb(:'users/edit')
  else
    @user = User.new(params)
    @user.id = session[:id]
    @params[:id]
    p "saving", @user
    @user.save()
    redirect to "/users/show"
  end
end
