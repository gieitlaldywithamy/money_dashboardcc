require('./db/sql_runner')

class User

  attr_reader :id, :name, :budget_limit

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @budget_limit = options['budget_limit'].to_f
    # @time_period_start = options['time_period_start']
    # @time_period_end = options['time_period_end']
  end

  def save()
    binding.pry
    if @id
      update()
    else
      insert()
    end
  end

  def insert()

    sql = "INSERT INTO users (name, budget_limit) VALUES ($1, $2) RETURNING id;"
    # how to find out a month from time_period_start
    values = [@name, @budget_limit]
    user = SqlRunner.run(sql, values)

    @id = user[0]['id'].to_i
  end

  def update()
    sql = "UPDATE users SET (name, budget_limit) = ($1, $2) WHERE id=$3;"
    values = [@name, @budget_limit, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def has_used_account()
    return Transaction.user_all(@id).count() > 0
  end

  # def how_many_days()
  #   sql = "SELECT time_period_end - time_period_start FROM users WHERE id=$1"
  #   return SqlRunner.run(sql, [@id]).values[0][0].to_i
  # end

  def budget_percent()
    p spent(), @budget_limit, " percent wise"
    return (spent().to_f/@budget_limit)*100
  end

  def budget_left()
    if over_budget()
      return 0
    else
      return @budget_limit - spent().to_f
    end
  end

  def over_budget()

     return spent().to_f > @budget_limit
  end

  def spent()
    sql = "SELECT SUM(value) FROM transactions WHERE account_id = $1;"
    values = [@id]
    return SqlRunner.run(sql, values)[0].values().first()
  end

  def transactions_for_month(month)
    sql =  "SELECT * FROM transactions WHERE EXTRACT(MONTH FROM transactions.transaction_date) = $1 AND account_id = $2"
    values = [month, @id]
    total_spent = SqlRunner.run_sql_and_map(sql, Transaction, values)
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
end
