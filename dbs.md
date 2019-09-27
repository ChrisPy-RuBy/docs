Title: Postgres/table 
summary: Everything concerning dbs
# theory
- - - 
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
# accessing postgres
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
# admin
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
COPY (SELECT * FROM <schema>.<table> 
        WHERE brandid =1 
        AND datadatetime BETWEEN '2016-04-17' and '2016-04-18' 
        ORDER BY brandid, datadatetime, mediumid, actionid, modelid, adspotid, usersessionid)
        to '/<filelocation>' with CSV HEADER;
```

#### **copy data from csv to db**

be aware there are issues between \copy and copy.
Also the delimiter stuff is an arse

```sql
\Copy <csv name> from <datelocation> CSV 
DELIMITER E'\t NULL'\\N'
```

- - -
# inserting / updating
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

#### **insert scratch**

```sql
INSERT INTO usersessions.data (include,
                               usersessionid,
                               rowid,
                               tags,  
                               fileid,
                               datadatetime,
                               sessionrefid,
                               mediumid,
                               regionid,
                               brandid,
                               serveraddressid,
                               userid,
                               userip,
                               modelid,
                               cookiehash,
                               useraddress2) 
SELECT include,
       nextval('usersessions.data_usersessionid_seq'),
       rowid,
       tags,
       fileid,
       datadatetime + INTERVAL '900 days',
       sessionrefid,
       mediumid,
       regionid,
       brandid,
       serveraddressid,
       userid,
       userip,
       modelid,
       cookiehash,
       useraddress2
       FROM usersessions.data
       WHERE datadatetime 
                     between '2016-05-04' and '2016-05-06';
```

```sql
INSERT INTO randomtable (description, number)
SELECT REPLACE(description, 'foobar', 'boofar'), (number + 5) as number
FROM randomtable WHERE id = 4;
```


- - - 
# querying
- - - 

#### **basic operators**

```sql
 <thing> <> 6
 -- not equal to
```

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

#### **pulling stuff out of tags/hstore**

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


#### **hstore scratch**
 
selecting shizzle 
```sql
select
    tags->'_supplieddatetime' as original_sup,
    tags->'_suppliedlocaldatetime' as original_loc,
    tags || hstore(
            '_supplieddatetime', replace(((tags->'_supplieddatetime')::timestamp + interval '525 days')::text, ' ', 'T')
       ) || hstore(
            '_suppliedlocaldatetime', replace(((tags->'_suppliedlocaldatetime')::timestamp + interval '525 days')::text, ' ', 'T')
       
       as new_tags
from adspots.data where tags?'_supplieddatetime' limit 2000
;
```

updating shizzle
```sql
update adspots.data
set tags = tags || hstore(
                    '_supplieddatetime', replace(
                        ((tags->'_supplieddatetime')::timestamp + interval '525 days')::text, ' ', 'T'
                    )
                )
                || hstore(
                    '_suppliedlocaldatetime', replace(
                        ((tags->'_suppliedlocaldatetime')::timestamp + interval '525 days')::text, ' ', 'T'
                    )
                )
where tags?'_supplieddatetime'
;
```

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

an alternative to the above is. This is generate the 
number of unique dates but not the count per day.

```sql
SELECT COUNT(DISTINCT CAST(datadatetime as Date))
FROM adspots.data
```

#### **case statements**
case statements can be used to do conditional shizzle
```sql
SELECT deviceid,
        sum(CASE WHEN brand='Booking.com' THEN 1 ELSE 0 END) as Booking,
        sum(CASE WHEN brand='Expedia' THEN 1 ELSE 0 END) as Expedia_views
FROM alphonso_raw_impressions
GROUP BY deviceid;
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

#### **window functions**

[guide to window functions](http://www.postgresqltutorial.com/postgresql-window-function/
)

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


