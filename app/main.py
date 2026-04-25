from fastapi import Depends, FastAPI
from sqlalchemy.orm import Session

import crud
from database import get_db
from schemas import UserCreate, UserResponse

app = FastAPI()



@app.get("/")
def read_root():
    return {"message": "FastAPI is running"}


@app.get("/db-check")
def db_check(db: Session = Depends(get_db)):
    db.execute(text("SELECT 1"))
    return {"db_status": "connected"}


@app.post("/users", response_model=UserResponse)
def api_create_user(user: UserCreate, db: Session = Depends(get_db)):
    return crud.create_user(db, user)


@app.get("/users", response_model=list[UserResponse])
def api_get_users(db: Session = Depends(get_db)):
    return crud.get_users(db)


@app.get("/users/{user_id}", response_model=UserResponse)
def api_get_user(user_id: int, db: Session = Depends(get_db)):
    return crud.get_user(db, user_id)


@app.put("/users/{user_id}", response_model=UserResponse)
def api_update_user(
    user_id: int,
    user: UserCreate,
    db: Session = Depends(get_db)
):
    return crud.update_user(db, user_id, user)


@app.delete("/users/{user_id}")
def api_delete_user(user_id: int, db: Session = Depends(get_db)):
    return crud.delete_user(db, user_id)