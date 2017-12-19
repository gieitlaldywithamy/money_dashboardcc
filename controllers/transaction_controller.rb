require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

get('/:id/transactions') do
   # @user = User.find(id)
  @transactions = Transaction.all(params[:id].to_i)

  p params,
  @name = User.find(params[:id].to_i).name
  # @tag = Tag.all()[1]
  erb(:'transactions/index')
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
  @transaction = Transaction.new(params)
  p params[:id]
  p @transaction
  @transaction.save
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
