from fastapi import FastAPI
from Routes.reg_route import router
from pymongo.mongo_client import MongoClient
from Routes.score_route import router2
from Routes.api_route import router3
from urllib.parse import quote_plus
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can restrict to specific domains
    allow_credentials=True,
    allow_methods=["*"],  # You can restrict methods
    allow_headers=["*"],  # You can restrict headers
)

app.include_router(router)
app.include_router(router2)
app.include_router(router3)
#


