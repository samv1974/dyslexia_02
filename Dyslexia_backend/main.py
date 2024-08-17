from fastapi import FastAPI
from Routes.reg_route import router
from pymongo.mongo_client import MongoClient
from Routes.score_route import router2
from urllib.parse import quote_plus

app = FastAPI()
username = quote_plus("krssn")
password = quote_plus("krssn@capstone")

# Construct the URI
uri = f"mongodb+srv://{username}:{password}@dyslexia.9bswy.mongodb.net/?retryWrites=true&w=majority&appName=Dyslexia"
client = MongoClient(uri)
app.include_router(router)
app.include_router(router2)

