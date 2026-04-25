from typing import Optional

from pydantic import BaseModel


class UserCreate(BaseModel):
    name: str
    email: Optional[str] = None

class UserResponse(BaseModel):
    id: int
    name: str
    email: Optional[str] = None

    class Config:
        from_attributes = True