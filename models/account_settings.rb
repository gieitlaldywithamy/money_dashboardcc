require('./db/sql_runner')

class AccountSettings

  attr_reader :id, :name, :budget_limit

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @budget_limit = options['budget_limit'].to_f
    @time_period = options['time_period']
  end

  def save()
    sql = "INSERT INTO account_settings (name, budget_limit, time_period) VALUES ($1, $2, $3) RETURNING id;"
    values = [@name, @budget_limit, @time_period]
    account_settings = SqlRunner.run(sql, values)
    @id = account_settings[0]['id'].to_i
  end

  def update()
    sql = "UPDATE account_settings SET (name, budget_limit, time_period) = ($1, $2) WHERE id=$3;"
    values = [@name, @monthly_budget_limit, @time_period, @id]
    SqlRunner.run(sql, values)
  end



  def over_budget()
     how_much_spent = Transaction.total_spent.to_f
     return how_much_spent > @budget_limit
  end

  def AccountSettings.current_account()
    sql = "SELECT * FROM account_settings"
    return SqlRunner.run_sql_and_map(sql, AccountSettings).first()
  end

  def AccountSettings.delete_all()
    sql = "DELETE FROM account_settings;"
    SqlRunner.run(sql)
  end
end
