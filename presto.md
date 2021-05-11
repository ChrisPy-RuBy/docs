title: presto
summary: Doing stuff in presto
- - - 

# presto

## admin

### creating a table from a non-standard csv with no-header

uses OpenCSVSerde
change SERDEPROPERTIES 
skip header line in Table props
```
CREATE EXTERNAL TABLE `outcomes_visits_file_cw_1`(
  `userref` string COMMENT 'from deserializer', 
  `datetime` string COMMENT 'from deserializer', 
  `postcode` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'escapeChar'='\\', 
  'separatorChar'='|') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://tvsquared-modeldata-backend-ds/experian/outcomes_visits_file'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1617277978',
  'skip.header.line.count'='1')
```

### creating a new atable from another table

```sql
CREATE TABLE test_crosswalk_2
with (
  format = 'PARQUET',  
  external_location = 's3://tvsquared-athena-ds/testcrosswalk_2/', 
  partitioned_by = ARRAY['vendor_name', 
                         'key_name', 
                         'yy', 
                         'mm', 
                         'dd']
  )
as SELECT cw.key_value, cw.excluded_stamp, cw.excluded_reason, cw.complex_range, obf.vendor_name, cw.key_name, cw.yy, cw.mm, cw.dd
   FROM "crosswalk_ds"."crosswalk" cw
   JOIN experian.outcomes_basefile_for_filtering obf ON obf.outcomes_experianid = cw.key_value
   WHERE cw.vendor_name = 'historicinscape'
   AND cw.key_name = 'experian_hh_id'
```


### alter partitions

```sql
ALTER TABLE raw_collector_logs_eu_west_1 ADD 
    PARTITION (collector='collectori-prod', year='2021', month='05', day='04') 
    location "s3://DERP"
```



## querying 



### DATE_PARSE

minute is %i not %M you wazzock
```sql
DATE_PARSE(datetime, '%Y-%m-%dT%H:%i:%S')
```


### regex shizzle

#### generate keys from strings

```
with spot_keys as (
  SELECT distinct(spot_key)
  FROM db.table
  WHERE event_class = 'impression'
  AND event = 'linear'
), argh as (
SELECT regexp_extract_all(spot_key, '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})_(\d+)_(\d+)_(\d+)_(\d+)', 1)[1] as timestamp,
       regexp_extract_all(spot_key, '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})_(\d+)_(\d+)_(\d+)_(\d+)', 2)[1] as modelid,
       regexp_extract_all(spot_key, '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})_(\d+)_(\d+)_(\d+)_(\d+)', 3)[1] as channelid,
       regexp_extract_all(spot_key, '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})_(\d+)_(\d+)_(\d+)_(\d+)', 4)[1] as regionid
FROM spot_keys
) 
SELECT regionid, count(*)
FROM argh
GROUP BY 1
ORDER BY 2 DESC
"""
```

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

### partitions

#### date partitions to a time stamp

```
DATE_PARSE(CONCAT(CAST(yy as VARCHAR), '-', CAST(mm as VARCHAR), '-', CAST(dd as VARCHAR)), '%Y-%c-%d') FROM crosswalk_ds.crosswalk
```

#### querying using the partition structure

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

### case statements and regex

```sql
SELECT count(*) total,
    sum(CASE WHEN regexp_like(visitor, '^0{8}[0-9a-f]{16}$') = false THEN 1 
    ELSE 0 END) app, 
    sum(CASE WHEN regexp_like(visitor, '^0{8}[0-9a-f]{16}$') = true THEN 1 
    ELSE 0 END) web 
FROM c1564_hulu_prod.visits_2020_08_08_16
```

### Cross table joins

```sql
SELECT vis.refurl, count(*)   
   FROM "c3390_carriage_ae_bh_kw_qa_sa_prod"."actions" as acts
LEFT JOIN ( SELECT * 
           FROM "c3390_carriage_ae_bh_kw_qa_sa_prod"."visits") 
           as vis
ON acts.visit = vis._id
WHERE acts.yy = '2020'
   AND acts.mm = '03'
   AND acts.dd = '02'
   AND acts.v5['medium'] is null
   AND acts.k5 = 'order' 
GROUP BY 1
ORDER BY 2
```

### grabbing stuff out of nested json


```sql
SELECT dd,   json_extract_scalar(visit_vars, '$.5[0]'), sum(cast(json_extract_scalar(json_extract_scalar(visit_vars, '$.5[1]'), '$.rev') as real))
FROM "c1594_godaddy_usa_prod"."userdata_collector_tng_pre_visit" 
where visit_vars is not null
and yy = '2020'
and mm = '05'
and dd in ('05','12')
and length(json_extract_scalar(json_extract_scalar(visit_vars, '$.5[1]'), '$.rev'))>0
```


### dealing with maptypes

```sql
SELECT count(*) FROM "c4648_doordash_ca_prod"."visits"
WHERE mm  = '06'
AND dd = '19'
AND v5['medium'] = 'app'
AND refurl is not null
```

### timestamp conversion 

```sql
SELECT date_format(from_unixtime(timestamp/1000),'%Y-%m-%dT%H:%i:%sZ') FROM "c1567_talkspace_1_prod"."userdata_collector_tng_pre_visit"
WHERE mm = '05'
LIMIT 5;
```

### casting with shitty things i.e.mixed types etc

```
SELECT mm, dd, sum(try_cast(v5['rev'] as real)) FROM "c3747_golo_1_prod"."actions"
WHERE v5['rev'] is not null 
AND mm in  ('08', '07')
GROUP BY 1, 2
ORDER BY 1, 2
```

