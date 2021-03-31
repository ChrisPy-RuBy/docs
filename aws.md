Title: aws 
summary: All things aws
- - -

# aws

## athena
Live query of data in s3 stored in the parquet format

examples of doing stuff in athena programatically in
tvsquared/model.advancedtv L565 etc.

### Table management

#### useful setup queries

load data elblog partition
```sql
ALTER TABLE raw_collector_logs_eu_west1 ADD 
    PARTITION (collector='collectorf-prod', year='2020', month='06', day='14') 
    location "s3://tvsquared-elblogs-collector-eu-west-1/collectorf-prod/AWSLogs/457063536638/elasticloadbalancing/eu-west-1/2020/06/14/"
```

collector_tng specific. To generate an actions athena table.
```sql
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
```sql
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

### Querying

goto presto.md for the details

- - -
## EC2
- - -

[ec2 instance comparison tool](https://www.ec2instances.info/?filter=i3&cost_duration=monthly&selected=i3en.metal,i3en.large)
Controls all the deployment of all the remote servers that we have!.
Can get all the ip addresses for all servers here.
Useful for debugging frontend code.
Get the ip address and log into the specific server.

#### **load balancers**
distribute traffic to the frontend collector nodes
can view some diagnostic info [here](
https://eu-west-1.console.aws.amazon.com/ec2/autoscaling/home?region=eu-west-1#AutoScalingGroups:id=collectorf-worker-blue-prod;filter=collectorf;view=monitoring)

- - - 
## ROUTE53
- - - 

dns director thing

dns shizzle

### check what collector a client is on**
Go to Hosted Zones. Search for client collector URL
i.e. collect-<clientid>

it should then tell you the collector under the value field 


- - - 
## lambdas
- - - 

### basics 

getting lambdas to work!

- step 1 write a script that does the thing you want locally
	- try to keep dependancies low
	- lambdas typically take in json and spit out json

- decide how you want your lambda to be triggered. lots of things can set them off. 
Here is an example of one that is kicked off in the frontend code
where the lambda being run is the 'visitlog'
The event is the {}
A logger is also passed here.
```python
result = awslambda.run('visitlog', {'site_id': site_id, 's3_bucket': s3_bucket}, log=request.log)
```

- give the script to an adult to upload and configure in AWS.

- - - 
## S3
- - - 

flat file storage infrastructure

