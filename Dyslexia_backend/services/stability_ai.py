import os
import requests
from dotenv import load_dotenv
import uuid

# Load environment variables from .env file
load_dotenv()

API_KEY = os.getenv("STABILITY_API_KEY")

def generate_image(prompt):
    url = "https://api.stability.ai/v2beta/stable-image/generate/ultra"
    headers = {
        "authorization": f"Bearer {API_KEY}",
        "accept": "image/*"
    }
    data = {
        "prompt": prompt,
        "output_format": "webp"
    }
    files = {"none": ''}

    # Generate a unique file name using a UUID
    unique_id = uuid.uuid4()
    output_file = f"image_{unique_id}.webp"

    response = requests.post(url, headers=headers, data=data, files=files)

    if response.status_code == 200:
        with open(output_file, 'wb') as file:
            file.write(response.content)
        print(f"Image saved as {output_file}")
    else:
        raise Exception(str(response.json()))

# Add a block to run the function when the script is executed directly
if __name__ == "__main__":
    prompt = "man is dancing on tree with mowgli like dressup and snake swrapped in his neck"
    generate_image(prompt)
