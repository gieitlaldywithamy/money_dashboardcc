require 'pry-byebug'
require 'sinatra'
require require('sinatra/contrib/all') if development?

require_relative('merchant_controller.rb')
require_relative('Category_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/Category.rb')
require_relative('../models/merchant.rb')

get('/merchants') do
  @merchants = Merchant.all()
  erb(:'merchants/index')
end

post('/merchants') do
  merchant = Merchant.new(params)
  merchant.save()
  redirect to ('/merchants')
end

get('/merchants/new') do
  @merchants = Merchant.all()
  erb(:'merchant/new')
end
