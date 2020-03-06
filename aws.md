Title: aws 
summary: All things aws
- - -

- - - 
# athena 
- - - 
Live query of data in s3 stored in the parquet format

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

#### **useful setup queries**

collector_tng specific. To generate an actions athena table.
```
CREATE EXTERNAL TABLE `actions_2`(
  `_id` string, 
  `k5` string, 
  `time` int, 
  `v5` map<string,string>, 
  `visit` string, 
  `visitor` string)
PARTITIONED BY ( 
  `yy` string, 
  `mm` string, 
  `dd` string, 
  `hh` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://tvsquared-userdata/collector-tng/915-1/actions'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1578648309')
```

visits
```
CREATE EXTERNAL TABLE `visits`(
  `_id` string, 
  `cfgid` string, 
  `ip` string, 
  `k5` string, 
  `time` int, 
  `ua` string, 
  `v5` map<string,string>, 
  `visitor` string, 
  `url` string, 
  `refurl` string)
PARTITIONED BY ( 
  `yy` string, 
  `mm` string, 
  `dd` string, 
  `hh` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://tvsquared-userdata/collector-tng/915-1/visits'
TBLPROPERTIES (
  'has_encrypted_data'='false', 
  'transient_lastDdlTime'='1578675852')
```

## Cross table joins

```
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

- - -
# EC2
- - -

[ec2 instance comparison tool](https://www.ec2instances.info/?filter=i3&cost_duration=monthly&selected=i3en.metal,i3en.large)
Controls all th deployment of all the remote servers that we have!.
Can get all the ip addresses for all servers here.
Useful for debugging frontedn code.
Get the ip address and log into the specific server.

#### **load balancers**
distribute traffic to the frontend collector nodes
can view some diagnostic info [here](
https://eu-west-1.console.aws.amazon.com/ec2/autoscaling/home?region=eu-west-1#AutoScalingGroups:id=collectorf-worker-blue-prod;filter=collectorf;view=monitoring)

- - - 
# route53
- - - 

dns director thing



dns shizzle

#### **check what collector a client is on**
Go to Hosted Zones. Search for client collector URL
i.e. collect-<clientid>

it should then tell you the collector under the value field 



- - - 
# S3
- - - 

flat file storage infrastructure

