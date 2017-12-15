require('./db/sql_runner')

class Tag

  attr_reader :id
  
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

  def self.delete_all()
      sql = "DELETE FROM tags;"
      SqlRunner.run(sql)
  end

  def self.all()
      sql = "SELECT * FROM tags;"
      merchants = SqlRunner.run_sql_and_map(sql, 'Tag')
  end

end
