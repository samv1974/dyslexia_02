from fastapi import APIRouter, HTTPException
from Models.users_scores import UserScores
from Models.users_reg import Users_reg
from Config.database import collection_name3, client  # Assuming you have a MongoClient in Config.database
from Schemas.schemas import List_serial
from bson import ObjectId
import re

router2 = APIRouter()

@router2.post("/post_scores")
def post_scores(score:UserScores):
    collection_name3.insert_one(score.dict())
    return {"message":"Score posted"}


