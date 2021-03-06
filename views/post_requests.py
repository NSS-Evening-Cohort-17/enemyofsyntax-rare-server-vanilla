import sqlite3
import json
from models import Post

POSTS = []

def get_all_posts():
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        
        db_cursor.execute("""
        SELECT
            a.id,
            a.user_id,
            a.category_id,
            a.title,
            a.publication_date,
            a.image_url,
            a.content,
            a.approved
        FROM Posts a       
                          """)
        
        posts = []
        
        dataset = db_cursor.fetchall()
        
        for row in dataset:
            post = Post(row['id'], row['user_id'], row['category_id'], 
                        row['title'],row['publication_date'], row['image_url'],
                        row['content'], row['approved'])
            
            posts.append(post.__dict__)
    
    return json.dumps(posts)

def get_single_post(id):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        
        db_cursor.execute("""
        SELECT
            a.id,
            a.user_id,
            a.category_id,
            a.title,
            a.publication_date,
            a.image_url,
            a.content,
            a.approved
        FROM Posts a  
        WHERE a.id = ?
        """, ( id, ))
        
        data = db_cursor.fetchone()
        
        post = Post(data['id'], data['user_id'], data['category_id'], 
                        data['title'],data['publication_date'], data['image_url'],
                        data['content'], data['approved'])
        
        return json.dumps(post.__dict__)

def create_post(new_post):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        db_cursor.execute("""
            INSERT INTO Posts
            ( user_id, category_id, title, publication_date,
            image_url, content, approved )
            VALUES 
            ( ?, ?, ?, ?, ?, ?, ?); 
                          """, (new_post['user_id'], 
                                new_post['category_id'],
                                new_post['title'],
                                new_post['publication_date'],
                                new_post['image_url'],
                                new_post['content'],
                                new_post['approved'], ))
        id = db_cursor.lastrowid
        new_post['id'] = id
    
    return json.dumps(new_post)

def delete_post(id):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        
        db_cursor.execute("""
            DELETE FROM Posts
            WHERE id = ?
                          """, (id, ))
        
def update_post(id, new_post):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        
        db_cursor.execute("""
            UPDATE Posts
                SET
                    user_id = ?,
                    category_id = ?,
                    title = ?,
                    publication_date = ?,
                    image_url = ?,
                    content = ?,
                    approved =?
            WHERE id = ?
            """, (new_post['user_id'], 
                    new_post['category_id'],
                    new_post['title'],
                    new_post['publication_date'],
                    new_post['image_url'],
                    new_post['content'],
                    new_post['approved'], id, ))
        
        rows_affected = db_cursor.rowcount
        
    if rows_affected == 0:
        return False
    else:
        return True
            
def get_posts_by_user_id(user_id):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        
        db_cursor.execute("""
        SELECT
            a.id,
            a.user_id,
            a.category_id,
            a.title,
            a.publication_date,
            a.image_url,
            a.content,
            a.approved
        FROM Posts a  
        WHERE a.user_id = ?
        """, ( user_id, ))
        
        posts = []
        dataset = db_cursor.fetchall()
        
        for row in dataset:
            post = Post(row['id'], row['user_id'], row['category_id'], 
                        row['title'],row['publication_date'], row['image_url'],
                        row['content'], row['approved'])
            posts.append(post.__dict__)
        
    return json.dumps(posts)
    