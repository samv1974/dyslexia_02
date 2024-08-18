from fastapi import APIRouter, HTTPException
from Models.users_reg import Users_reg
from Config.database import collection_name, client  # Assuming you have a MongoClient in Config.database
from Schemas.schemas import List_serial
from bson import ObjectId
import re
import uuid

router3 = APIRouter()