Title: mongoDB
- - - 
# mongoDB

## Useful docs ##
[mongo shell](https://docs.mongodb.com/manual/reference/mongo-shell/)
[more mongo shell](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/)
[methods_collection_ref](https://docs.mongodb.com/manual/reference/method/js-collection/)


## Maintainence and Manangment

### performance profiling etc

[tipson performance profiling](https://studio3t.com/knowledge-base/articles/mongodb-query-performance/)

### dealing with indexes

An index looks like this
brand_1_gran_1_group_1_metric_1_date_1_split_1_splitname_1_action_1
The query will go through the index sequentially until it can’t do anymore. Always specify the exact value not a range if possible. 


### setting up a raw db connection

```python
server_url =  mongodb://username:password@somewhere.mongolayer.com:10011/my_database
username = analysis
password = <password>
```

### fast server stuff

```python
for db in request.backenddb.mongo.list_databases():
    name = db.get('name')
    if name.startswith('bclient{}'.format(clienttorun)):
        clientdb = request.backenddb.mongo.get_database(db['name'])
        collections  set(clientdb.collections_names(include_system_colelctions=False))
        for collection in collections :
            <do something>
```

#### Deleting documents

```javascript
db.getCollection("jobqueue").deleteMany({'jobtype': 'INF.CRON', 'jobstatus': 'FAILED'}
```

#### Updating Docs

find and update multidocs
```javascript
db.getCollection("jobqueue").update(<query>, {'$set': {'fuck': 'shit'}}, multi=True)
```

#### sorting with pymongo
[sorting](https://stackoverflow.com/questions/8109122/how-to-sort-mongodb-with-pymongo)

## terminal mongo

```javascript
# Switching Mongo databases within a server
db = db.getSiblingDB(‘<database name>’)
# Querying specific collections
db.getCollection(<collection name>).find(<query>)
```

## Basic Queries

### Search for value where value is not equal to another value

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
#### distinct values

```javascript
db.demographics.distinct('<thing>')
```

#### count docs
```javascript
db.brands.find({}).count()
```

### conditional querying of sub-docs

example
```jvascript
db.brands.find({viscodeSettings: {$exists: true}}).
forEach(function(brand) {
if Object.keys(brand.viscodeSettings).length > 10 {
    print(brand._id)
}})
```


#### where field A > B

```javascript
db.getCollection("piwik1410-1.sessions").find({$expr: {$gt: ["$lasttime", "$time"]}}).sort({lasttime: 1})
```

#### all values between two dates

```python
q = { "datetime": { $gte: ISODate("2017-06-30"),  $lt: ISODate("2017-07-01")}}
```

#### check whether a array exists and its not empty

```
db.getCollection("brands").find({'first_actions': {$exists: true, $ne: []}, 'first_all_response': true}, {'clientshortid': 1, 'shortid': 1})
```

### mongo regexes

basic example
```javascript
{"channel": /^DISC/i}
```
where /<regex>/ is the regex
^ is start 
$ is end
i is case insensitive


#### search for a single field in multiple values

```python
q = {shortid: {$in: [282, 1229]}} 
```

## Aggregate Queries

### basic agg queries

```javascript
db.demographicmaps.aggregate(
    [
    { $project: {
            'segmentID':1,
            'segmentGroup': 1}
    },
    { 
      $group:
      { _id: "$segmentID", segmentGroupings: {$sum: 1}}
    },
    {
      $sort: {segmentGroupings: 1}         }
    
        ]
        )
```

maths on grouped by data

```javascript
DOING MATHS DATETIME MATHS:
GROUPING DATA BY DATE


db.getCollection("jobqueue").aggregate(

    // Pipeline
    [
        // Stage 1
        {
            $match: {
                'jobstatus': 'DONE',
                'jobtype': 'LOAD.SESSIONSPIWIK'
            }
        },

        // Stage 2
        {
            $project: {
              'jobduration': {'$divide': [{$subtract: ['$jobfinished', '$jobstarted']},   1000]},  (doing maths here)
              'jobfinished': "$jobfinished",
              'count': {$literal: 1.0}.            (adds a specific number to the job )
              }
        },

        // Stage 3
        {
            $group: {
                 _id:  {$dayOfYear: "$jobfinished"},      (can group by dayOfYear)
                       jobduration: {$sum: "$jobduration"},
                       count: {$sum: "$count"} 
            }
        },

    ]
);
```

#### collection lookups

If you want to join docs from multiple collections use a lookup
```javascript
// to mungo client and brand docs together
db.getCollection("clients").aggregate([
	{
	  $match: {'title': /booking/i}
	},
	{
	  $lookup:
	  {
	    from: "brands",
	   	localField: "shortid",
	   	foreignField: "clientshortid",
	   	as: "brandoc"
	   	}
	},
	{
		$unwind: "$brandoc"
	},
	{
	  $project: {"brandoc.clientshortid": 1,
	  			 "brandoc.country": 1}
	},
	]
	)
```

```
// Requires official MongoShell 3.6+
use bcustomers;
db.getCollection("brands").aggregate(
    [
        { 
            "$match" : {
                "collector_siteid" : {
                    "$in" : [
                        "1624-1", 
                        "5791-1", 
                        "5252-1", 
                        "5774-1", 
                    ]
                }
            }
        }, 
        { 
            "$lookup" : {
                "from" : "clients", 
                "localField" : "clientshortid", 
                "foreignField" : "shortid", 
                "as" : "clientdoc"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$clientdoc"
            }
        }, 
        { 
            "$project" : {
                "clientdoc.partnershortid" : 1.0, 
                "clientdoc.title" : 1.0, 
                "collector_siteid" : 1.0
            }
        }, 
        { 
            "$match" : {
                "clientdoc.partnershortid" : 372.0
            }
        }
    ], 
    { 
        "allowDiskUse" : false
    }
);

```
query to work out which site ids have everyone deleted.


```bash
use bcustomers;
db.getCollection("brands").aggregate(
    [
        { 
            "$match" : {
                "collector_siteid" : {
                    "$in" : [
                        "154-1", 
                    ]
                }
            }
        }, 
        { 
            "$group" : {
                "_id" : "$collector_siteid", 
                "count" : {
                    "$sum" : 1.0
                }, 
                "clientids" : {
                    "$addToSet" : "$clientshortid"
                }, 
                "all_enabled" : {
                    "$addToSet" : "$enable_collector_tng"
                },
                "count_enabled": {'$sum':
                        {"$cond": [{"$eq": ['$enable_collector_tng', true]}, 1, 0]}, 
                },
                "countries": {
                    "$addToSet" : "$country"
                }
            }
        },
        {
            "$sort": {
                "count": -1,
                "all_enabled": -1
            }
        }
    ], 
    { 
        "allowDiskUse" : false
    }
);
```

```javascript
db.getCollection("jobqueue").aggregate([
{
    $match: {"jobstatus": "FAILED"}
},
{
    $group: {"_id": "$jobtype",
             "failed": {
                 $sum: 1.0
             }           
    }
},
{
    $sort: {"failed": -1}
}
])
```

same query with additional datatimne maths
```javascript
/ Set the number of days you want to check /
var number_of_days_back = 10;
var days_in_ms = number_of_days_back  24  60  60  1000;
var today = Date.now();
var then = today - days_in_ms;
var then_str = new Date(then).toISOString();
print(then_str)

db.getCollection("jobqueue").aggregate([
{
    $match: {"jobstatus": "FAILED", 
               "jobstartat": {'$gt': ISODate(then_str)}
               }
},
{
    $group: {"_id": "$jobtype",
             "failed": {
                 $sum: 1.0
             }           
    }
},
{
    $sort: {"failed": -1}
}
])
```

beast agg query for spots in regression
pivot in sheets as normal

```
db.getCollection("ts").aggregate([
{
    $match: 
        {"date": {$gte: ISODate('2020-08-10'), $lt: ISODate('2020-08-30')},
         "group": "rtm",
         "gran": "broadcastday",
         } 
},
{
    $project: 
        {//"date": 1, 
         //"group": 1,
         "gran": 1,
         "action": 1,
         "medium": 1,
         "baseline": 1,
         "datestring":   {"$dateToString" : {format: "%Y-%m-%d",  date:"$date"}}, 
         "env": "preold", 
         "sumValues": {$multiply: [ {$sum: "$values"}, -1]}
          }         
},
{
    $sort: {"date": -1}
}
])
```



## bugs

#### data directory not found

fixed with 
```bash
mongodb --dbpath /usr/local/var/mongodbmongo
```



## accessing
- - -

