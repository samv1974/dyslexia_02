from typing import Dict
from fastapi import APIRouter, HTTPException
from Config.database import collection_name3, client  # Assuming you have a MongoClient in Config.database
from bson import ObjectId

router2 = APIRouter()

@router2.post("/submit_score")
def submit_score(response: Dict):
    user_id = response.get("uid")
    scores = response.get("scores", {})

    if not user_id or not scores:
        raise HTTPException(status_code=400, detail="Invalid data")

    # Convert user_id to ObjectId if necessary (assuming it's a string in MongoDB)
    try:
        user_id = ObjectId(user_id)
    except Exception as e:
        raise HTTPException(status_code=400, detail="Invalid user ID format")

    # Find the user by ID
    user = collection_name3.find_one({"_id": user_id})
    
    if user:
        # User exists, update only new scores
        for quiz_type, quiz_data in scores.items():
            quiz_scores = quiz_data.get("score", {})
            
            # Get the current scores for this quiz type, if they exist
            current_scores = user.get("scores", {}).get(quiz_type, {}).get("score", {})

            # Prepare updated scores, retaining existing scores and adding new ones
            updated_scores = current_scores.copy()  # Copy existing scores
            updated_scores.update({game: score for game, score in quiz_scores.items() if game not in current_scores})

            # Update the user's document with the new scores
            collection_name3.update_one(
                {"_id": user_id},
                {"$set": {f"scores.{quiz_type}.score": updated_scores}}
            )
    else:
        # User does not exist, insert a new document
        default_scores = {
            quiz_type: {
                "type": quiz_data.get("type"),
                "score": {game: -1 for game in quiz_data.get("score", {}).keys()}
            }
            for quiz_type, quiz_data in scores.items()
        }
        
        # Combine with existing data if necessary (e.g., add uid)
        new_score_data = {
            "_id": user_id,
            "uid": user_id,  # Or any other unique identifier
            "scores": default_scores
        }
        
        # Insert the new document
        collection_name3.insert_one(new_score_data)

    return {"message": "Score submitted successfully"}
