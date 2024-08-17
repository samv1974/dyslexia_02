from fastapi import APIRouter, HTTPException
from Models.users_reg import Users_reg
from Config.database import collection_name, client  # Assuming you have a MongoClient in Config.database
from Schemas.schemas import List_serial
from bson import ObjectId
import re
import uuid

router = APIRouter()


# GET
@router.get("/regs")
async def get_regs():
    users = List_serial(collection_name.find())
    return users


email_regex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
password_regex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'


@router.post("/register")
async def post_user(user: Users_reg):
    if not re.match(email_regex, user.email):
        raise HTTPException(status_code=400, detail="Invalid email format.")

    if not re.match(password_regex, user.password):
        raise HTTPException(status_code=400,
                            detail="Password does not meet complexity requirements. It must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special symbol.")

    if user.password != user.confirm_pass:
        raise HTTPException(status_code=400, detail="Passwords do not match.")
    
    # Generate a unique UID
    uid = str(uuid.uuid4())

    # Construct user data with uid as the first field
    user_data = {
        "uid": uid,
        "username":user.username,
        "email": user.email,
        "password": user.password,
        "confirm_pass": user.confirm_pass
        
    }

    # Insert the user data with the UID into the collection
    collection_name.insert_one(user_data)
    
    return {"message": "User successfully registered!", "uid": uid}


@router.post("/login")
async def login_user(user_data: dict):
    # Extract email or username from the provided data
    user = user_data.get("username")
    password = user_data.get("password")

    if not password:
        raise HTTPException(status_code=400, detail="Password is required.")

    db_user = collection_name.find_one({"email": user}) or collection_name.find_one({"username": user})

    if db_user and db_user["password"] == password:
        user_id = db_user["uid"]
        user_collection_name = f"question_{user_id}"

        if user_collection_name not in client.dylexia_db.list_collection_names():
            user_collection = client.dylexia_db[user_collection_name]
            user_collection.insert_one({"message": "This is your personal collection"})

        return {"message": "Login successful!", "user_id": user_id}
    else:
        raise HTTPException(status_code=400, detail="Invalid email or password.")




