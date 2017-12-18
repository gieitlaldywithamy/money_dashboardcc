require 'pry-byebug'
require 'sinatra'
require 'sinatra/contrib/all'

require_relative('merchant_controller.rb')
require_relative('tag_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

get('/tags') do
  @tags = Tag.all()
  erb(:'tags/index')
end

post('/tags') do
  merchant = Tag.new(params)
  merchant.save()
  redirect to ('/tags')
end

get('/tags/new') do
  @tags = Tag.all()
  erb(:'tags/new')
end
