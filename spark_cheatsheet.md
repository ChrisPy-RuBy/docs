Python For Data Science Cheat Sheet
PySpark - RDD Basics

Learn Python for data science Interactively at www.DataCamp.com

Spark
PySpark is the Spark Python API that exposes
the Spark programming model to Python.

Initializing Spark
SparkContext
>>> from pyspark import SparkContext
>>> sc = SparkContext(master = 'local[2]')

Inspect SparkContext
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>

sc.version
sc.pythonVer
sc.master
str(sc.sparkHome)
str(sc.sparkUser())

Retrieve SparkContext version
Retrieve Python version
Master URL to connect to
Path where Spark is installed on worker nodes
Retrieve name of the Spark User running
SparkContext
sc.appName
Return application name
sc.applicationId
Retrieve application ID
sc.defaultParallelism
Return default level of parllelism
sc.defaultMinPartitions Default minimum number of partitions for
RDDs

Configuration
>>> from pyspark import SparkConf, SparkContext
>>> conf = (SparkConf()
.setMaster("local")
.setAppName("My app")
.set("spark.executor.memory", "1g"))
>>> sc = SparkContext(conf = conf)

Using The Shell
In the PySpark shell, a special interpreter-aware SparkContext is already
created in the variable called sc.
$ ./bin/spark-shell --master local[2]
$ ./bin/pyspark --master local[4] --py-files code.py

Set which master the context connects to with the --master argument, and
add Python .zip, .egg or .py files to the runtime path by passing a
comma-separated list to --py-files.

Loading Data
Parallelized Collections
>>>
>>>
>>>
>>>

rdd = sc.parallelize([('a',7),('a',2),('b',2)])
rdd2 = sc.parallelize([('a',2),('d',1),('b',1)])
rdd3 = sc.parallelize(range(100))
rdd4 = sc.parallelize([("a",["x","y","z"]),
("b",["p", "r"])])

External Data
Read either one text file from HDFS, a local file system or or any
Hadoop-supported file system URI with textFile(), or read in a directory
of text files with wholeTextFiles().

>>> textFile = sc.textFile("/my/directory/*.txt")
>>> textFile2 = sc.wholeTextFiles("/my/directory/")

Retrieving RDD Information

Reshaping Data

Basic Information

Reducing

>>> rdd.getNumPartitions()
>>> rdd.count()
3
>>> rdd.countByKey()
defaultdict(<type 'int'>,{'a':2,'b':1})
>>> rdd.countByValue()

List the number of partitions
Count RDD instances

>>> rdd.collectAsMap()
{'a': 2,'b': 2}
>>> rdd3.sum()
4950
>>> sc.parallelize([]).isEmpty()
True

Return (key,value) pairs as a
dictionary
Sum of RDD elements

Count RDD instances by key

defaultdict(<type 'int'>,{('b',2):1,('a',2):1,('a',7):1})

Count RDD instances by value

Check whether RDD is empty

Maximum value of RDD elements
Minimum value of RDD elements
Mean value of RDD elements
Standard deviation of RDD elements
Compute variance of RDD elements
Compute histogram by bins
Summary statistics (count, mean, stdev, max &
min)

Selecting Data
Getting

>>> rdd.collect()
[('a', 7), ('a', 2), ('b', 2)]
>>> rdd.take(2)
[('a', 7), ('a', 2)]
>>> rdd.first()
('a', 7)
>>> rdd.top(2)
[('b', 2), ('a', 7)]

Return a list with all RDD elements
Take first 2 RDD elements
Take first RDD element
Take top 2 RDD elements

Sampling

>>> rdd3.sample(False, 0.15, 81).collect() Return sampled subset of rdd3
[3,4,27,31,40,41,42,43,60,76,79,80,86,97]
>>> rdd.filter(lambda x: "a" in x)
.collect()
[('a',7),('a',2)]
>>> rdd5.distinct().collect()
['a',2,'b',7]
>>> rdd.keys().collect()
['a', 'a', 'b']

Filter the RDD
Return distinct RDD values
Return (key,value) RDD's keys

Iterating
>>> def g(x): print(x)
>>> rdd.foreach(g)
('a', 7)
('b', 2)
('a', 2)

>>> rdd3.groupBy(lambda x: x % 2)
.mapValues(list)
.collect()
>>> rdd.groupByKey()
.mapValues(list)
.collect()
[('a',[7,2]),('b',[2])]

Return RDD of grouped values

Merge the rdd values

Grouping by

Group rdd by key

>>> seqOp = (lambda x,y: (x[0]+y,x[1]+1))
>>> combOp = (lambda x,y:(x[0]+y[0],x[1]+y[1]))
>>> rdd3.aggregate((0,0),seqOp,combOp)
(4950,100)
>>> rdd.aggregateByKey((0,0),seqop,combop)
.collect()
[('a',(9,2)), ('b',(2,1))]
>>> rdd3.fold(0,add)
4950
>>> rdd.foldByKey(0, add)
.collect()
[('a',9),('b',2)]
>>> rdd3.keyBy(lambda x: x+x)
.collect()

Aggregate RDD elements of each
partition and then the results
Aggregate values of each RDD key

Aggregate the elements of each
partition, and then the results
Merge the values for each key

Create tuples of RDD elements by
applying a function

Mathematical Operations

Applying Functions
>>> rdd.map(lambda x: x+(x[1],x[0]))
Apply a function to each RDD element
.collect()
[('a',7,7,'a'),('a',2,2,'a'),('b',2,2,'b')]
>>> rdd5 = rdd.flatMap(lambda x: x+(x[1],x[0])) Apply a function to each RDD element
and flatten the result
>>> rdd5.collect()
['a',7,7,'a','a',2,2,'a','b',2,2,'b']
>>> rdd4.flatMapValues(lambda x: x)
Apply a flatMap function to each (key,value)
.collect()
pair of rdd4 without changing the keys
[('a','x'),('a','y'),('a','z'),('b','p'),('b','r')]

Filtering

Merge the rdd values for
each key

Aggregating

Summary

>>> rdd3.max()
99
>>> rdd3.min()
0
>>> rdd3.mean()
49.5
>>> rdd3.stdev()
28.866070047722118
>>> rdd3.variance()
833.25
>>> rdd3.histogram(3)
([0,33,66,99],[33,33,34])
>>> rdd3.stats()

>>> rdd.reduceByKey(lambda x,y : x+y)
.collect()
[('a',9),('b',2)]
>>> rdd.reduce(lambda a, b: a + b)
('a',7,'a',2,'b',2)

>>> rdd.subtract(rdd2)
.collect()
[('b',2),('a',7)]
>>> rdd2.subtractByKey(rdd)
.collect()
[('d', 1)]
>>> rdd.cartesian(rdd2).collect()

Return each rdd value not contained
in rdd2
Return each (key,value) pair of rdd2
with no matching key in rdd
Return the Cartesian product of rdd
and rdd2

Sort
>>> rdd2.sortBy(lambda x: x[1])
.collect()
[('d',1),('b',1),('a',2)]
>>> rdd2.sortByKey()
.collect()
[('a',2),('b',1),('d',1)]

Sort RDD by given function
Sort (key, value) RDD by key

Repartitioning
>>> rdd.repartition(4)
>>> rdd.coalesce(1)

New RDD with 4 partitions
Decrease the number of partitions in the RDD to 1

Saving
>>> rdd.saveAsTextFile("rdd.txt")
>>> rdd.saveAsHadoopFile("hdfs://namenodehost/parent/child",
'org.apache.hadoop.mapred.TextOutputFormat')

Stopping SparkContext
>>> sc.stop()

Execution
Apply a function to all RDD elements

$ ./bin/spark-submit examples/src/main/python/pi.py




aPython For Data Science Cheat Sheet
PySpark - SQL Basics

Learn Python for data science Interactively at www.DataCamp.com

GroupBy

Duplicate Values
>>> df = df.dropDuplicates()

>>> df.groupBy("age")\
Group by age, count the members
.count() \
in the groups
.show()			

Queries

Filter

>>> from pyspark.sql import functions as F

Select

PySpark & Spark SQL
Spark SQL is Apache Spark's module for
working with structured data.

Initializing SparkSession
A SparkSession can be used create DataFrame, register DataFrame as tables,
execute SQL over tables, cache tables, and read parquet files.
>>> from pyspark.sql import SparkSession
>>> spark = SparkSession \
.builder \
.appName("Python Spark SQL basic example") \
.config("spark.some.config.option", "some-vlue") \
.getOrCreate()

Creating DataFrames

explode("phoneNumber") \
.alias("contactInfo")) \

Show all entries in firstName column
Show all entries in firstName, age
and type

>>> from pyspark.sql.types import *

Infer Schema

sc = spark.sparkContext
lines = sc.textFile("people.txt")
parts = lines.map(lambda l: l.split(","))
people = parts.map(lambda p: Row(name=p[0],age=int(p[1])))
peopledf = spark.createDataFrame(people)

Specify Schema

>>> people = parts.map(lambda p: Row(name=p[0],
age=int(p[1].strip())))
>>> schemaString = "name age"
>>> fields = [StructField(field_name, StringType(), True) for
field_name in schemaString.split()]
>>> schema = StructType(fields)
>>> spark.createDataFrame(people, schema).show()
+--------+---+
|
name|age|
+--------+---+
|
Mine| 28|
|
Filip| 29|
|Jonathan| 30|
+--------+---+

JSON

>>> df = spark.read.json("customer.json")
>>> df.show()

+--------------------+---+---------+--------+--------------------+
|
address|age|firstName |lastName|
phoneNumber|
+--------------------+---+---------+--------+--------------------+
|[New York,10021,N...| 25|
John|
Smith|[[212 555-1234,ho...|
|[New York,10021,N...| 21|
Jane|
Doe|[[322 888-1234,ho...|
+--------------------+---+---------+--------+--------------------+

>>> df2 = spark.read.load("people.json", format="json")

Parquet files

>>> df3 = spark.read.load("users.parquet")

TXT files

>>> df4 = spark.read.text("people.txt")

>>> df.select("firstName",
F.when(df.age > 30, 1) \
.otherwise(0)) \
.show()
>>> df[df.firstName.isin("Jane","Boris")]
.collect()

>>> df.na.fill(50).show() Replace null values
>>> df.na.drop().show() Return new df omitting rows with null values
>>> df.na \
Return new df replacing one value with
.replace(10, 20) \ another
.show()

When

Show firstName and 0 or 1 depending
on age >30
Show firstName if in the given options

>>> df.select("firstName",
Show firstName, and lastName is
df.lastName.like("Smith")) \ TRUE if lastName is like Smith
.show()

Startswith - Endswith

>>> df.select("firstName",
Show firstName, and TRUE if
df.lastName \
lastName starts with Sm
.startswith("Sm")) \
.show()
>>> df.select(df.lastName.endswith("th")) \ Show last names ending in th
.show()

Substring

>>> df.select(df.firstName.substr(1, 3) \
Return substrings of firstName
.alias("name")) \
.collect()

Between

>>> df.select(df.age.between(22, 24)) \
.show()

Show age: values are TRUE if between
22 and 24

Add, Update & Remove Columns
>>> df = df.withColumn('city',df.address.city) \
.withColumn('postalCode',df.address.postalCode) \
.withColumn('state',df.address.state) \
.withColumn('streetAddress',df.address.streetAddress) \
.withColumn('telePhoneNumber',
explode(df.phoneNumber.number)) \
.withColumn('telePhoneType',
explode(df.phoneNumber.type))

Updating Columns
>>> df = df.withColumnRenamed('telePhoneNumber', 'phoneNumber')

Removing Columns
>>> df = df.drop("address", "phoneNumber")
>>> df = df.drop(df.address).drop(df.phoneNumber)

Inspect Data
>>>
>>>
>>>
>>>
>>>
>>>

df.dtypes
df.show()
df.head()
df.first()
df.take(2)
df.schema

Return df column names and data types
Display the content of df
Return first n rows
Return first row
Return the first n rows
Return the schema of df

Sort

.select("contactInfo.type",
"firstName",
"age") \
.show()
>>> df.select(df["firstName"],df["age"]+ 1) Show all entries in firstName and age,
.show()
add 1 to the entries of age
>>> df.select(df['age'] > 24).show()
Show all entries where age >24

Adding Columns

From Spark Data Sources

>>> df.filter(df["age"]>24).show() Filter entries of age, only keep those
				
records of which the values are >24

>>> peopledf.sort(peopledf.age.desc()).collect()
>>> df.sort("age", ascending=False).collect()
>>> df.orderBy(["age","city"],ascending=[0,1])\
.collect()

Like

From RDDs
>>>
>>>
>>>
>>>
>>>

>>> df.select("firstName").show()
>>> df.select("firstName","lastName") \
.show()
>>> df.select("firstName",
"age",

>>>
>>>
>>>
>>>
>>>
>>>

df.describe().show()
df.columns
df.count()
df.distinct().count()
df.printSchema()
df.explain()

Compute summary statistics
Return the columns of df
Count the number of rows in df
Count the number of distinct rows in df
Print the schema of df
Print the (logical and physical) plans

Missing & Replacing Values

Repartitioning
>>> df.repartition(10)\
.rdd \
.getNumPartitions()
>>> df.coalesce(1).rdd.getNumPartitions()

df with 10 partitions
df with 1 partition

Running SQL Queries Programmatically
Registering DataFrames as Views
>>> peopledf.createGlobalTempView("people")
>>> df.createTempView("customer")
>>> df.createOrReplaceTempView("customer")

Query Views
>>> df5 = spark.sql("SELECT * FROM customer").show()
>>> peopledf2 = spark.sql("SELECT * FROM global_temp.people")\
.show()

Output
Data Structures
>>> rdd1 = df.rdd
>>> df.toJSON().first()
>>> df.toPandas()
			

Convert df into an RDD
Convert df into a RDD of string
Return the contents of df as Pandas

DataFrame

Write & Save to Files
>>> df.select("firstName", "city")\
.write \
.save("nameAndCity.parquet")
>>> df.select("firstName", "age") \
.write \
.save("namesAndAges.json",format="json")

Stopping SparkSession
>>> spark.stop()

DataCamp

Learn Python for Data Science Interactively


a
