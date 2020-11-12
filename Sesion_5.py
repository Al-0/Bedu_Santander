import re
from pymongo import MongoClient

# Requires the PyMongo package.
# https://api.mongodb.com/python/current

client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')

### Reto # 1
# 1.1
filter={
    'house_rules': re.compile(r"no parties(?i)")
}

# 1.2
filter={
    'house_rules': re.compile(r"pet[s]* allowed(?i)")
}

# 1.3
filter={
    'house_rules': re.compile(r"no smok(?i)")
}

# 1.4
filter={
    '$and': [
        {
            'house_rules': re.compile(r"no parties(?i)")
        }, {
            'house_rules': re.compile(r"no smok(?i)")
        }
    ]
}

# result = client['sample_airbnb']['listingsAndReviews'].find(
#   filter=filter
# )

### Reto # 2
filter={
    'address.country': 'Brazil',
    'number_of_reviews': {
        '$gte': 50
    },
    'review_scores.review_scores_rating': {
        '$gte': 80
    },
    'amenities': {
        '$in': [
            re.compile(r"Ethernet")
        ]
    }
}

# result = client['sample_airbnb']['listingsAndReviews'].find(
#   filter=filter
# )
