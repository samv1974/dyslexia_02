from pydantic import BaseModel
from typing import Dict, Optional

class Scores(BaseModel):
    type1_score: int
    type2_score: int
    type3_score: int

class QuizScore(BaseModel):
    type: int
    score: Dict[str, Scores]


class UserScores(BaseModel):
    uid: str
    scores: Dict[str, QuizScore]
