require('./db/sql_runner')

class User

  attr_reader :id, :name, :budget_limit, :time_period_start, :time_period_end

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @budget_limit = options['budget_limit'].to_f
    @time_period_start = options['time_period_start']
    @time_period_end = options['time_period_end']
  end

  def save()
    sql = "INSERT INTO user (name, budget_limit, time_period_end) VALUES ($1, $2, $3) RETURNING id;"
    # how to find out a month from time_period_start
    values = [@name, @budget_limit, @time_period_end]
    user = SqlRunner.run(sql, values)
    @time_period_start = user[0]['time_period_end']
    @id = user[0]['id'].to_i
  end

  def update()
    sql = "UPDATE user SET (name, budget_limit, time_period_start, time_period_end) = ($1, $2, $3, $4) WHERE id=$5;"
    values = [@name, @budget_limit, @time_period_start, @time_period_end, @id]
    SqlRunner.run(sql, values)
  end


  def how_many_days()
    sql = "SELECT time_period_end - time_period_start FROM user WHERE id=$1"
    return SqlRunner.run(sql, [@id]).values[0][0].to_i
  end

  def over_budget()
     how_much_spent = Transaction.total_spent
     return how_much_spent > @budget_limit
  end


  def AccountSettings.find(id)
    sql = "SELECT * FROM user WHERE id = $1"
    return SqlRunner.run_sql_and_map(sql, AccountSettings, [id])[0]
  end

  def AccountSettings.delete_all()
    sql = "DELETE FROM user;"
    SqlRunner.run(sql)
  end
end
