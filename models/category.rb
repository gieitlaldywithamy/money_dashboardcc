require('./db/sql_runner')

class Category

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @luxury = options['luxury']
  end

  def save
    if @id
      update()
    else
      insert()
    end
  end

  def insert()
    sql = "INSERT INTO categories(name, luxury) VALUES ($1, $2) RETURNING id;"
    values = [@name, @luxury]
    category = SqlRunner.run(sql, values)
    @id = category[0]['id'].to_i
  end

  def update()
    sql = "UPDATE categories SET name = $1, luxury =$2 WHERE id = $3;"
    values = [@name,@luxury, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM categories WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def total_spent()
    sql = "SELECT SUM(value) FROM transactions WHERE category_id = $1"
    values = [@id]

    total_spent = SqlRunner.run(sql, values)[0]['sum']
    return total_spent || 0
  end

  def Category.find(id)
    sql = "SELECT * FROM categories WHERE id=$1"
    values = [id]
    return SqlRunner.run_sql_and_map(sql, Category, [id])[0]
  end

  def Category.delete_all()
      sql = "DELETE FROM categories;"
      SqlRunner.run(sql)
  end

  def Category.all()
      sql = "SELECT * FROM categories;"
      merchants = SqlRunner.run_sql_and_map(sql, Category)
  end

  def Category.essential_categories()
      sql = "SELECT * FROM categories WHERE luxury = FALSE;"
      merchants = SqlRunner.run_sql_and_map(sql, Category)
  end

  def Category.luxury_categories()
      sql = "SELECT * FROM categories WHERE luxury = TRUE;"
      merchants = SqlRunner.run_sql_and_map(sql, Category)
  end

  def Category.get_name_by_id(id)

    return (Category.find(id)).name
  end

  def Category.anything_spent?()
    sql = "SELECT * FROM transactions"
    result = SqlRunner.run(sql)

    return result.count > 0
  end

  def Category.most_spent_on()
    sql = "select sum(value),category_id from transactions GROUP BY category_id ORDER BY sum desc"

    result = SqlRunner.run(sql)
    return result[0]['category_id'].to_i

  end

  def Category.total_spent_by_category(category)
    sql = "SELECT SUM(value) FROM transactions WHERE category_id = $1"
    values = [category.id]

    total_spent = SqlRunner.run(sql, values)[0]['sum']
    return total_spent || 0
  end

end
