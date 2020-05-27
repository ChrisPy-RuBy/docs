cheatsheet do
  title 'Spark'                 # Will be displayed by Dash in the docset list
  docset_file_name 'Spark'    # Used for the filename of the docset
  keyword 'Spark'             # Used as the initial search keyword (listed in Preferences > Docsets)
  # resources 'resources_dir'  # An optional resources folder which can contain images or anything else
  #
  #   introduction 'shamelessly stolen from devhints.io'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
	id 'Context'
    entry do
	name 'RDD Context'
	notes <<-'END'
```python
from pyspark import SparkContext
sc = SparkContext(master = 'local[2]')
rdd = sc.parallelize([('a',7),('a',2),('b',2)])
```:
    END
    end
    entry do
	name 'SQL Context'
	notes <<-'END'
```python
from pyspark import SparkContext, SQLContext

sql_ctx = SQLContext(sc)
```
  END
    end
  





  

