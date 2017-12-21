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

  def Tag.get_name_by_id(id)
    return (Tag.find(id)).name
  end

  def Tag.most_spent_on()
    sql = "select sum(value),tag_id from transactions GROUP BY tag_id ORDER BY sum desc"
    result = SqlRunner.run(sql)[0]['tag_id']
    return result.to_i
  end

  def Tag.total_spent_by_tag(tag)
    sql = "SELECT SUM(value) FROM transactions WHERE tag_id = $1"
    values = [tag.id]

    total_spent = SqlRunner.run(sql, values)[0]['sum']
    return total_spent || 0
  end

end
