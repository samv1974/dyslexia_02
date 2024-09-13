from pymongo import MongoClient
from urllib.parse import quote_plus

username = quote_plus("krssn")
password = quote_plus("krssn@capstone")

# Construct the URI
client = MongoClient(
    f"mongodb+srv://{username}:{password}@dyslexia.9bswy.mongodb.net/?retryWrites=true&w=majority&appName=Dyslexia",
    tls=True,  # Use tls instead of ssl
    tlsAllowInvalidCertificates=True  # Ignore invalid certificates
)

# Access the database and collections
db = client.dylexia_db
collection_name = db["users_reg"]
collection_name2 = db["questions"]
collection_name3 = db["user_score"]
collection_name4 = db["questions_generated"]

# Now you can perform operations on these collections
