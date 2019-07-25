--- 
Title: DBS
summary: Everything concerning dbs
---
- - - 
# postgres

#### **generate large table of fake data**


```sql
CREATE TABLE foo (c1 integer, c2 text);
INSERT INTO foo
    SELECT md5(random()::text)
    FROM generate_series(1, 100000) as i;
```

#### **Understanding Analze / Explain**

Basic rules
1. Lower width = better
2. Examine the query for disk read / writes. These are slow

#### **set working mem to be larger**
```sql
SET work_mem TO '200MB'
RESET work_mem
```

#### **join nodes**

1. **nested loops**: good for small tables
2. **merge joins**: sort then merge, index required. Fastest on large datasets
3. **hash joins**: only on equality joins. Mem dependent.

#### **major scan nodes**

1. **seq scan**: Read all the table in order
2. **index scan**: Read index to filter on the where clause
3. **bitmap index**: Same as above but quicket for large number of rows
4. **index only scan**: for covering index


- - -
## accessing
- - - 
#### **access local postgres db**

```bash
psql
```

#### **access remote postgres dbs**

```bash
psql -h <hostname> -U <user> postgres
```
example
```bash
psql -h backendpg1-preprev.ciepqiqtkoex.eu-west-1.rds.amazonaws.com -U analysis postgres
```

#### **leave server**
```bash
\q
```

#### **list databases**
```bash
\l
```

## **querying**

#### **basic in clause**

```sql
SELECT * FROM <blah> 
WHERE <col_derp> in ('thing1', 'thing2')
```

#### **fuzzy string matching**
```sql
SELECT * 
FROM adspots.data 
WHERE datadatetime BETWEEN '2017-08-02' AND '2017-08-03' 
AND tags::TEXT LIKE '%cost%'
```


#### **pulling stuff out of tags**

```sql
SELECT D.tags, D.channelid, channel,
    D.tags -> 'sh',
	d.tags ? 'prog'
  	FROM adspots.data as D
JOIN adspots.channel ac ON (D.channelid = ac.channelid)
WHERE datadatetime BETWEEN '2017-08-17 12:00:00' AND '2017-08-18 00:00:00'
```
D.tags -> ‘sh’    will create a column with the values of the ‘sh’ tag  
D.tags ? ‘prog’  will create a column of Boolean masks that determine weather prog is present in the table or not.   


#### **basic joins**
§
[guide to joins](http://www.postgresqltutorial.com/postgresql-joins/)

```sql
-- generic
SELECT shared_col, tab1.col_name 
FROM schema1.tab1 A  
JOIN schema2.tab1 B ON (A.colname = B.colname)
WHERE ...

-- example
SELECT tags, D.channelid, channel
FROM adspots.data as D
JOIN adspots.channel ac ON (D.channelid = ac.channelid)
WHERE datadatetime BETWEEN '2017-08-02' AND '2017-08-03'
AND tags::TEXT LIKE '%cost%'
 
```

#### **with temp tables**

```sql
with temp as (
    SELECT * FROM <blah>
)
    temp2 as (
    SELECT * FROM somewhereelse.
) 

```
#### **scratch**

```sql
-- query to try and work out which sessions are matched with original vs regex shizzle
SELECT count(*) FROM (
	SELECT usersessionid, datadatetime, action 
	FROM usersessionactions.v_usersessionactions
	WHERE datadatetime BETWEEN '2019-06-22' 
		AND '2019-06-23'
	AND brandid = 1
	AND action = 'viewusedvehiclepage') tng
RIGHT OUTER JOIN (
	SELECT usersessionid, datadatetime, action FROM usersessionactions.v_usersessionactions
	WHERE datadatetime BETWEEN '2019-06-22' 
	AND '2019-06-23'
	AND brandid = 1
	AND action = 'tngviewusedvehiclepage') orig ON (orig.usersessionid = tng.usersessionid and orig.datadatetime = tng.datadatetime) 


```

# mongo
- - - 
## Useful docs ##
[mongo shell](https://docs.mongodb.com/manual/reference/mongo-shell/)i
[collection('dbs')](https://docs.mongodb.com/manual/reference/method/js-collection/)

## Querying ##



### accessing
- - -

# athena 
- - - 

examples of doing stuff in athena programatically in
tvsquared/model.advancedtv L565 etc.

#### **Setting up a new table/database**


#### **querying using the partion structure**

