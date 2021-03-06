Title: postgres
summary: Everything concerning dbs
- - - 

# postgres

## basics

### on the prompt

```sql
\du  -- get users and permissions
\d scheam.table -- in db get all the useful details about a table
\l -- list dbs 
\q -- quit

```

## tips / tricks

- never cast against column cast against values
- always thing about what happens when you run an update / insert twice

### union all vs in

sometimes using "in" is slow
Using "union all" can sometimes speed things up

```sql 
SELECT * FROM blarp
WHERE bloop in ("a", "b", "c")

-- vs 
SELECT * FROM blarp
WHERE bloop = "a"
UNION ALL
SELECT * FROM blarp
WHERE bloop = "b"
```

## troubleshooting

just do this straight away
```bash
tail -f /usr/local/var/log/postgres.log
```

### lockfile pid already exists

this error

lock file "postmaster.pid" already exists

likely due to stray lock I believe
kill the lock and restart

```
cat /usr/local/var/postgres/postmaster.pid
kill PID    # taken from the first line

pg_ctl -D /usr/local/var/postgres start
pg_ctl -D /usr/local/var/postgres stop

brew services start postgresql
```

sometimes youjust need to delete the pid file.

### psql: could not connect to server: No such file or directory

```
Is the server running locally and accepting
connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```

server configuration file postgres does not know where to find the server configuration file. 
You must specify the --config-file or -D invocation option or set the PGDATA environment variable.
Delete postmaster.pid file in /usr/local/var/postgres

NOTE: frequently associated with failed update to a more recent version of postgrs

```bash
# back up db
mv /usr/local/var/postgres/ /usr/local/var/postgres.test.backup/ 
initdb --locale=C -E UTF-8 /usr/local/var/postgres
createdb <dbname>
psql # set up relevant postgres roles and permissions 
```

## theory
- - - 

### types of deleting

- marking as deleted. The row is exists in table but is markied as deleted
- autovacuumed. Row still exists
- full vacuum.  table completely rebuilt from  scratch.

### index types

sparse index:- only has values in the index that are populated

### Understanding Analze / Explain

Basic rules  
1. Lower width = better  
2. Examine the query for disk read / writes. These are slow  

### set working mem to be larger
```sql
SET work_mem TO '200MB'
RESET work_mem
```

#### join nodes

1. nested loops: good for small tables
2. merge joins: sort then merge, index required. Fastest on large datasets
3. hash joins: only on equality joins. Mem dependent.

### major scan nodes

1. seq scan: Read all the table in order
2. index scan: Read index to filter on the where clause
3. bitmap index: Same as above but quicket for large number of rows
4. index only scan: for covering index


- - -
## accessing postgres
- - - 
### access local postgres db

```bash
psql
```

### access remote postgres dbs

```bash
psql -h <hostname> -U <user> postgres
```
example
```bash
psql -h backendpg1-preprev.ciepqiqtkoex.eu-west-1.rds.amazonaws.com -U analysis postgres
```

### execute a sql query from the command line like a ninja
this would copy everything to the sys clipboard
```bash
psql -d <database name> -A --csv -c "SELECT * FROM <schema>.<table>" | pbcopy
```


### leave server
```bash
\q
```

### list databases
```bash
\l
```

### display all data metadata

```
\d+
-- for a specific table
\d+ <schema>.<table>
-- all tables
\d+ *.*
```
- - -
## admin
- - -
### uodate postgres locally

```bash
brew postgresql-upgrade-database
```


### manual setup correct roles and permissions for tvs

```sql
CREATE DATABASE postgres;
```

```sql 
CREATE EXTENSION hstore;
```

```sql
CREATE ROLE postgres
LOGIN 
PASSWORD <password>;
```

```sql
CREATE ROLE backend
LOGIN 
PASSWORD <password>;
```

```sql
CREATE ROLE analysis
LOGIN 
PASSWORD <password>
```

```sql
ALTER ROLE backend CREATEDB;
```

### turning logging on / off

[guide to logging](https://tableplus.io/blog/2018/10/how-to-show-queries-log-in-postgresql.html)

### dump database

```sql
pg_dump -s c1129_australiademo > /tmp/schema.sql
```
  
### dump schema

```sql
pg_dump -s c1129_australiademo -n usersessions > /tmp/usersessions.sql
```

### restore database

```sql
psql testdata < schema.sql
```

### creating indexes

```sql
ux_<index name>
  ON <schema>.<table>
  USING btree
  (hasheduserip COLLATE pg_catalog."default", datadatetime);
```

### Display all indexes for a schema

```sql
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
	schemaname = 'users'
ORDER BY
    tablename,
    indexname;
```

### foreign keys

```sql
ALTER TABLE adspotvalues.data 
    DROP CONSTRAINT fk_adspotvalues_data_adspotid
```

### transactions

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

### grant permissions and access

```sql
GRANT ALL ON TABLE <schema>.<table> TO <profile>;
GRANT SELECT ON TABLE <schema>.<table> TO <profile>;
```

### create a table

```sql
CREATE TABLE IF NOT EXISTS <schema. table> (
col1 col1type
col2 col2type
col3 col3type
)
```

### Copy a table struture with no data

```sql
SELECT INTO <new_table> 
(SELECT * FROM <old_table> 
WHERE 1 = 0 )
```

### copy data from db to disk

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

### copy data from csv to db

be aware there are issues between \copy and copy.
Also the delimiter stuff is an arse

```sql
\Copy <csv name> from <datalocation> CSV 
DELIMITER E'\t NULL'\\N'
```

A different way to do it that seems to work better is
```sql
# CREATE table first
CREATE TABLE schema.table (
    id serial NOT NULL,
    siteid TEXT,
    path TEXT,
    collector_name TEXT,
    volume TEXT,
    markeddeleted BOOL
)
# insert data
COPY collectorc(siteid, path, collector_name, volume, markeddeleted)
FROM '/tmp/collector_c_logs_complete' DELIMITER ',' CSV HEADER
```


- - -
## inserting / updating
- - -

### anti-sql injection techs

Use string formatting in params rather than in statement 

```python
params['interval'] = "{} days".format(5)
```

alternatively can use the AsIs module in psycopg2.extensions

```python
from psycopg2.extensions import AsIs
params['interval'] = AsIs(5)
# or some shit like that
```       



#### table of fake data

```sql
CREATE table foo (c1 integer, c2 text, c3 integer);
INSERT INTO foo (SELECT i, md5(random()::text), i/10
        FROM generate_series(1, 1000000) AS i);
```

### add a column


### basic update

updates current data

```sql
UPDATE  <schema>.<table>
SET datadatetime = datedatetime + INTERVAL "1 days"
```

### update where

conditional updates
```sql
UPDATE <schema.table> 
SET <column_name>
WHERE cond_1 = blrap
```

### update from

update with values provided in a list
```sql
UPDATE <schema.table>
SET  some_value = data.new
FROM (VALUES ("a", 2), ("b", 4)) as data (orig, new)
WHERE data.orig = col_name 
```

#### more complex updates

##### updating from values can provide a tmp table of values to use to update the table 

```sql
UPDATE usersessions.data us
        SET  tags = tags || hstore('cuserref' , data.userref)
        FROM (VALUES (1, 2),(2, 3), (3, 4))))) as data (usersessionid, userref)
        WHERE data.usersessionid = us.usersessionid
        AND us.brandid = %(brandid)s
        AND coalesce(us.tags -> 'cuserref','') <> data.userref
        AND datadatetime BETWEEN %(startdt)s AND %(enddt)s
```
here values create a tmp table called data that we can use!.

it is a more concise way than doing this which i tried also

```sql
with sessionsToUpdate as (
    SELECT usersessionid, tags->'userref' userref
            FROM usersessionactions.data usa
            WHERE usa.brandid=1
            AND usa.tags?'userref'
	 		AND usa.usersessionid in (29634, 29110, 26803, 28374)
)
UPDATE usersessions.data us
SET  tags = tags || hstore('cuserref' , q.userref)
FROM sessionstoupdate q
WHERE q.usersessionid = us.usersessionid
AND us.brandid=1
AND coalesce(us.tags -> 'cuserref','') <> q.userref
```






### basic insert

```sql
INSERT into <table> ( col1, col2, col3)
SELECT nextval('<table>_id_seq'), col2, (number + 5 ) as col3
FROM <table>
WHERE col1 = 3
```

### insert scratch

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
## querying
- - - 

### basics

#### operators

```sql
 <thing> <> 6
 -- not equal to
```

#### basic in clause

```sql
SELECT * FROM <blah> 
WHERE <col_derp> in ('thing1', 'thing2')
```

#### fuzzy string matching
```sql
SELECT * 
FROM adspots.data 
WHERE datadatetime BETWEEN '2017-08-02' AND '2017-08-03' 
AND tags::TEXT LIKE '%cost%'
```

#### querying ips

```sql
select *
from usersessions.data
where userip << '2001:0db8::/32'::cidr
limit 10
```

#### generate unixtimestamp from timestmap

```sql
SELECT EXTRACT(EPOCH FROM datadatetime) * 1000 FROM 
usersessions.data 
WHERE brandid = 1
AND usersessionid = 472809579
```

#### hashing ips

```sql
SELECT ENCODE(DIGEST('120.145.43.100', 'sha1'), 'hex')

SELECT ENCODE(DIGEST(userip::VARCHAR, 'sha1'), 'hex') FROM usersessions.data LIMIT 10;
SELECT userip::text, userip::inet, (SELECT ENCODE(DIGEST(host(userip), 'sha1'), 'hex')) as TEST FROM usersessions.data
LIMIT 4;
```
[encrypting shizzle](https://www.dbrnd.com/2016/03/postgresql-best-way-for-password-encryption-using-pgcryptos-cryptographic-functions/
)

```sql
COPY (SELECT ENCODE(DIGEST(userip::VARCHAR, 'sha1'), 'hex') 
FROM <schema>.<table> WHERE brandid=1) to '<filelocation>' with CSV;
create extension pgcrypto
```

#### pulling stuff out of tags/hstore

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


#### jsonb 

```sql
select
adspotid,
sessions->>'usersessionid' as sessionid,
cast(sessions->>'proportion' as float) as attribution
FROM adspots."data", jsonb_array_elements(advancedtvdata->'sessions') sessions
where 
brandid = 1
and tags->'datagroup' = '_advancedtv_vod'
and datadatetime between '2020-07-10' and '2020-08-01'
and sessions->>'action' = 'all response'
order by 1 desc
limit 10;
```

##### pulling stuff from top layer postgres json

```
SELECT bum,
jsonb(foo->>'bah') as scalefactor, 
datadatetime
FROM adspots.v_adspots
WHERE yo_mama is not null
ORDER BY 3
```


#### hstore scratch
 
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

### subqueries 

to use a subquery the subquery needs to return a single value for a where clause and 
can return a range for a where in clause

#### where in

```sql
UPDATE adspots."data" SET tags = tags || '"mediatype" => "Advanced Linear"'::hstore 
WHERE adspotid in (
	SELECT baseadspotid from adspots.data 
	WHERE tags->'mediatype' = 'Advanced Linear' and baseadspotid is not null
)
```




### joins

#### basic joins


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



### aggreate queries

#### case statements
case statements can be used to do conditional shizzle
```sql
SELECT deviceid,
        sum(CASE WHEN brand='Booking.com' THEN 1 ELSE 0 END) as Booking,
        sum(CASE WHEN brand='Expedia' THEN 1 ELSE 0 END) as Expedia_views
FROM alphonso_raw_impressions
GROUP BY deviceid;
```

#### agg stats with case statements

```sql
SELECT dd, count(*) total_server_track,
   sum(
       CASE
       WHEN visitor_id is null then 1 else 0
       END
     ) total_server_track_no_vis_id,
FROM "c6208_peloton_uk_prod"."userdata_collector_tng_pre_visit"
WHERE mm = '04'
AND server_track = true
GROUP BY 1
ORDER BY 1, 2
```

#### average tables

```sql
with day_count as(
    SELECT date_trunc('day', datadatetime),
    COUNT(*) as c FROM usersessions.data 
    WHERE brandid = 1 group by 1) select avg(c) from day_count
)
```

#### group by datetimes
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

#### filtering a count * with having

```sql
SELECT group, count(*)
FROM blah
WHERE blarpped
GROUP BY 1
HAVING count(*) > 2
ORDER BY 1
```

#### window functions

used for different types of aggregate statistics


#### generate a row count for a specific grouping

most basic type of window function.

```sql
SELECT 
	tags->'prog' prog,
	ROW_NUMBER () OVER (
		PARTITION BY tags->'prog' 
)
FROM adspots.data
WHERE brandid = 1
AND datadatetime BETWEEN '2020-03-01' AND '2020-03-02'
```

#### generate a rank by a another columns for a specific grouping

```sql
SELECT 
	tags->'prog' prog,
	audience,
	RANK () OVER (
		PARTITION BY tags->'prog' 
	ORDER BY audience DESC
)
FROM adspots.data
WHERE brandid = 1
AND datadatetime BETWEEN '2020-03-01' AND '2020-03-02'
```



### tricks and tips

#### aggregate query results where the dates with missing data have values filled in

```sql
with CTE as (
	SELECT t.day::date 
	FROM  generate_series(timestamp '2020-05-01', timestamp '2020-07-10', interval  '1 day') AS t(day)
),
	grouped_users as (
		SELECT date_trunc('day', datadatetime) as day, count(*) FROM usersessions.data
		GROUP BY 1
)
SELECT CTE.day, COALESCE(grouped_users.count, 0) FROM CTE
LEFT JOIN grouped_users ON CTE.day = grouped_users.day
```

#### check something exists v.fast
good for v.large datasets. Will exist as soon as it finds something. 
```sql
SELECT exists(SELECT 1 FROM <schema>.<table> WHERE <condition to check> LIMIT 1)
```

#### get the whole row that is distinct by the value provided
This is good if you want to examine whole rows that have the same datetime, userip etc
[good articles on distinct on](https://zaiste.net/postgresql_distinct_on/)
```sql
SELECT distinct on (<col_1>, <col_2>) *
FROM <schema>.<table>
WHERE <blah>
```

#### where 1=1

```sql
SELECT
  date(datadatetime),
--  DATE(datadatetime at time zone 'UTC' at time zone 'GMT') as impression_date_bst,
  agency,
  COUNT(*)
FROM
  c9058_k12_produsa.eventlog
WHERE 1=1
  AND yy = 2020 AND mm in (5,6,7)
  AND event_class = 'impression'
  AND event = 'vod'
GROUP BY 1,2
ORDER BY 1,2
```

used a syntactic sugar to make editing the query easier

#### super smart way of getting largest / smallest value by another column

```
SELECT DISTINCT ON (<col_1>) *
FROM <schema>.<table>
ORDER BY <col_2> -- This is the important part!!!!
```
This will de-dupe by col_1 but keep the first row from each distinct value
So if you sort by size DESC then the row displayed will have the largest value of col_2


### with temp tables

```sql
with temp as (
    SELECT * FROM <blah>
)
    temp2 as (
    SELECT * FROM somewhereelse.
) 
```

### window functions
window functions are similar to agg functions
agg functions reduce the number of rows 
window functions do not.


[guide to window functions](http://www.postgresqltutorial.com/postgresql-window-function/
)

### temp tables examples

```sql
WITH <tmp_table_name_1> 
     AS (SELECT Max(userid) 
         FROM   users.data 
                LEFT JOIN demographics.data 
                       ON users.data.cookiehash = demographics.data.sourceid 
         WHERE  sourceid IS NOT NULL), 
     <temp_table_2> 
     AS (SELECT Max(userid) 
         FROM   usersessions.data 
         WHERE  brandid = 1 
                AND datadatetime < '2018-02-24'), 

     <temp_table_3> 
     AS (SELECT Count(DISTINCT cookiehash) cookie 
         FROM   users.data 
         WHERE  userid BETWEEN (SELECT * 
                                FROM temp_table_2) AND ( 
                               SELECT * 
                               FROM 
                                       tmp_table_name_1) 
                AND cookiehash IS NOT NULL), 

     <temp_table_4> 
     AS (SELECT Count(DISTINCT sourceid) epsilon 
         FROM   demographics.data 
         WHERE  sourceid IS NOT NULL)
 
SELECT epsilon::float / temp_table_3::float 
FROM   cookiecount, 
       temp_table_4
```


### quick way to get row count

```sql
      SELECT 
        c.oid,nspname AS table_schema, 
        relname AS table_name,
         c.reltuples AS row_estimate
       FROM pg_class c
       LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
       WHERE relkind = 'r'
       and relname='data'
       and nspname='usersessions'
```


|Keywords | What it does |
|--------|---------------|
|ADD	| Adds a column in an existing table|
|ADD CONSTRAINT	| Adds a constraint after a table is already created|
|ALTER	| Adds, deletes, or modifies columns in a table, or changes the data type of a column in a table|
|ALTER COLUMN	|Changes the data type of a column in a table|
|ALTER TABLE	| Adds, deletes, or modifies columns in a table|
|ALL	| Returns true if all of the subquery values meet the condition|
|AND	| Only includes rows where both conditions is true|
|ANY	| Returns true if any of the subquery values meet the condition|
|AS	|Renames a column or table with an alias|
|ASC	| Sorts the result set in ascending order|
|BACKUP DATABASE	| Creates a back up of an existing database|
|BETWEEN	| Selects values within a given range|
|CASE	| Creates different outputs based on conditions|
|CHECK	| A constraint that limits the value that can be placed in a column|
|COLUMN	| Changes the data type of a column or deletes a column in a table|
|CONSTRAINT	| Adds or deletes a constraint|
|CREATE	| Creates a database, index, view, table, or procedure|
|CREATE DATABASE	| Creates  new SQL database|
|CREATE INDEX	| Creates an index on a table (allows duplicate values)|
|CREATE OR REPLACE VIEW	| Updates a view|
|CREATE TABLE	| Creates a new table in the database|
|CREATE PROCEDURE	| Creates a stored procedure|
|CREATE UNIQUE INDEX	| Creates a unique index on a table (no duplicate values)|
|CREATE VIEW	| Creates a view based on the result set of a SELECT statement|
|DATABASE	|Creates or deletes an SQL database|
|DEFAULT	|A constraint that provides a default value for a column|
|DELETE	|Deletes rows from a table|
|DESC	|Sorts the result set in descending order|
|DISTINCT	|Selects only distinct (different) values|
|DROP	|Deletes a column, constraint, database, index, table, or view|
|DROP COLUMN	|Deletes a column in a table|
|DROP CONSTRAINT	|Deletes a UNIQUE, PRIMARY KEY, FOREIGN KEY, or CHECK constraint|
|DROP DATABASE	|Deletes an existing SQL database|
|DROP DEFAULT	|Deletes a DEFAULT constraint|
|DROP INDEX	|Deletes an index in a table|
|DROP TABLE	|Deletes an existing table in the database|
|DROP VIEW	|Deletes a view|
|EXEC	|Executes a stored procedure|
|EXISTS	|Tests for the existence of any record in a subquery|
|FOREIGN KEY	|A constraint that is a key used to link two tables together|
|FROM	|Specifies which table to select or delete data from|
|FULL OUTER JOIN	|Returns all rows when there is a match in either left table or right table|
|GROUP BY	|Groups the result set (used with aggregate functions: COUNT, MAX, MIN, SUM, AVG)|
|HAVING	|Used instead of WHERE with aggregate functions|
|IN	|Allows you to specify multiple values in a WHERE clause|
|INDEX	|Creates or deletes an index in a table|
|INNER JOIN	|Returns rows that have matching values in both tables|
|INSERT INTO	|Inserts new rows in a table|
|INSERT INTO SELECT	|Copies data from one table into another table|
|IS NULL	|Tests for empty values|
|IS NOT NULL	|Tests for non-empty values|
|JOIN	Joins |tables|
|LEFT JOIN	|Returns all rows from the left table, and the matching rows from the right table|
|LIKE	|Searches for a specified pattern in a column|
|LIMIT	|Specifies the number of records to return in the result set|
|NOT	|Only includes rows where a condition is not true|
|NOT NULL	|A constraint that enforces a column to not accept NULL values|
|OR	|Includes rows where either condition is true|
|ORDER BY	|Sorts the result set in ascending or descending order|
|OUTER JOIN	|Returns all rows when there is a match in either left table or right table|
|PRIMARY KEY	|A constraint that uniquely identifies each record in a database table|
|PROCEDURE	|A stored procedure|
|RIGHT JOIN	|Returns all rows from the right table, and the matching rows from the left table|
|ROWNUM	|Specifies the number of records to return in the result set|
|SELECT	|Selects data from a database|
|SELECT DISTINCT	|Selects only distinct (different) values|
|SELECT INTO	|Copies data from one table into a new table|
|SELECT TOP	|Specifies the number of records to return in the result set|
|SET	|Specifies which columns and values that should be updated in a table|
|TABLE	|Creates a table, or adds, deletes, or modifies columns in a table, or deletes a table or data inside a table|
|TOP	|Specifies the number of records to return in the result set|
|TRUNCATE TABLE	|Deletes the data inside a table, but not the table itself|
|UNION	|Combines the result set of two or more SELECT statements (only distinct values)|
|UNION ALL	|Combines the result set of two or more SELECT statements (allows duplicate values)|
|UNIQUE	|A constraint that ensures that all values in a column are unique|
|UPDATE	|Updates existing rows in a table|
|VALUES	|Specifies the values of an INSERT INTO statement|
|VIEW	|Creates, updates, or deletes a view|
|WHERE	|Filters a result set to include only records that fulfill a specified conditiona|


## useful work queries

### cascade delete sessions 

```sql
with zapids as (
    SELECT D.usersessionid
    FROM usersessions.data D
    where D.brandid = 1
    and D.datadatetime >= '2020-12-20' 
), zap1 as (
    DELETE
    from attributedsessions.data d
    using zapids
    where d.usersessionid = zapids.usersessionid
    and D.brandid = 1
    and D.datadatetime >= '2020-12-20'
), zap2 as (
    DELETE
    from usersessionactions.data d
    using zapids
    where d.usersessionid = zapids.usersessionid
    and D.brandid = 1
    and D.datadatetime >= '2020-12-20'
)
DELETE
from usersessions.data d
    using zapids
    where d.usersessionid = zapids.usersessionid
    and D.brandid = 1
    and D.datadatetime >= '2020-12-20'
```

### cascade delete adspots

```sql
with
        recursive adsplots(adspotid,rootadspotid,level) as (
            select adspotid,adspotid,1
            from adspots.data
            where (baseadspotid=adspotid
            or baseadspotid is null)
            and adspotid>0 and modelid in (select modelid from adspots.model where model like 'directload/tvsdefault')  and brandid = 1  and datadatetime >= '2020-10-18T00:00:00'::timestamp and datadatetime < '2020-10-19T00:00:00.000001'::timestamp
        union all
            select d.adspotid, adsplots.rootadspotid, adsplots.level+1
            from adspots.data d
            join adsplots on d.baseadspotid=adsplots.adspotid
            and d.adspotid<>adsplots.adspotid
			and d.baseadspotid is not null
         and brandid = 1  ) , deleterange as (delete from adspotvalues.data d using adsplots
    where d.adspotid=adsplots.adspotid
    and d.brandid=1
    and d.datadatetime >= '2020-10-13T00:00:00'::timestamp   returning d.datadatetime )
    select min(datadatetime) mindatetime, max(datadatetime) maxdatetime
        from deleterange
```

### userschema bug query
```sql
WITH roothashes AS (
	SELECT rootuserid, count(*), array_agg(distinct cookiehash) cookiehashes
	FROM users.data 
	GROUP BY 1
)

SELECT usd.cookiehash, usd.usersessionid, usd.userid, rh.rootuserid, rh.cookiehashes, ARRAY_LENGTH(rh.cookiehashes, 1) ch_length  FROM usersessions.data usd
JOIN roothashes rh ON rh.rootuserid = usd.userid
WHERE brandid = 1 
AND datadatetime BETWEEN '2020-03-29'
AND '2020-03-30' 
AND usd.cookiehash <> all(rh.cookiehashes)
ORDER BY ch_length DESC

```

### scratch
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

