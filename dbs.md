--- 
Title: DBS
summary: Everything concerning dbs
---
- - - 
# postgres

## theory
 
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

##### **join nodes**

1. **nested loops**: good for small tables
2. **merge joins**: sort then merge, index required. Fastest on large datasets
3. **hash joins**: only on equality joins. Mem dependent.

#### **major scan nodes**

1. **seq scan**: Read all the table in order
2. **index scan**: Read index to filter on the where clause
3. **bitmap index**: Same as above but quicket for large number of rows
4. **index only scan**: for covering index


- - -
## accessing postgres
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

#### **display all data metadata**

```
\d+
-- for a specific table
\d+ <schema>.<table>
-- all tables
\d+ *.*
```
- - -
## **admin**
- - -

#### **turning logging on / off**

[guide to logging](https://tableplus.io/blog/2018/10/how-to-show-queries-log-in-postgresql.html)

#### **dump database**

```sql
pg_dump -s c1129_australiademo > /tmp/schema.sql
```
  
#### **dump schema**

```sql
pg_dump -s c1129_australiademo -n usersessions > /tmp/usersessions.sql
```

#### **restore database**

```sql
psql testdata < schema.sql
```

#### **creating indexes**

```sql
ux_<index name>
  ON <schema>.<table>
  USING btree
  (hasheduserip COLLATE pg_catalog."default", datadatetime);
```

#### **foreign keys**

```sql
ALTER TABLE adspotvalues.data 
    DROP CONSTRAINT fk_adspotvalues_data_adspotid
```

#### **transactions**

```sql
begin; 
```
starts the transactions

```sql
rollback;
-- if you dont want to keep your changes or want to dryrun
commit;
-- if you do want your changes
```

#### **grant premissions and access**

```sql
GRANT ALL ON TABLE <schema>.<table> TO <profile>;
GRANT SELECT ON TABLE <schema>.<table> TO <profile>;
```

#### **create a table**

```sql
CREATE TABLE IF NOT EXISTS <schema. table> (
col1 col1type
col2 col2type
col3 col3type
)
```

#### **copy data from db to disk**

```sql
COPY (SELECT * FROM <schema>.<table> 
        WHERE brandid =1 
        AND datadatetime BETWEEN '2016-04-17' and '2016-04-18' 
        ORDER BY brandid, datadatetime, mediumid, actionid, modelid, adspotid, usersessionid)
        to '/<filelocation>' with CSV;
```

with the table header

```sql
```sql
COPY (SELECT * FROM <schema>.<table> 
        WHERE brandid =1 
        AND datadatetime BETWEEN '2016-04-17' and '2016-04-18' 
        ORDER BY brandid, datadatetime, mediumid, actionid, modelid, adspotid, usersessionid)
        to '/<filelocation>' with CSV HEADER;
```

- - -
## inerting / updating
- - -


#### **table of fake data**

```sql
CREATE table foo (c1 integer, c2 text, c3 integer);
INSERT INTO foo (SELECT i, md5(random()::text), i/10
        FROM generate_series(1, 1000000) AS i);
```

#### **add a column**


#### **basic update **

updates current data

```sql
UPDATE  <schema>.<table>
SET datadatetime = datedatetime + INTERVAL "1 days"
```

#### **basic insert**

```sql
INSERT into <table> ( col1, col2, col3)
SELECT nextval('<table>_id_seq'), col2, (number + 5 ) as col3
FROM <table>
WHERE col1 = 3
```


- - - 
## **querying**
- - - 

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

#### **querying ips**

```sql
select *
from usersessions.data
where userip << '2001:0db8::/32'::cidr
limit 10
```

#### **hashing ips**

```sql
SELECT ENCODE(DIGEST('120.145.43.100', 'sha1'), 'hex')

SELECT ENCODE(DIGEST(userip::VARCHAR, 'sha1'), 'hex') FROM usersessions.data LIMIT 10;
SELECT userip::text, userip::inet, (SELECT ENCODE(DIGEST(host(userip), 'sha1'), 'hex')) as TEST FROM usersessions.data
LIMIT 4;
```
[encrypting shizzle](https://www.dbrnd.com/2016/03/postgresql-best-way-for-password-encryption-using-pgcryptos-cryptographic-functions/
)

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

#### **average tables**

```sql
with day_count as(
    SELECT date_trunc('day', datadatetime),
    COUNT(*) as c FROM usersessions.data 
    WHERE brandid = 1 group by 1) select avg(c) from day_count
)
```

#### **check something exists v.fast**
good for v.large datasets. Will exist as soon as it finds something. 
```sql
SELECT exists(SELECT 1 FROM <schema>.<table> WHERE <condition to check> LIMIT 1)
```

#### **group by datetimes**
[v.useful groupby datetime](http://ben.goodacre.name/tech/Group_by_day,_week_or_month_%28PostgreSQL%29)
```sql
SELECt date_trunc('day', datadatetime), count(*) FROM <schema>.<table>
WHERE <filter condition>
GROUP BY 1,
ORDER BY 1;
```




#### **basic joins**

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
[mongo shell](https://docs.mongodb.com/manual/reference/mongo-shell/)

[methods_collection_ref](https://docs.mongodb.com/manual/reference/method/js-collection/)


## **Maintainence and Manangment**

#### **dealing with indexes**

An index looks like this
brand_1_gran_1_group_1_metric_1_date_1_split_1_splitname_1_action_1
The query will go through the index sequentially until it can’t do anymore. Always specify the exact value not a range if possible. 


#### **setting up a raw db connection**

```python
server_url =  mongodb://username:password@somewhere.mongolayer.com:10011/my_database
username = analysis
password = <fuck shit bum>
```

#### **fast server stuff**

```python
for db in request.backenddb.mongo.list_databases():
    name = db.get('name')
    if name.startswith('bclient{}'.format(clienttorun)):
        clientdb = request.backenddb.mongo.get_database(db['name'])
        collections  set(clientdb.collections_names(include_system_colelctions=False))
        for collection in collections :
            <fuck shit bum>
```

#### **Deleting documents**

```javascript
db.getCollection("jobqueue").deleteMany({'jobtype': 'INF.CRON', 'jobstatus': 'FAILED'}
```

#### **Updating Docs**

find and update multidocs
```javascript
db.getCollection("jobqueue").update(<query>, {'$set': {'fuck': 'shit'}}, multi=True)
```

#### **sorting with pymongo**
[sorting](https://stackoverflow.com/questions/8109122/how-to-sort-mongodb-with-pymongo)

## **Basic Queries**

#### **Search for value where value is not equal to another value**

```javascript
{
        "$cond": {
            "if": {
                "$eq": [
                     "$_id", "$channel" ]
               
            },
            "then": "$$KEEP",
            "else": "$$PRUNE"
        }
    }
```
#### **distinct values**

```javascript
db.demographics.distinct('<thing>')
```

#### **count docs**
```javascript
db.brands.find({}).count()
```

#### **conditional querying of sub-docs**

example
```jvascript
db.brands.find({viscodeSettings: {$exists: true}}).
forEach(function(brand) {
if Object.keys(brand.viscodeSettings).length > 10 {
    print(brand._id)
}})
```


#### **where field A > B**

```javascript
db.getCollection("piwik1410-1.sessions").find({$expr: {$gt: ["$lasttime", "$time"]}}).sort({lasttime: 1})
```

#### **all values between two dates**

```python
q = { "datetime": { $gte: ISODate("2017-06-30"),  $lt: ISODate("2017-07-01")}}
```

#### **mongo regexes**

basic example
```javascript
{"channel": /^DISC/i}
```
where /<regex>/ is the regex
^ is start 
$ is end
i is case insensitive


#### **search for a single field in multiple values**

```python
q = {shortid: {$in: [282, 1229]}} 
```

## **Aggregate Queries**

## **bugs**

#### **data directory not found**

fixed with 
```bash
mongodb --dbpath /usr/local/var/mongodbmongo
```



## accessing
- - -

# athena 
- - - 

examples of doing stuff in athena programatically in
tvsquared/model.advancedtv L565 etc.

#### **Setting up a new table/database**

## Querying

#### **regex shizzle**

``` sql
SELECT regexp_like(url, <regex> FROM <blah> 
```

```sql
SELECT * FROM <foo> WHERE
strpos(url, '<regex>')
```

```sql
SELECT * FROM  <foo> WHERE
url is like '%derp%'
```


#### **querying using the partion structure**

```sql
SELECT url FROM “collector_tng_pre_visit”.“data”
WHERE site_id = ‘4432-1’
AND yy=‘2019’
AND mm=‘06’
AND dd=‘26’
AND hh=‘11’
AND url like ‘%nvcc%’
```
WHERE site_id, yy, mm, dd, and hh are partitions

