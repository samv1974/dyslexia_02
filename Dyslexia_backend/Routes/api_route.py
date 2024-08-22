from fastapi import APIRouter, HTTPException
from Models.questions import Questions
from Config.database import collection_name2
from bson import ObjectId

router3 = APIRouter()


@router3.post("/question")
def post_question(question: Questions):
    collection_name2.insert_one(question.dict())
    return {"message": "Question added successfully"}


@router3.get("/questions")
def rhyming_generator():
    rhyme = collection_name2.find_one({})
    if not rhyme:
        raise HTTPException(status_code=404, detail="No data found")
    rhyme["_id"] = str(rhyme["_id"])
    return rhyme
