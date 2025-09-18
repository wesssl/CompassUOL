from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb+srv://qa:xperience@cluster0.okwo5us.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['markdb']

@keyword('Remove User From Database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert User From Database')
def insert_user(name, email, password):
    doc = {
        'name': name,
        'email': email,
        'password': password
    }
    users = db['users']
    users.insert_one(doc)
    print('insert user {doc}')