import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Catalog
from pyspark.sql.types import DateType
from pyspark.sql.functions import to_date
from pyspark.sql.functions import to_timestamp
import time
import csv

spark = SparkSession.builder.appName("pyspark-teste").getOrCreate()
spark.catalog.clearCache()
df = spark.read.options(header='true', inferschema='true', delimiter= ";").csv("Compras-Compras.csv")
df2 = df.withColumn("data", to_date(to_timestamp("data", "M/d/yyyy")))
df2.createOrReplaceTempView("compras")
#consulta 1
t1 = time.time()
result = spark.sql("select nome, SUM(quantidade) from compras group by nome")
t2 = time.time()
result.write.mode("overwrite").csv("resultsQ1.csv")

#consulta 2
t3 = time.time()
result = spark.sql("select endereco_ip, sum(valor), month(data) as mes, year(data) as ano from compras group by endereco_ip, month(data), year(data) order by endereco_ip asc")
t4 = time.time()
result.write.mode("overwrite").csv("resultsQ2.csv")

#consulta 3
t5 = time.time()
result = spark.sql("select vendedor_nome, sum(valor) as total from compras where year(data)=2022 group by vendedor_nome order by total desc")
t6 = time.time()
result.write.mode("overwrite").csv("resultsQ3.csv")

#consulta 4
t7 = time.time()
result = spark.sql("select produto, sum(quantidade) as total from compras where year(data)>2017 group by produto order by total desc LIMIT 1")
t8 = time.time()
result.write.mode("overwrite").csv("resultsQ4.csv")

#consulta5
t9 = time.time()
result = spark.sql("select produto, sum(quantidade) as total from compras where year(data)>2017 group by produto order by total asc LIMIT 1")
t10 = time.time()
result.write.mode("overwrite").csv("resultsQ5.csv")

#writer timer results
timer_results = open("timer.csv", "a")
writer = csv.writer(timer_results)
writer.writerow([t2-t1, t4-t3, t6-t5, t8-t7, t10-t9])
#timer_results.write("Timer for C: t1 " + str(t1) + " t2 " + str(t2))
timer_results.close()


