### Reto #1

# 1:
from pymongo import MongoClient

# Requires the PyMongo package.
# https://api.mongodb.com/python/current

client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={}
project={
    'date': 1,
    'name': 1,
    'text': 1,
    '_id': 0
}

result = client['sample_mflix']['comments'].find(
  filter=filter,
  projection=project
)

#2:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={}
project={
    'title': 1,
    'cast': 1,
    'year': 1,
    '_id': 0
}

result = client['sample_mflix']['movies'].find(
  filter=filter,
  projection=project
)

#3:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={}
project={
    'name': 1,
    'password': 1,
    '_id': 0
}

result = client['sample_mflix']['users'].find(
  filter=filter,
  projection=project
)

### Reto #2
#1:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={
    'name': 'Greg Powell'
}

result = client['sample_mflix']['comments'].find(
  filter=filter
)

#2:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={
    '$or': [
        {
            'name': 'Greg Powell'
        }, {
            'name': 'Mercedes Tyler'
        }
    ]
}

result = client['sample_mflix']['comments'].find(
  filter=filter
)

#3:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={}
project={
    'num_mflix_comments': 1,
    'title': 1
}
sort=list({
    'num_mflix_comments': -1
}.items())
limit=1

result = client['sample_mflix']['movies'].find(
  filter=filter,
  projection=project,
  sort=sort,
  limit=limit
)

#4:
client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
filter={}
project={
    'title': 1
}
sort=list({
    'num_mflix_comments': -1
}.items())
limit=5

result = client['sample_mflix']['movies'].find(
  filter=filter,
  projection=project,
  sort=sort,
  limit=limit
)
