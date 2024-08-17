from pydantic import BaseModel

class Users_reg(BaseModel):
    uid: str
    username: str
    email: str
    password: str
    confirm_pass: str

