from pydantic import BaseModel
from typing import Dict, Union

class AudioScore(BaseModel):
    audio_game1: int
    audio_game2: int
    audio_game3: int

class VisualScore(BaseModel):
    visual_game1: int
    visual_game2: int
    visual_game3: int

class MemoryScore(BaseModel):
    memory_game1: int
    memory_game2: int
    memory_game3: int
    
class SpeedScore(BaseModel):
    speed_game1: int
    speed_game2: int
    speed_game3: int

class LanguageScore(BaseModel):
    language_game1: int
    language_game2: int
    language_game3: int

class QuizScore(BaseModel):
    type: int
    score: Union[AudioScore, VisualScore]

class UserScores(BaseModel):
    uid: str
    scores: Dict[str, QuizScore]
