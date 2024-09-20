from typing import Dict
from fastapi import APIRouter, HTTPException
from pymongo import UpdateOne
from pymongo.errors import WriteError
from Config.database import collection_name3
from Models.users_scores import UserScores

router2 = APIRouter()

@router2.post("/post_score")
def post_score(score: UserScores):
    collection_name3.insert_one(score.dict())


# This is the function that handles score submission and appending scores in the array
@router2.post("/submit_score")
def submit_score(response: Dict):
    # Find the existing score for the given uid
    existing_score = collection_name3.find_one({"uid": response["uid"]})

    if existing_score:
        update_fields = {}
        push_fields = {}

        # Handle audio quiz
        if response["type"] == "audio":
            if not isinstance(existing_score.get("audio_quiz", {}).get("audio_game1"), list):
                update_fields["audio_quiz.audio_game1"] = []
            if not isinstance(existing_score.get("audio_quiz", {}).get("audio_game2"), list):
                update_fields["audio_quiz.audio_game2"] = []
            if not isinstance(existing_score.get("audio_quiz", {}).get("audio_game3"), list):
                update_fields["audio_quiz.audio_game3"] = []

            push_fields = {
                "audio_quiz.audio_game1": response["audio_quiz"]["audio_game1"],
                "audio_quiz.audio_game2": response["audio_quiz"]["audio_game2"],
                "audio_quiz.audio_game3": response["audio_quiz"]["audio_game3"]
            }

        # Handle visual quiz
        elif response["type"] == "visual":
            if not isinstance(existing_score.get("visual_quiz", {}).get("visual_game1"), list):
                update_fields["visual_quiz.visual_game1"] = []
            if not isinstance(existing_score.get("visual_quiz", {}).get("visual_game2"), list):
                update_fields["visual_quiz.visual_game2"] = []
            if not isinstance(existing_score.get("visual_quiz", {}).get("visual_game3"), list):
                update_fields["visual_quiz.visual_game3"] = []

            push_fields = {
                "visual_quiz.visual_game1": response["visual_quiz"]["visual_game1"],
                "visual_quiz.visual_game2": response["visual_quiz"]["visual_game2"],
                "visual_quiz.visual_game3": response["visual_quiz"]["visual_game3"]
            }

        # Handle memory quiz
        elif response["type"] == "memory":
            if not isinstance(existing_score.get("memory_quiz", {}).get("memory_game1"), list):
                update_fields["memory_quiz.memory_game1"] = []
            if not isinstance(existing_score.get("memory_quiz", {}).get("memory_game2"), list):
                update_fields["memory_quiz.memory_game2"] = []
            if not isinstance(existing_score.get("memory_quiz", {}).get("memory_game3"), list):
                update_fields["memory_quiz.memory_game3"] = []

            push_fields = {
                "memory_quiz.memory_game1": response["memory_quiz"]["memory_game1"],
                "memory_quiz.memory_game2": response["memory_quiz"]["memory_game2"],
                "memory_quiz.memory_game3": response["memory_quiz"]["memory_game3"]
            }

        # Handle speed quiz
        elif response["type"] == "speed":
            if not isinstance(existing_score.get("speed_quiz", {}).get("speed_game1"), list):
                update_fields["speed_quiz.speed_game1"] = []
            if not isinstance(existing_score.get("speed_quiz", {}).get("speed_game2"), list):
                update_fields["speed_quiz.speed_game2"] = []
            if not isinstance(existing_score.get("speed_quiz", {}).get("speed_game3"), list):
                update_fields["speed_quiz.speed_game3"] = []

            push_fields = {
                "speed_quiz.speed_game1": response["speed_quiz"]["speed_game1"],
                "speed_quiz.speed_game2": response["speed_quiz"]["speed_game2"],
                "speed_quiz.speed_game3": response["speed_quiz"]["speed_game3"]
            }

        # Handle language quiz
        elif response["type"] == "language":
            if not isinstance(existing_score.get("language_quiz", {}).get("language_game1"), list):
                update_fields["language_quiz.language_game1"] = []
            if not isinstance(existing_score.get("language_quiz", {}).get("language_game2"), list):
                update_fields["language_quiz.language_game2"] = []
            if not isinstance(existing_score.get("language_quiz", {}).get("language_game3"), list):
                update_fields["language_quiz.language_game3"] = []

            push_fields = {
                "language_quiz.language_game1": response["language_quiz"]["language_game1"],
                "language_quiz.language_game2": response["language_quiz"]["language_game2"],
                "language_quiz.language_game3": response["language_quiz"]["language_game3"]
            }

        # Perform both $set and $push in the same update
        if update_fields or push_fields:
            try:
                collection_name3.update_one(
                    {"uid": response["uid"]},
                    {
                        "$set": update_fields,
                        "$push": push_fields
                    }
                )
            except WriteError as e:
                raise HTTPException(status_code=500, detail=f"MongoDB WriteError: {e}")

    else:
        # Insert new document if no document exists for the uid
        response_data = response.copy()

        # Ensure the arrays are initialized properly for the first insert
        if response["type"] == "audio":
            response_data["audio_quiz"]["audio_game1"] = [response["audio_quiz"]["audio_game1"]]
            response_data["audio_quiz"]["audio_game2"] = [response["audio_quiz"]["audio_game2"]]
            response_data["audio_quiz"]["audio_game3"] = [response["audio_quiz"]["audio_game3"]]
        elif response["type"] == "visual":
            response_data["visual_quiz"]["visual_game1"] = [response["visual_quiz"]["visual_game1"]]
            response_data["visual_quiz"]["visual_game2"] = [response["visual_quiz"]["visual_game2"]]
            response_data["visual_quiz"]["visual_game3"] = [response["visual_quiz"]["visual_game3"]]
        elif response["type"] == "memory":
            response_data["memory_quiz"]["memory_game1"] = [response["memory_quiz"]["memory_game1"]]
            response_data["memory_quiz"]["memory_game2"] = [response["memory_quiz"]["memory_game2"]]
            response_data["memory_quiz"]["memory_game3"] = [response["memory_quiz"]["memory_game3"]]
        elif response["type"] == "speed":
            response_data["speed_quiz"]["speed_game1"] = [response["speed_quiz"]["speed_game1"]]
            response_data["speed_quiz"]["speed_game2"] = [response["speed_quiz"]["speed_game2"]]
            response_data["speed_quiz"]["speed_game3"] = [response["speed_quiz"]["speed_game3"]]
        elif response["type"] == "language":
            response_data["language_quiz"]["language_game1"] = [response["language_quiz"]["language_game1"]]
            response_data["language_quiz"]["language_game2"] = [response["language_quiz"]["language_game2"]]
            response_data["language_quiz"]["language_game3"] = [response["language_quiz"]["language_game3"]]

        collection_name3.insert_one(response_data)

@router2.get("/get_score")
def get_score(uid: str):
    # Retrieve the score for the given uid
    score = collection_name3.find_one({"uid": uid})
    if score:
        return score
    else:
        raise HTTPException(status_code=404, detail="Score not found")