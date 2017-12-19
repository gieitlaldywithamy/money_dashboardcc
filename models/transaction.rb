require('./db/sql_runner')
require('pry-byebug')
require_relative('./merchant.rb')
require_relative('./tag.rb')

class Transaction

  attr_reader :id, :name, :value, :transaction_date, :merchant_id, :tag_id, :account_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @value = options['value']
    @transaction_date = options['transaction_date']
    @merchant_id = options['merchant_id'].to_i()
    @tag_id = options['tag_id'].to_i()
    @account_id = options['account_id']
  end

  def save
    if @id
      edit()
    else
      insert()
    end
  end

  def insert()
    sql = "INSERT INTO transactions (name, value, merchant_id, tag_id, account_id) VALUES ($1, $2, $3, $4, $5) RETURNING id;"
    values = [@name, @value,@merchant_id, @tag_id, @account_id]
    # auto generating date make optional? how?
    transaction = SqlRunner.run(sql, values)
    @id = transaction[0]['id'].to_i()
  end

  def edit()
    sql = "UPDATE transactions SET (name, value, transaction_date, merchant_id, tag_id, account_id) = ($1, $2, $3, $4, $5, $6) WHERE id = $7;"
    values = [@name, @value, @transaction_date, @merchant_id, @tag_id, @account_id, @id]
    SqlRunner.run(sql, values)
  end

  def merchant()
    merchant = Merchant.find(@merchant_id)
  end

  def tag()
    tag = Tag.find(@tag_id)
  end

  def account()
    account = AccountSettings.find(@account_id)
  end

  def Transaction.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions;"
    return SqlRunner.run_sql_and_map(sql, Transaction)
  end

  def Transaction.find_by_id(id)
    sql = "SELECT * FROM transactions WHERE id=$1;"
    values = [id]
    return SqlRunner.run_sql_and_map(sql, Transaction, values)[0]
  end

  def Transaction.total_spent()
    sql = "SELECT SUM(value) FROM transactions;"
    total_spent = SqlRunner.run(sql)[0].values().first()
    return total_spent
  end

  def Transaction.total_spent_by_tag(tag)
    sql = "SELECT SUM(value) FROM transactions WHERE tag_id = $1"
    values = [tag.id]

    total_spent = SqlRunner.run(sql, values)[0]['sum']
    if total_spent
      return total_spent
    else
      return "0"
    end
  end




end
