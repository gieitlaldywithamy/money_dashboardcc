require 'pry-byebug' if development?
require 'sinatra'
require('sinatra/contrib/all') if development?

require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/merchant.rb')
require_relative('../models/user.rb')

# get('/users') do
#   @users = User.all()
#   @error = env['sinatra.error']
#   erb(:'users/index')
# end
#
# get('/registrations/signup') do
#   erb(:'users/new')
# end

get('/:id/users/edit') do

    @user = User.find(params[:id])
    @account_id = @user.id
    @name = @user.name
    erb(:'users/edit')

end

get('/users/show') do
  @user = User.find(session[:id])
  @account_id = @user.id
  @name = @user.name
  erb(:'users/show')
end

post('/registrations') do
  @user = User.new(params)
  @user.save()
  session[:id] = @user.id
  redirect to "/users"
end

get('/dashboard') do

  p session[:id]
  @user = User.find(session[:id])
  p @user
  @account_id = session[:id]
  @transactions = @user.transactions
  p params, "getting user trans"
  @name = @user.name
  @monthly_spend = Transaction.sum_by_month_for_user(Date.today.month, @account_id)

  # @Category = Category.all()[1]
  erb(:'users/dashboard')

end

post('/sessions') do
  @user = User.login_find(params["name"], params["password"])
  p @user
  session[:id] = @user.id
  #{@transaction.account_id}
  p session[:id]
  redirect to "/dashboard"

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
  @user = User.find(session[:id])
  @user.delete
  session.clear
  redirect to "/"
end
