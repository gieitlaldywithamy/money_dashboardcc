require('./db/sql_runner')

class Category

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO Categorys (name) VALUES ($1) RETURNING id;"
    values = [@name]
    Category = SqlRunner.run(sql, values)
    @id = Category[0]['id'].to_i
  end

  def update()
    sql = "UPDATE Categorys SET name = $1 WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM Categorys WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Category.find(id)
    sql = "SELECT * FROM Categorys WHERE id=$1"
    values = [id]
    return SqlRunner.run_sql_and_map(sql, Category, [id])[0]
  end

  def Category.delete_all()
      sql = "DELETE FROM Categorys;"
      SqlRunner.run(sql)
  end

  def Category.all()
      sql = "SELECT * FROM Categorys;"
      merchants = SqlRunner.run_sql_and_map(sql, Category)
  end

  def Category.get_name_by_id(id)
    return (Category.find(id)).name
  end

  def Category.most_spent_on()
    sql = "select sum(value),Category_id from transactions GROUP BY Category_id ORDER BY sum desc"
    result = SqlRunner.run(sql)[0]['Category_id']
    return result.to_i
  end

  def Category.total_spent_by_Category(Category)
    sql = "SELECT SUM(value) FROM transactions WHERE Category_id = $1"
    values = [Category.id]

    total_spent = SqlRunner.run(sql, values)[0]['sum']
    return total_spent || 0
  end

end
