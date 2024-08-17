from fastapi import FastAPI
from Routes.reg_route import router
from pymongo.mongo_client import MongoClient
from Routes.score_route import router2

app = FastAPI()
uri = "mongodb://localhost:27017"
client = MongoClient(uri)
app.include_router(router)
app.include_router(router2)

