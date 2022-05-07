import sqlite3
import json
from models.category import Category

def get_all_categories():
    # Open a connection to the database
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        db_cursor.execute("""SELECT a.id, a.label FROM categories a""")
        categories = []
        dataset = db_cursor.fetchall()
        for row in dataset:
            category = Category(row['id'], row['label'])
            print(category.__dict__)         
            categories.append(category.__dict__)
    return json.dumps(categories)