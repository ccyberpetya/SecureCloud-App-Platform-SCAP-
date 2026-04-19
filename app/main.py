# app/main.py

from fastapi import FastAPI
from sqlalchemy import create_engine, text
import os

app = FastAPI()
DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(DATABASE_URL) #Создание объекта подключения к БД

@app.get("/")
def read_root():
    return {"message": "FastAPI is running"}

@app.get("/db-check")
def db_check(): #Проверка доступа к PostgresSQL
    try:
        with engine.connect() as connection: #Открытие соединения
            result = connection.execute(text("SELECT 1")) #Выполнение SQL
            value = result.scalar() #Возвращение скалярного значения (1)
        return {"db_status": "connected", "result": value}
    except Exception as error:
        return {"db_status": "error", "details": str(error)}