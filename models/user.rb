require('./db/sql_runner')

class User

  attr_reader :id, :name, :annual_income, :monthly_budget_limit

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @annual_income = options['annual_income'].to_f
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
    sql = "INSERT INTO users (name, annual_income) VALUES ($1, $2) RETURNING id;"
    values = [@name, @annual_income]
    user = SqlRunner.run(sql, values)
    @id = user[0]['id'].to_i
  end

  def update()
    sql = "UPDATE users SET (name, annual_income) = ($1, $2) WHERE id=$3;"
    values = [@name, @annual_income, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE account_id = $1;"
    transactions = SqlRunner.run_sql_and_map(sql, Transaction, [id])
    return transactions
  end
  def has_used_account()
    return Transaction.user_all(@id).count() > 0
  end



  def change_income(new_income)
    @annual_income = new_income
  end

  def budget_percent()
    return (spent_on_current_month().to_f/@monthly_budget_limit)*100
  end

  def spent_yearly()
    sql = "SELECT SUM(value) FROM transactions WHERE account_id = $1"
    values = [@id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent
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
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2"
    values = [month, @id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent
  end

  def spent_on_current_month()
    sql = "SELECT SUM(value) FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2"
    values = [Date.today.month, @id]
    total_spent = SqlRunner.run(sql, values)[0].values().first()
    return total_spent
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
