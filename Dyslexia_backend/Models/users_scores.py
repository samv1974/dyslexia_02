from pydantic import BaseModel

class Users_scores(BaseModel):
    uid:str
    quiz_type:str


