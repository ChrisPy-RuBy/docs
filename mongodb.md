Title: mongoDB
- - - 

## Useful docs ##
[mongo shell](https://docs.mongodb.com/manual/reference/mongo-shell/)
[more mongo shell](https://docs.mongodb.com/manual/tutorial/write-scripts-for-the-mongo-shell/)
[methods_collection_ref](https://docs.mongodb.com/manual/reference/method/js-collection/)


# **Maintainence and Manangment**

#### **performance profiling etc**

[tipson performance profiling](https://studio3t.com/knowledge-base/articles/mongodb-query-performance/)

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

## **terminal mongo**

```javascript
# Switching Mongo databases within a server
db = db.getSiblingDB(‘<database name>’)
# Querying specific collections
db.getCollection(<collection name>).find(<query>)
```

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

#### **basic agg queries**

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

#### **collection lookups**

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
                        "634-1", 
                        "543-1", 
                        "5029-1", 
                        "156-1", 
                        "160-1", 
                        "214-1"
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
            "$match" : {
                "clientdoc.deleted" : false
            }
        }, 
        { 
            "$project" : {
                "clientdoc.shortid" : 1.0, 
                "clientdoc.partnershortid" : 1.0, 
                "collector_siteid" : 1.0
            }
        }
    ], 
    { 
        "allowDiskUse" : false
    }
);

```

counting docs with agg query
```javascript
use bcustomers;
db.getCollection("brands").aggregate(
    [
        { 
            "$match" : {
                "collector_siteid" : {
                    "$in" : [
                        "4805-1", 
                        "3765-1", 
                        "5394-1", 
                        "5607-1", 
                        "2807-1", 
                        "915-1", 
                        "3765-1", 
                        "5528-1", 
                        "3270-1", 
                        "5445-1", 
                        "4470-1", 
                        "4442-1", 
                        "4610-1", 
                        "6151-1", 
                        "6165-1", 
                        "6166-1", 
                        "6171-1", 
                        "6174-1", 
                        "6192-1", 
                        "6199-1", 
                        "6206-1", 
                        "6207-1", 
                        "6210-1", 
                        "6211-1", 
                        "6214-1", 
                        "6217-1", 
                        "6220-1", 
                        "6224-1", 
                        "6225-1", 
                        "6228-1", 
                        "6237-1", 
                        "6238-1", 
                        "6240-1", 
                        "6248-1", 
                        "6249-1", 
                        "6253-1", 
                        "6254-1", 
                        "6255-1", 
                        "6258-1", 
                        "6267-1", 
                        "6273-1", 
                        "6276-1", 
                        "6277-1", 
                        "6278-1", 
                        "6279-1", 
                        "6281-1", 
                        "6283-1", 
                        "6282-1", 
                        "6280-1", 
                        "6286-1", 
                        "6288-1", 
                        "6289-1", 
                        "6293-1", 
                        "6303-1", 
                        "6313-1", 
                        "6320-1", 
                        "6323-1", 
                        "6328-1", 
                        "6330-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6258-1", 
                        "6346-1", 
                        "6348-1", 
                        "6349-1", 
                        "6350-1", 
                        "6352-1", 
                        "6353-1", 
                        "6354-1", 
                        "6355-1", 
                        "6356-1", 
                        "6357-1", 
                        "6358-1", 
                        "6364-1", 
                        "6372-1", 
                        "6374-1", 
                        "6375-1", 
                        "6398-1", 
                        "6417-1", 
                        "6420-1", 
                        "6431-1", 
                        "6450-1", 
                        "6469-1"
                    ]
                }
            }
        }, 
        { 
            "$group" : {
                "_id" : "$collector_siteid", 
                "count" : {
                    "$sum" : 1.0
                }
            }
        }
    ], 
    { 
        "allowDiskUse" : false
    }
);
```


```

## **bugs**

#### **data directory not found**

fixed with 
```bash
mongodb --dbpath /usr/local/var/mongodbmongo
```



## accessing
- - -

