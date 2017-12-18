require('./db/sql_runner')
require('pry-byebug')
require_relative('./merchant.rb')
require_relative('./tag.rb')

class Transaction

  attr_reader :name, :value, :transaction_date, :merchant_id, :tag_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @value = options['value']
    @transaction_date = options['transaction_date']
    @merchant_id = options['merchant_id'].to_i()
    @tag_id = options['tag_id'].to_i()
  end

  def save()
    sql = "INSERT INTO transactions (name, value, merchant_id, tag_id) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@name, @value,@merchant_id, @tag_id]
    # auto generating date make optional? how?
    transaction = SqlRunner.run(sql, values)
    @id = transaction[0]['id'].to_i()
  end

  def edit()
    sql = "UPDATE transactions SET (name, value, merchant_id, tag_id) VALUES ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @value, @merchant_id, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def merchant()
    merchant = Merchant.find(@merchant_id)
  end

  def tag()
    tag = Tag.find(@tag_id)
  end



  def Transaction.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions;"
    return SqlRunner.run_sql_and_map(sql, Transaction)
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
