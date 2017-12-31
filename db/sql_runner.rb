require ('pg')

class SqlRunner

  def SqlRunner.run(sql, values = [])
   db = PG.connect({dbname: 'defqlm9nkpe56a', host: 'ec2-54-83-46-116.compute-1.amazonaws.com',
     port: 5432, user: 'mtluwkblumblcm', password: '6e1df5cb36949157230b874f9cbcce292bfd2ea36b8d1261ec439d4e1dcb39ff'})
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
