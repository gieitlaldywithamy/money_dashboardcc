require('./db/sql_runner')

class Transaction

  attr_reader :value, :merchant_id, :tag_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @value = options['value']
    @merchant_id = options['merchant_id'].to_i()
    @tag_id = options['tag_id'].to_i()
  end

  def save()
    sql = "INSERT INTO transactions (value, merchant_id, tag_id) VALUES ($1, $2, $3) RETURNING id;"
    values = [@value, @merchant_id, @tag_id]
    transaction = SqlRunner.run(sql, values)
    @id = transaction[0]['id'].to_i()
  end

  def Transaction.all()
    sql = "SELECT * FROM transactions;"
    return SqlRunner.run_sql_and_map(sql, Transaction)
  end


end
