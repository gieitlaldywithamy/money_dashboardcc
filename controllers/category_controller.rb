require 'pry-byebug' if development?
require 'sinatra'
require('sinatra/contrib/all') if development?

require_relative('merchant_controller.rb')
require_relative('category_controller.rb')

require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/merchant.rb')

get('/categories') do
  @categories = Category.all()
  erb(:'categories/index')
end

post('/categories') do
  category = Category.new(params)
  category.save()
  redirect to ('/categories')
end

get('/categories/new') do
  @categories = Category.all()
  erb(:'categories/new')
end

get('/categories/show_totals') do
  @luxury_categories = Category.luxury_categories()
  @essential_categories = Category.essential_categories()
  erb(:'categories/show_totals')
end
