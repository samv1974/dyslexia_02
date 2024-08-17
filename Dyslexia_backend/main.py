from fastapi import FastAPI
from Routes.route import router
from pymongo.mongo_client import MongoClient

app = FastAPI()
uri = "mongodb://localhost:27017"
client = MongoClient(uri)
app.include_router(router)

