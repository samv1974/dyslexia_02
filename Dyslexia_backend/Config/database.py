from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")

db = client.dylexia_db
collection_name = db["users_reg"]
collection_name2 = db["questions"]
collection_name3 = db["user_score"]
