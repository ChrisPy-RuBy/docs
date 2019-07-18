---
title: Spark
summary: Notes on spark
---


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

# pyspark 

# scala
