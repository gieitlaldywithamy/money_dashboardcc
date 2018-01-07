require 'pry-byebug' if development?
require 'sinatra'
# require('sinatra/contrib/all') if development?

require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/user.rb')
require_relative('../models/date_formatter.rb')

post('/transactions/month_total') do
  @month = params['month'].to_i
  @account_id = session[:id]
  @user = User.find(@account_id)
  @monthly_spend = Transaction.sum_by_month_for_user(@month, @account_id)
  @monthly_transactions = Transaction.transaction_by_month(@month, @account_id)
  @transactions = @user.transactions()
  @show_month = true
  @name = @user.name
  @categories = Category.all()
  erb(:'users/dashboard')

end

# get('/:account_id/transactions/category/:category_id') do
#   @account_id = params['account_id'].to_i
#   @user = User.find(@account_id)
#   @category_id = params['category_id'].to_i
#   @category = Category.find(@category_id)
#   @monthly_spend = Transaction.sum_by_month_for_user(@month, @account_id)
#   @monthly_transactions = Transaction.transaction_by_month(@month)
#   @transactions = @user.transactions()
#   @show_month = true
#   @name = @user.name
#   erb(:'transactions/user_index')
# end


get ('/transactions') do
  @user = User.find(session[:id])
  @transactions = @user.transactions
  erb(:'transactions/index')
end
#
# get('/:id/transactions/filter_category') do
#
#   @account_id = params[:id].to_i
#   @user = User.find(params[:id].to_i)
#   @transactions = Transaction.user_all_Category_sort(@account_id)
#   @name = User.find(params[:id].to_i).name
#   @monthly_spend = Transaction.sum_by_month_for_user(Date.today.month, @account_id)
#   # @Category = Category.all()[1]
#   erb(:'transactions/user_index')
# end

get('/:id/transactions') do
  p session[:id]
  @user = User.find(session[:id])
  p @user
  @account_id = session[:id]
  @transactions = @user.transactions
  p params, "getting user trans"
  @name = @user.name
  @monthly_spend = Transaction.sum_by_month_for_user(Date.today.month, @account_id)

  # @Category = Category.all()[1]
  redirect to "/dashboard"
end

post('/:id/transactions') do
  params['account_id'] = params.delete(:id)
  @transaction = Transaction.new(params)
  @transaction.save()
  @account_id = params['account_id']

  redirect to "/transactions"
end



get('/transactions/new') do
  @categories = Category.all()
  @account_id = session[:id]
  @user = User.find(@account_id)
  @name = User.find(@account_id).name
  erb(:'transactions/new')
end

get('/transactions/:transaction_id') do
  p params
  @transaction = Transaction.find_by_id(session[:id], params['transaction_id'].to_i)
  p @transaction
  @account_id = session[:id]
  erb(:'transactions/show')
end


get('/transactions/:transaction_id/edit') do
  @transaction = Transaction.find_by_id(session[:id], params['transaction_id'].to_i)
  @account_id = session[:id]
  @categories = Category.all
  erb(:'transactions/edit')
end



post ('/transactions/:transaction_id') do # update

  params['id'] = params.delete(:transaction_id)
  @transaction = Transaction.new(params)
  @params[:id]
  @transaction.save
  p "redirected"
  redirect to "/transactions"
end

post('/transactions/:transaction_id/delete') do
  @transaction = Transaction.find_by_id(session[:id], params['transaction_id'].to_i)
  p@transaction
  @transaction.delete()
  redirect to "/transactions"
end

# post ('/transactions/:id') do
#   # transaction = Transaction.find_by_id(params['id'].to_i)
#   transaction = Transaction.new(params)
#   binding.pry
#   transaction.edit()
#   redirect to("/transactions")
# end

# get('/transactions/:id/edit') do
#   @transaction = Transaction.find_by_id(params['id'])
#   @merchants = Merchant.all()
#   @Categorys = Category.all()
#   erb(:'transactions/edit')
# end
