require('./db/sql_runner')

class User

  attr_reader :name, :password, :annual_income, :monthly_budget_limit
  attr_accessor :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @annual_income = options['annual_income'].to_f
    @password = options['password']
    @monthly_budget_limit = set_budget()
  end

  def save()
    if @id
      update()
    else
      insert()
    end
  end

  def insert()
    sql = "INSERT INTO users (name, annual_income, password) VALUES ($1, $2, $3) RETURNING id;"
    values = [@name, @annual_income, @password]
    user = SqlRunner.run(sql, values)
    @id = user[0]['id'].to_i
  end

  def update()
    sql = "UPDATE users SET (name, annual_income, password) = ($1, $2, $3) WHERE id=$4;"
    values = [@name, @annual_income, @password, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE account_id = $1;"
    transactions = SqlRunner.run_sql_and_map(sql, Transaction, [@id])
    return transactions
  end

  def has_used_account()
    return transactions().count() > 0
    #  return Transaction.user_all(@id).count() > 0
    # return Transaction.user_all(@id).count() > 0
  end

  def category_sums_for_month(category_id, month)
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2 AND category_id = $3 order by sum desc;"
    total_spent = SqlRunner.run(sql, [month, @id, category_id])[0]['sum']
    return total_spent || 0
  end

  def change_income(new_income)
    @annual_income = new_income
  end

  def budget_percent()
    return (spent_on_current_month().to_f/@monthly_budget_limit)*100
  end

  def budget_left()
    if over_budget()
      return 0
    else
      return @monthly_budget_limit - spent_on_current_month().to_f
    end
  end

  def over_budget()
     return spent_on_current_month().to_f > @monthly_budget_limit
  end

  def spent_on_month(month)
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND EXTRACT(YEAR FROM transactions.transaction_date) = $2 AND account_id = $3"
    values = [month, Date.today.year, @id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent || 0
  end

  def spent_on_current_month()
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND EXTRACT(YEAR FROM transactions.transaction_date) = $2 AND account_id = $3"
    values = [Date.today.month, Date.today.year, @id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent || 0
  end

  def User.find(id)
    sql = "SELECT * FROM users WHERE id = $1"
    return SqlRunner.run_sql_and_map(sql, User, [id])[0]
  end

  def User.all()
    sql = "SELECT * FROM users;"
    return SqlRunner.run_sql_and_map(sql, User)
  end

  def User.delete_all()
    sql = "DELETE FROM users;"
    SqlRunner.run(sql)
  end

  def User.login(username, password)
    sql = "SELECT * FROM users WHERE name=$1 AND password = $2;"
    user = SqlRunner.run_sql_and_map(sql, User, [username, password])
    return user[0]
  end

  def all_transactions()
    sql = "SELECT * FROM transactions WHERE account_id = $1;"
    transactions = SqlRunner.run_sql_and_map(sql, Transaction, [id])
    return transactions
  end

  private
  def set_budget()
    return @annual_income/12
  end
end
