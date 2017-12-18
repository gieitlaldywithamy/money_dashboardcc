require('./db/sql_runner')

class AccountSettings

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @monthly_budget_limit = options['budget_limit']
  end

  def save()
    sql = "INSERT INTO account_settings (name, budget_limit) VALUES ($1, $2) RETURNING id;"
    values = [@name, @budget_limit]
    account_settings = SqlRunner.run(sql, values)
    @id = account_settings[0]['id'].to_i
  end

  def update()
    sql = "UPDATE account_settings SET (name, budget_limit) = ($1, $2) WHERE id=$3;"
    values = [@name, @monthly_budget_limit, @id]
    SqlRunner.run(sql, values)
  end

  def budget_left()
    sql = "select now() - date_of_join as "

  def AccountSettings.delete_all()
    sql = "DELETE FROM account_settings;"
    SqlRunner.run(sql)
  end
end
