require('./db/sql_runner')

class Tag

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id;"
    values = [@name]
    tag = SqlRunner.run(sql, values)
    @id = tag[0]['id'].to_i
  end

  def update()
    sql = "UPDATE tags SET name = $1 WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Tag.find(id)
    sql = "SELECT * FROM tags WHERE id=$1"
    values = [id]
    return SqlRunner.run_sql_and_map(sql, Tag, [id])[0]
  end

  def Tag.delete_all()
      sql = "DELETE FROM tags;"
      SqlRunner.run(sql)
  end

  def Tag.all()
      sql = "SELECT * FROM tags;"
      merchants = SqlRunner.run_sql_and_map(sql, Tag)
  end

  def Tag.user_spent_most_on(user_id)
    sql = "SELECT tags.name, MAX(transactions.value)SELECT SUM(transactions.value)
    FROM tags
    INNER JOIN transactions on transaction.tag_id = tags.id
    WHERE transactions.account_id = $1"
    return SqlRunner.run(sql, [user_id])
  end

  

end
