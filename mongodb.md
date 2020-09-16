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

#### **check whether a array exists and its not empty**

```
db.getCollection("brands").find({'first_actions': {$exists: true, $ne: []}, 'first_all_response': true}, {'clientshortid': 1, 'shortid': 1})
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

agg flags across brands
```javascript
db.getCollection("brands").aggregate(
    [
        { 
            "$match" : {
                "collector_siteid" : {
                    "$in" : [
                    "1008-1",
"1021-1",
"1022-1",
"1024-1",
"1035-1",
"1036-1",
"1037-1",
"1040-1",
"1043-1",
"1045-1",
"1046-1",
"1062-1",
"1063-1",
"1073-1",
"1091-1",
"1092-1",
"110-2",
"1102-1",
"1102-2",
"1109-1",
"1123-1",
"1136-1",
"1146-1",
"1156-1",
"1160-1",
"1244-1",
"1245-1",
"1248-1",
"1249-1",
"1255-1",
"1257-1",
"1279-1",
"1280-1",
"1319-1",
"1338-1",
"1345-1",
"1379-1",
"1380-1",
"1382-1",
"1383-1",
"139-1",
"1399-1",
"140-1",
"1402-1",
"1403-1",
"1438-1",
"1441-1",
"1453-1",
"1480-1",
"1498-1",
"1499-1",
"1504-1",
"1514-1",
"1551-1",
"1555-1",
"1573-1",
"1577-1",
"1584-1",
"1605-1",
"1614-1",
"1624-1",
"1645-1",
"1650-1",
"1661-1",
"1679-1",
"1681-1",
"1721-1",
"1729-1",
"1733-1",
"1738-1",
"1768-1",
"1776-1",
"1778-1",
"1791-1",
"181-2",
"181-7",
"1813-1",
"1815-1",
"1818-1",
"184-1",
"186-2",
"1876-1",
"199-1",
"2009-1",
"2030-1",
"2036-1",
"2049-1",
"207-1",
"2072-1",
"2087-1",
"2175-1",
"223-1",
"2246-1",
"226-1",
"2260-1",
"2288-1",
"2297-1",
"2302-1",
"2318-1",
"2319-1",
"2345-",
"2371-1",
"2375-1",
"2380-1",
"2382-1",
"2398-1",
"2404-1",
"2437-1",
"2438-1",
"247-1",
"2471-1",
"2472-1",
"249-1",
"2491-1",
"2574-1",
"2633-1",
"2665-1",
"268-1",
"268-2",
"269-1",
"270-1",
"27631836-1",
"277-1",
"278",
"27909063-1",
"2794-1",
"2807-1",
"2817-1",
"282-1",
"2846-1",
"2848-1",
"2884-1",
"29-120",
"29-121",
"291-1",
"2925-1",
"296-1",
"297-1",
"2973-1",
"3022-1",
"3151-1",
"3176-1",
"320-1",
"3206-1",
"3215-2",
"3215-89",
"323445555-3",
"3276-1",
"3282-1",
"3289-1",
"330-1",
"3317-1",
"3329-1",
"333-1",
"3330-1",
"335-4",
"3375-1",
"3397-1",
"340-1",
"3418-1",
"343-1",
"3451-1",
"3455-1",
"3460-1",
"3496-1",
"3517-1",
"3520-1",
"358-1",
"3630-1",
"3632-1",
"3731-1",
"3733-1",
"3761-1",
"3765-1",
"3783-1",
"3808-1",
"3821-1",
"3829-1",
"3850-1",
"3864-1",
"3880-1",
"3900-1",
"3961-1",
"4045-1",
"4047-1",
"405-1",
"4069-1",
"4080",
"4092-1",
"4113-1",
"4115-1",
"4134-1",
"4158-1",
"4270-1",
"4306-1",
"4402-1",
"4428-1",
"4436-1",
"4442-1",
"4482-1",
"45093627-1",
"4551-1",
"4568-1",
"457-1",
"4591-1",
"4608-1",
"4610-1",
"4612-1",
"4648-1",
"4649-1",
"4658-1",
"4684-1",
"4685-1",
"475-1",
"4806-1",
"481-1",
"4826-1",
"4872-1",
"491-1",
"4917-1",
"5027-1",
"5067-1",
"5069-1",
"511-1",
"5163-1",
"5168-1",
"5192-1",
"5201-1",
"5250-1",
"5254-1",
"5366-1",
"5385-1",
"5413-1",
"5414-1",
"5415-1",
"5419-1",
"5433-1",
"5437-1",
"5439-1",
"5444-1",
"5446-1",
"5459-1",
"546-1",
"5473-1",
"5528-1",
"558-1",
"5582-1",
"5608-1",
"5724-1",
"5754-1",
"5828-1",
"584-1",
"5849-1",
"587-1",
"588-1",
"5917-1",
"5923-1",
"5926-1",
"593-1",
"5935-1",
"594-1",
"5940-1",
"5967-1",
"5970-1",
"6049-1",
"6103-1",
"611-1",
"612-1",
"6142-1",
"6152-1",
"6203-1",
"6205-1",
"6213-1",
"6221-1",
"6222-1",
"6242-1",
"6295-1",
"6296-1",
"6306-1",
"6329-1",
"6362-1",
"6368-1",
"6381-1",
"6399-1",
"640-1",
"6400-1",
"6412-1",
"642-1",
"6421-1",
"6433-1",
"6441-1",
"6453-1",
"6459-1",
"6460-1",
"6465-1",
"6480-1",
"6483-1",
"6488-1",
"6495-1",
"6496-1",
"6497-1",
"6498-1",
"6507-1",
"6510-1",
"6513-1",
"6515-1",
"6527-1",
"6528-1",
"6529-1",
"6531-1",
"6533-1",
"6544-1",
"6548-1",
"6549-1",
"6555-1",
"6566-1",
"6579-1",
"6583-1",
"6590-1",
"6591-1",
"6592-1",
"6593-1",
"6594-1",
"6596-1",
"6604-1",
"661-1",
"6622-1",
"6623-1",
"6629-1",
"663-1",
"6633-1",
"6638-1",
"664-1",
"6642-1",
"6644-1",
"6655-1",
"6669-1",
"6675-1",
"6689-1",
"6690-1",
"6691-1",
"6714-1",
"6715-1",
"6716-1",
"6718-1",
"6722-1",
"6725-1",
"6726-1",
"6728-1",
"6729-1",
"6730-1",
"6738-1",
"6739-1",
"6741-1",
"6746-1",
"6747-1",
"6748-1",
"6749-1",
"6750-1",
"6751-1",
"6752-1",
"6765-1",
"6768-1",
"6771-1",
"6774-1",
"6777-1",
"6786-1",
"6792-1",
"6797-1",
"6798-1",
"6800-1",
"6807-1",
"6808-1",
"6809-1",
"6811-1",
"683-1",
"6836-1",
"6837-1",
"6838-1",
"6840-1",
"6847-1",
"6848-1",
"6850-1",
"6872-1",
"6875-1",
"6877-1",
"6889-1",
"6899-1",
"6900-1",
"6901-1",
"6902-1",
"6906-1",
"6921-1",
"6923-1",
"6925-1",
"6926-1",
"6933-1",
"6934-1",
"6939-1",
"6943-1",
"6944-1",
"6946-1",
"6959-1",
"6962-1",
"6963-1",
"6968-1",
"6976-1",
"6978-1",
"6980-1",
"6981-1",
"6984-1",
"6992-1",
"6997-1",
"7002-1",
"7003-1",
"7006-1",
"7007-1",
"7008-1",
"7010-1",
"7011-1",
"7012-1",
"7018-1",
"7021-1",
"7026-1",
"7035-1",
"7037-1",
"7038-1",
"7040-1",
"7042-1",
"7048-1",
"7050-1",
"7051-1",
"7057-1",
"7058-1",
"7064-1",
"7076-1",
"7081-1",
"7082-1",
"7083-1",
"7090-1",
"7094-1",
"7096-1",
"7098-1",
"7106-1",
"7116-1",
"7118-1",
"7119-1",
"7120-1",
"7121-1",
"7122-1",
"7123-1",
"7124-1",
"7125-1",
"7126-1",
"7127-1",
"7128-1",
"7129-1",
"7130-1",
"7132-1",
"7135-1",
"7136-1",
"7138-1",
"7157-1",
"7160-1",
"7178-1",
"7179-1",
"7186-1",
"7188-1",
"7189-1",
"7190-1",
"7193-1",
"7195-1",
"7196-1",
"7202-1",
"7206-1",
"7210-1",
"7223-1",
"7224-1",
"7225-1",
"7226-1",
"7228-1",
"7232-1",
"7234-1",
"7256-1",
"726-1",
"7264-1",
"7273-1",
"7274-1",
"7277-1",
"7280-1",
"7284-1",
"7286-1",
"7288-1",
"7301-1",
"7304-1",
"7310-1",
"7314-1",
"732-1",
"7322-1",
"7324-1",
"7329-1",
"7330-1",
"7333-1",
"7334-1",
"7337-1",
"736-2",
"736-3",
"7372-1",
"7374-1",
"7376-1",
"7380-1",
"7382-1",
"7384-1",
"7391-1",
"7392-1",
"7394-1",
"7395-1",
"7402-1",
"7412-1",
"7413-1",
"7415-1",
"7416-1",
"7417-1",
"7418-1",
"7420-1",
"7422-1",
"7424-1",
"7426-1",
"7428-1",
"7431-1",
"7432-1",
"7435-1",
"7438-1",
"7446-1",
"7448-1",
"7452-1",
"7463-1",
"7470-1",
"7479-1",
"7491-1",
"7494-1",
"7502-1",
"7504-1",
"7506-1",
"7509-1",
"7512-1",
"7516-1",
"7530-1",
"7532-1",
"7534-1",
"7535-1",
"7536-1",
"7540-1",
"7543-1",
"7545-1",
"7546-1",
"7555-1",
"7556-1",
"7560-1",
"7564-1",
"7565-1",
"7566-1",
"7569-1",
"7572-1",
"7573-1",
"7582-1",
"7584-1",
"7586-1",
"7591-1",
"7592-1",
"7593-1",
"7596-1",
"7604-1",
"7606-1",
"7609-1",
"7610-1",
"7613-1",
"7614-1",
"762-1",
"7628-1",
"7644-1",
"7655-1",
"7664-1",
"7668-1",
"7670-1",
"7671-1",
"7672-1",
"7674-1",
"7681-1",
"7684-1",
"7692-1",
"7695-1",
"7696-1",
"7698-1",
"7701-1",
"7708-1",
"7709-1",
"7716-1",
"7726-1",
"7728-1",
"7732-1",
"7736-1",
"7741-1",
"7742-1",
"7758-1",
"7762-1",
"7767-1",
"7770-1",
"7776-1",
"7777-1",
"7778-1",
"7782-1",
"7788-1",
"7789-1",
"7791-1",
"7808-1",
"7810-1",
"784-1",
"7852-1",
"786-1",
"7864-1",
"7866-1",
"7874-1",
"7885-1",
"7906-1",
"7908-1",
"7918-1",
"7926-1",
"7958-1",
"824-1",
"825-1",
"829-1",
"905-1",
"928-1",
"950-1",
"955-1",
"956-1",
"965-1",
"979-1",
"989-1",
"994-1",                    
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


## **bugs**

#### **data directory not found**

fixed with 
```bash
mongodb --dbpath /usr/local/var/mongodbmongo
```



## accessing
- - -

