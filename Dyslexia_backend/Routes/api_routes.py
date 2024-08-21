from fastapi import APIRouter, HTTPException
from Models.users_reg import Users_reg
from Config.database import collection_name, client  # Assuming you have a MongoClient in Config.database
from Schemas.schemas import List_serial
from bson import ObjectId
import re
import uuid



router3 = APIRouter()

genai.configure(api_key=os.environ.get("GEMINI_API_KEY"))

# Model configuration
generation_config = {
    "temperature": 0.7,
    "top_p": 0.9,
    "top_k": 50,
    "max_output_tokens": 200,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config,
)

# Dummy function to generate a prompt from an image
def generate_prompt_from_image(image: Image) -> str:
    # Placeholder for image processing and prompt generation logic
    return "Describe the scenery depicted in this image."

@app.post("/generate-prompt")
async def generate_prompt(image: UploadFile = File(...)):
    try:
        image_data = await image.read()
        image = Image.open(io.BytesIO(image_data))
    except Exception as e:
        raise HTTPException(status_code=400, detail="Invalid image file") from e

    # Generate a prompt based on the image
    prompt = generate_prompt_from_image(image)

    # Start a chat session with the generated prompt
    chat_session = model.start_chat(history=[])
    response = chat_session.send_message(prompt)

    return {
        "prompt": prompt,
        "response": response.text
    }

@router3.post("/generateWords")
async def generateWords(word1: str, word2: str):
    try:
        # Combine word1 and word2 into a single prompt
        prompt = f"{word1} and {word2} are in a unique scenario. Describe what happens next."

        # Start a chat session with the generated prompt
        chat_session = model.start_chat(history=[])
        response = chat_session.send_message(prompt)

        # Return the response from the Gemini API
        return {"prompt": prompt, "response": response.text}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))