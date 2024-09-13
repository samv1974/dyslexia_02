from typing import Dict, Optional
from pydantic import BaseModel

class AudioGame1(BaseModel):
    img: str
    label: str
    img2: str
    answer: str

class AudioGame(BaseModel):
    uid: str

class VisualGame(BaseModel):
    uid: str

class MemoryGame(BaseModel):
    uid: str

class SpeedGame(BaseModel):
    uid: str

class LanguageGame(BaseModel):
    uid: str

class AudioQuiz(BaseModel):
    audio_game1: AudioGame1
    audio_game2: AudioGame
    audio_game3: AudioGame

class VisualQuiz(BaseModel):
    visual_game1: VisualGame

class MemoryQuiz(BaseModel):
    memory_game1: MemoryGame

class SpeedQuiz(BaseModel):
    speed_game1: SpeedGame

class LanguageQuiz(BaseModel):
    language_game1: LanguageGame

class questions_generated(BaseModel):
    uid : str
    audio_quiz: AudioQuiz
    visual_quiz: VisualQuiz
    memory_quiz: MemoryQuiz
    speed_quiz: SpeedQuiz
    language_quiz: LanguageQuiz
