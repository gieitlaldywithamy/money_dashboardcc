require('./db/sql_runner')
require('pry-byebug')
require_relative('./merchant.rb')
require_relative('./Category.rb')

class Data

  attr_reader :id, :name, :value, :transaction_date, :merchant_name, :Category_name, :account_name
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @value = options['value']
    @transaction_date = options['transaction_date']
    @merchant_name = options['merchant_name'].to_i()
    @Category_name = options['Category_name'].to_i()
    @account_name = options['account_name']
  end

end
