# RETO_5.3
from pymongo import MongoClient

client = MongoClient('mongodb+srv://bedu:1452@cluster0.6x4ut.mongodb.net/test?authSource=admin&replicaSet=atlas-12mrpb-shard-0&connectTimeoutMS=600000&socketTimeoutMS=6000000&readPreference=primary&appname=MongoDB%20Compass&ssl=true')
result = client['sample_airbnb']['listingsAndReviews'].aggregate([
    {
        '$match': {
            'amenities': {
                '$in': [
                    re.compile(r"Ethernet(?i)"), re.compile(r"Wifi(?i)")
                ]
            }
        }
    }, {
        '$count': 'id'
    }
])

# RETO 6.1
result = client['sample_airbnb']['listingsAndReviews'].aggregate([
    {
        '$match': {
            'property_type': 'House',
            'bedrooms': {
                '$gte': 1
            }
        }
    }, {
        '$addFields': {
            'costo_por_habitacion': {
                '$divide': [
                    '$price', '$bedrooms'
                ]
            }
        }
    }, {
        '$group': {
            '_id': '$address.country',
            'habitaciones': {
                '$sum': 1
            },
            'precio_total': {
                '$sum': '$costo_por_habitacion'
            }
        }
    }, {
        '$addFields': {
            'precio_promedio': {
                '$divide': [
                    '$precio_total', '$habitaciones'
                ]
            }
        }
    }, {
        '$project': {
            'id': 1,
            'precio_promedio': 1
        }
    }
])

# RETO 6.2
result = client['sample_mflix']['comments'].aggregate([
    {
        '$lookup': {
            'from': 'users',
            'localField': 'email',
            'foreignField': 'email',
            'as': 'datos_usuario'
        }
    }, {
        '$addFields': {
            'usuario': {
                '$arrayElemAt': [
                    '$datos_usuario', 0
                ]
            }
        }
    }, {
        '$addFields': {
            'password': '$usuario.password'
        }
    }, {
        '$project': {
            'name': 1,
            '_id': 0,
            'email': 1,
            'password': 1
        }
    }
])
