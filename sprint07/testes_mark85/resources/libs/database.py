from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb+srv://qa:xperience@cluster0.okwo5us.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['markdb']

@keyword('Remove User From Database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)