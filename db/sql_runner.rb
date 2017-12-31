require ('pg')

class SqlRunner

  def SqlRunner.run(sql, values = [])
   db = PG.connect({dbname: 'piggybank', host: 'localhost'})
   db.prepare("query", sql)
   result = db.exec_prepared("query", values)
   db.close()
   return result
 end

 def SqlRunner.map_object(array, classname)
   return array.map {|item| classname.new(item)}
 end

 def SqlRunner.run_sql_and_map(sql, classname, values = [])
   return SqlRunner.map_object(SqlRunner.run(sql, values), classname)
 end
end
