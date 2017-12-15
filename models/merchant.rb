require('./db/sql_runner')

class Merchant

  attr_reader :id
  
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id;"
    values = [@name]
    merchant = SqlRunner.run(sql, values)
    @id = merchant[0]['id'].to_i
  end

  def self.delete_all()
      sql = "DELETE FROM merchants;"
      SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM merchants;"
      merchants = SqlRunner.run_sql_and_map(sql, 'Merchant')
  end

end
