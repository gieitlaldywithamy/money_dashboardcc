require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
require_relative('../models/user.rb')
require_relative('../models/date_formatter.rb')

post('/:id/transactions/month_total') do
  @month = params['month'].to_i
  @account_id = params['id'].to_i
  @user = User.find(@account_id)
  @monthly_spend = Transaction.sum_by_month_for_user(@month, @account_id)
  @monthly_transactions = Transaction.transaction_by_month(@month)
  @transactions = @user.transactions()
  @show_month = true
  @name = @user.name
  @tags = Tag.all()
  erb(:'transactions/user_index')

end

get('/:account_id/transactions/tag/:tag_id') do
  @account_id = params['account_id'].to_i
  @user = User.find(@account_id)
  @tag_id = params['tag_id'].to_i
  @tag = Tag.find(@tag_id)
  @monthly_spend = Transaction.sum_by_month_for_user(@month, @account_id)
  @monthly_transactions = Transaction.transaction_by_month(@month)
  @transactions = @user.transactions()
  @show_month = true
  @name = @user.name
  erb(:'transactions/user_index')
end


get ('/transactions') do
  @transactions = Transaction.all()
  erb(:'transactions/index')
end

get('/:id/transactions/filter_tag') do

  @account_id = params[:id].to_i
  @user = User.find(params[:id].to_i)
  @transactions = Transaction.user_all_tag_sort(@account_id)
  @name = User.find(params[:id].to_i).name
  @monthly_spend = Transaction.sum_by_month_for_user(Date.today.month, @account_id)
  # @tag = Tag.all()[1]
  erb(:'transactions/user_index')
end

get('/:id/transactions') do
   # @user = User.find(id)
  @transactions = Transaction.user_all(params[:id].to_i)
  @account_id = params[:id].to_i
  @user = User.find(params[:id].to_i)
  p params, "getting user trans"
  @name = User.find(params[:id].to_i).name
  @monthly_spend = Transaction.sum_by_month_for_user(Date.today.month, @account_id)

  # @tag = Tag.all()[1]
  erb(:'transactions/user_index')
end

post('/:id/transactions') do
  params['account_id'] = params.delete(:id)
  @transaction = Transaction.new(params)
  @transaction.save()
  @account_id = params['account_id']

  redirect to "/#{@transaction.account_id}/transactions"
end



get('/:id/transactions/new') do
  @merchants = Merchant.all()
  @tags = Tag.all()
  @account_id = params[:id].to_i
  @user = User.find(@account_id)
  @name = User.find(@account_id).name
  erb(:'transactions/new')
end

get('/:account_id/transactions/:transaction_id') do
  @transaction = Transaction.find_by_id(params['account_id'].to_i, params['transaction_id'].to_i)
  @account_id = params['account_id'].to_i
  erb(:'transactions/show')
end


get('/:account_id/transactions/:transaction_id/edit') do
  @transaction = Transaction.find_by_id(params['account_id'].to_i, params['transaction_id'].to_i)
  @account_id = params['account_id'].to_i
  @merchant = @transaction.merchant
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:'transactions/edit')
end



post ('/:account_id/transactions/:transaction_id') do # update

  params['id'] = params.delete(:transaction_id)
  @transaction = Transaction.new(params)
  @params[:id]
  @transaction.save
  p "redirected"
  redirect to "/#{@transaction.account_id}/transactions"
end

post('/:account_id/transactions/:transaction_id/delete') do
  @transaction = Transaction.find_by_id(params['account_id'].to_i, params['transaction_id'].to_i)
  p@transaction
  @transaction.delete()
  redirect to "/#{@transaction.account_id}/transactions"
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
#   @tags = Tag.all()
#   erb(:'transactions/edit')
# end
