import google.generativeai as genai
from fastapi import APIRouter, HTTPException
from Models.questions import Questions
from Config.database import collection_name2, collection_name4
from bson import ObjectId
from typing import Dict
import os

router3 = APIRouter()

# Set up the API key
genai.configure(api_key="AIzaSyCjqCt9kapmCqtlC7xcsMTneqVQ7sH-9vk")

# Model configuration
generation_config = {
    "temperature": 0.9,  # Increase temperature for more randomness
    "top_p": 0.95,  # Adjust top_p to allow more diverse outputs
    "top_k": 50,  # top_k can be tuned for more varied results
    "max_output_tokens": 200,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config
)

@router3.post("/question")
def post_question(question: Questions):
    collection_name2.insert_one(question.dict())
    return {"message": "Question added successfully"}

@router3.get("/questions")
def get_questions():
    questions = collection_name2.find_one({})
    if not questions:
        raise HTTPException(status_code=404, detail="No data found")
    questions["_id"] = str(questions["_id"])  # Convert ObjectId to string
    return questions


def generate_prompt(label: str, answer: str, score: int) -> str:
    return f"""
        Given the words "{label}" and "{answer}", and considering the user's performance score of {score}, generate a new list of rhyming words that follow a **completely unrelated rhyme scheme**.
        The user is of the age group 3-7
        Please assess the score and select an appropriate level of difficulty:
        - For a low score, generate simpler words with fewer letters that rhyme with a different sound than the original words.
        - For an average score, generate words with a similar number of letters, but with a completely unrelated rhyme pattern.
        - For a high score, generate more complex words with more letters, using a completely different rhyme scheme.

        Ensure that the new words differ not only in complexity but also in the rhyme pattern from the provided ones, and that the rhyme scheme is completely unrelated to the original.
        give response in format [new word1,new word2]
    """


@router3.post("/generation")
def generation(request: Dict):
    uid = request["uid"]
    if collection_name4.find_one({"uid":uid}):
        question = collection_name4.find_one({"uid": uid})
    else:
        question = collection_name2.find_one({})

    if not question:
        raise HTTPException(status_code=404, detail="Question not found")

    question_data = Questions.parse_obj(question)

    # Extract data
    label = question_data.audio_quiz.audio_game1.label
    answer = question_data.audio_quiz.audio_game1.answer
    score = 90 # You can replace this with the actual score from the user data

    prompt = generate_prompt(label, answer, score)

    chat_session = model.start_chat(history=[])
    response = chat_session.send_message(prompt)

    return {"response": response.text}

@router3.post("/question/{id}")
def generated_questions(details: Dict):
    # Add logic here
    print("hello world")
