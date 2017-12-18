require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

get('/transactions') do
  @transactions = Transaction.all()
  @tag = Tag.all()[1]
  erb(:'transactions/index')
end

post('/transactions') do
  transaction = Transaction.new(params)
  transaction.save()
  redirect to ('/transactions')
end

get('/transactions/new') do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:'transactions/new')
end

get('/transactions/:id/edit') do
  @transaction = Transaction.find_by_id(params['id'].to_i)
  erb(:'transactions/edit')
end
