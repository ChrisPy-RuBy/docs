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

