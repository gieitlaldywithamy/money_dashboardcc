require('./db/sql_runner')
#require('pry-byebug')
require_relative('./category.rb')

class Transaction

  attr_reader :id, :name, :value, :transaction_date, :merchant, :category_id, :account_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @value = options['value']
    @transaction_date = options['transaction_date']
    @merchant = options['merchant']
    @category_id = options['category_id'].to_i()
    @account_id = options['account_id']
  end

  def save
    if @id
      update()
    else
      insert()
    end
  end

  def insert()
    sql = "INSERT INTO transactions (name, value, transaction_date, merchant, category_id, account_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;"
    values = [@name, @value, @transaction_date, @merchant, @category_id, @account_id]
    # auto generating date make optional? how?
    transaction = SqlRunner.run(sql, values)
    @id = transaction[0]['id'].to_i()
  end

  def update()
    sql = "UPDATE transactions SET (name, value, transaction_date, merchant, category_id, account_id) = ($1, $2, $3, $4, $5, $6) WHERE id = $7;"
    values = [@name, @value, @transaction_date, @merchant, @category_id, @account_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id=$1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def category()
    category = Category.find(@category_id)
  end

  def account()
    account = User.find(@account_id)
  end

  def account_name()
    return account().name
  end

  def Transaction.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run_sql_and_map(sql, Transaction)
    return transactions
  end

  def Transaction.user_all_category_sort(id)
    sql = "SELECT * FROM transactions WHERE account_id = $1 ORDER BY category_id;"
    transactions = SqlRunner.run_sql_and_map(sql, Transaction, [id])
    return transactions
  end

  def Transaction.transaction_by_month(month, user_id)
    sql = "SELECT * FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2"
    values = [month, user_id]
    return SqlRunner.run_sql_and_map(sql, Transaction, values)
  end

  def Transaction.sum_by_month_for_user(month, user_id)
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2"
    values = [month, user_id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent
  end


  # def Transaction.find_by_id(user_id, transaction_id)
  #   # change this to find another inner join, completely unnecessary
  #   sql = "SELECT *
  #   FROM transactions INNER JOIN users ON users.id = transactions.account_id
  #   WHERE transactions.id=$1 AND users.id = $2;"
  #   values = [user_id, transaction_id]
  #   return SqlRunner.run_sql_and_map(sql, Transaction, values)
  # end

  def Transaction.find_by_id(user_id, transaction_id)
    # change this to find another inner join, completely unnecessary
    sql = "SELECT *
    FROM transactions
    WHERE account_id=$1 AND id = $2;"
    values = [user_id, transaction_id]
    return SqlRunner.run_sql_and_map(sql, Transaction, values)[0]
  end


  def Transaction.total_spent()
    sql = "SELECT SUM(value) FROM transactions;"
    total_spent = SqlRunner.run(sql)[0].values().first()
    return total_spent
  end

  def Transaction.total_spent_user_category(user)
    sql = "select category_id, SUM(value) FROM transactions WHERE account_id = $1 GROUP BY category_id ORDER BY SUM(value) desc";
    values = [user.id]
    highest_category = SqlRunner.run(sql, values)
    # would like to change this

    if highest_category.values.length > 0
      return highest_category[0]['category_id']
    else
      return 0
    end
  end


end
