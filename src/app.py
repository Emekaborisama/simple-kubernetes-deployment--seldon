# type: ignore
from fastapi import FastAPI
import databases
import sqlalchemy
from dotenv import load_dotenv
import os

load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")


database = databases.Database(DATABASE_URL)
metadata = sqlalchemy.MetaData()

app = FastAPI()


@app.get("/check-db-login")
async def check_db_login():
    try:
        await database.connect()
        await database.disconnect()
        return {"success": True}
    except Exception as e:
        return {"success": False, "error": str(e)}
