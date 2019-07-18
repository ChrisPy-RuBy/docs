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


# mongo
- - - 
## Useful docs ##
[mongo shell](https://docs.mongodb.com/manual/reference/mongo-shell/)i
[collection('dbs')](https://docs.mongodb.com/manual/reference/method/js-collection/)

## Querying ##



### accessing
- - -
