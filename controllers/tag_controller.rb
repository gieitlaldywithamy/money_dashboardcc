require 'pry-byebug'
require 'sinatra'
require require('sinatra/contrib/all') if development?

require_relative('merchant_controller.rb')
require_relative('Category_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/Category.rb')
require_relative('../models/merchant.rb')

get('/Categorys') do
  @Categorys = Category.all()
  erb(:'Categorys/index')
end

post('/Categorys') do
  merchant = Category.new(params)
  merchant.save()
  redirect to ('/Categorys')
end

get('/Categorys/new') do
  @Categorys = Category.all()
  erb(:'Categorys/new')
end

get('/Categorys/show_totals') do
  @Categorys = Category.all()
  erb(:'Categorys/show_totals')
end
