from pydantic import BaseModel
from typing import List, Optional

class AudioScore(BaseModel):
    audio_game1: List[int]
    audio_game2: List[int]
    audio_game3: List[int]

class VisualScore(BaseModel):
    visual_game1: List[int]
    visual_game2: List[int]
    visual_game3: List[int]

class MemoryScore(BaseModel):
    memory_game1: List[int]
    memory_game2: List[int]
    memory_game3: List[int]

class SpeedScore(BaseModel):
    speed_game1: List[int]
    speed_game2: List[int]
    speed_game3: List[int]

class LanguageScore(BaseModel):
    language_game1: List[int]
    language_game2: List[int]
    language_game3: List[int]

class UserScores(BaseModel):
    uid: str
    audio_quiz: Optional[AudioScore] = None
    visual_quiz: Optional[VisualScore] = None
    memory_quiz: Optional[MemoryScore] = None
    speed_quiz: Optional[SpeedScore] = None
    language_quiz: Optional[LanguageScore] = None
