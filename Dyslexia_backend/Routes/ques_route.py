import google.generativeai as genai
from fastapi import APIRouter, HTTPException
from Models.questions import Questions
from Config.database import collection_name2, collection_name4
from typing import Dict
from Routes.api_route import router3


@router3.get("/questions")
def get_questions(response: Dict):

    pass
