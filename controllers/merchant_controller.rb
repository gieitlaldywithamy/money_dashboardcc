require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
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
  erb(:'merchants/new')
end
