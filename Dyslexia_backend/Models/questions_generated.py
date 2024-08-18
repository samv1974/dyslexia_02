from pydantic import BaseModel

from typing import Dict
from pydantic import BaseModel

class AudioGame1(BaseModel):
    img: str
    label: str
    img2: str
    answer: str

class VisualGame(BaseModel):
    uid: int

class MemoryGame(BaseModel):
    uid: int

class SpeedGame(BaseModel):
    uid: int

class LanguageGame(BaseModel):
    uid: int

class AudioQuiz(BaseModel):
    audio_game1: Dict[str, AudioGame1]
    audio_game2: Dict[str, AudioGame1]  # Assuming AudioGame1 was intended here
    audio_game3: Dict[str, AudioGame1]  # Assuming AudioGame1 was intended here

class VisualQuiz(BaseModel):
    visual_game1: Dict[str, VisualGame]
    visual_game2: Dict[str, VisualGame]
    visual_game3: Dict[str, VisualGame]

class MemoryQuiz(BaseModel):
    memory_game1: Dict[str, MemoryGame]
    memory_game2: Dict[str, MemoryGame]
    memory_game3: Dict[str, MemoryGame]

class SpeedQuiz(BaseModel):
    speed_game1: Dict[str, SpeedGame]
    speed_game2: Dict[str, SpeedGame]
    speed_game3: Dict[str, SpeedGame]

class LanguageQuiz(BaseModel):
    language_game1: Dict[str, LanguageGame]
    language_game2: Dict[str, LanguageGame]
    language_game3: Dict[str, LanguageGame]

class Questions(BaseModel):
    uid : str
    audio_quiz: Dict[str, AudioQuiz]
    visual_quiz: Dict[str, VisualQuiz]
    memory_quiz: Dict[str, MemoryQuiz]
    speed_quiz: Dict[str, SpeedQuiz]
    language_quiz: Dict[str, LanguageQuiz]





