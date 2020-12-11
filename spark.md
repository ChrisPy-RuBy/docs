title: spark
summary: Notes on spark

# basics

## exception handling in spark 

exceptions will not propagate up like they would in normal python code.
they can't propagate onto the driver.

```python
def layer_one():
	raise ValueError

def layer_two():
	try:
		layer_one()
	except ValueError
		raise  TypeError

def layer_three():

	try:
		layer_two()
	except TypeError:
		print("from the value error in layer_one")
layer_three()
```

```python
data = [1, 3, 4, 5, 6]
def fun_times_yield(request, x):

	for a in x:
		try:
			if a == 3:
				result = a / 0
			else:
				result = a * 2
		except ZeroDivisionError as e:
			request.log.exception(e) # this won't propagate up so need to do something else with it
		else:
			yield result

sc = request.getSparkContext()
super_fun_times = request.sparkWrap(fun_times)
y = sc.parallelize(data).mapPartitions(super_fun_times).collect()
```

## **map vs map partitions** 

```python


```
```





## **profiling spark code**

use the profiler
[tit gay](https://spark.apache.org/docs/latest/api/python/pyspark.html?highlight=profiling#pyspark.Profiler)

#### **access the shell**

```python
pyspark
```
 
#### **spark in browser debug**
[here](http://localhost:4040/jobs/job/?id=0)

#### **basic code debug**
```python
wholeRDD = [x for x in RDD.collect()]
# get whole rdd as a list
partRDD = [x for x in RDD.take(10)]
``` 

#### **basic redeading and writing from s3**
Outside of the backend

[read this](https://medium.com/@bogdan.cojocar/how-to-read-json-files-from-s3-using-pyspark-and-the-jupyter-notebook-275dcb27e124
)

# core spark

## **accumulators**

#### **defining a custom accumulator**
[spark accumulators](https://stackoverflow.com/questions/38212134/custom-accumulator-class-in-spark)
see also sparkstream

## **actions vs transactions**

[actions_vs_transactions](https://data-flair.training/blogs/spark-rdd-operations-transformations-actions/)

## **partioning**

Useful notes for partioning in spark
[link](https://medium.com/parrot-prediction/partitioning-in-apache-spark-8134ad840b0)
[link](https://jaceklaskowski.gitbooks.io/mastering-apache-spark/content/spark-rdd-partitions.html)
[link](https://stackoverflow.com/questions/34491219/default-partitioning-scheme-in-spark)
[link](https://techmagie.wordpress.com/2015/12/19/understanding-spark-partitioning)
[link](https://medium.com/@mrpowers/managing-spark-partitions-with-coalesce-and-repartition-4050c57ad5c4/)
[link](https://www.youtube.com/watch?v=WyfHUNnMutg)

## **useful debug for spark partitions**

```python
def partitionDebug(self, sc, RDD, glom=False):
    self.log.debug("Default parallelism: {}".format(sc.defaultParallelism))
    self.log.debug("Number of partitions: {}".format(RDD.getNumPartitions()))
    self.log.debug("Partitioner: {}".format(RDD.partitioner))
    if glom:
        self.log.debug("Partitions structure: {}".format(RDD.glom().collect()))
```


# sql spark

##### **RDD to DF**

```python
derp = sc.parallelize(<yourshittydata>)
SQLCtx = SQLContent(sc)
df = SQLCtx.createDataFrame(derp)
df.show()
```

#### **querying dataframes**

[good guide](https://www.analyticsvidhya.com/blog/2016/10/spark-dataframe-and-operations/)


#### **Getting up and running**

```python
# get SparkSQL context,  and row
from pyspark.sql import SQLContext, Row

# get context
sqlCtx = SQLContext(sc)
Inputfile = ‘<pathto  jsonfile>’

#load some datas
input = sqlCtx.read.json(inputfile)

# view data
input.show()

# Create queryable table 
input.registerTempTable('clickpiss')

# query data
records = sqlCtx.sql("""SELECT * FROM clickpiss WHERE last_visit_timestamp == 1548091943""")

Ran pyspark like this 
$~ pyspark --driver-class-path Downloads/postgresql-42.1.1.jar --jars Downloads/postgresql-42.1.1.jar

Then connected to databases like this.

 x = spark.read.format("jdbc").option("url", "jdbc:postgresql://localhost:5432/c103746_spaindemo").option("driver", "org.postgresql.Driver").option("dbtable", "adspots.data").option("user", "postgres").option("password", "postgres").load()

# show your table.
>>>x.show()

Then I downloaded the jar from
http://central.maven.org/maven2/org/postgresql/postgresql/
and added it to my ~/spark/jar folder


Alternative to the above syntax
>>> y = sqlCtx.read.jdbc("jdbc:postgresql://localhost:5432/c103746_spaindemo", "adspots.data", properties={"user": "postgres", "password": "postres"})
```



##### **reading/ writing files**


WRITE PARQUET FILES

I want to be able to write a parquet file per day
from pyspark.sql.functions import to_date
dt = df.select('*', (to_date(df.datadatetime).alias('date')))
df.write.format("parquet").partitionBy("date").save('/tmp/clickpiss4.parquet/')

READ PARQUET FILES

de = sqlCtx.read.parquet("/tmp/clickpiss4.parquet")

This creates a parquet thing that we can now query

de.filter("datadatetime <= '2018-10-11' and datadatetime > '2018-10-10'").show()


WRITE TO A POSTGRES TABLE

newstuff.write.jdbc("jdbc:postgresql://localhost:5432/sandbox", "public.adspotsdata1", properties={"user": "postgres", "password": "postres"})

This will create and insert the data into a postgres table in the sandbox database, in the public.adspotsdata1 table.

wr

# pyspark 

# scala

#### **spark history on local**

```
spark.history.fs.logDirectory file:///Users/michaelavanesveld/spark/eventlog
inside my spark conf ~/spark/spark-latest/conf/spark-defaults.conf and then go to http://localhost:18080/
oh and start the history server ./sbin/start-history-server.sh but yay!
```
