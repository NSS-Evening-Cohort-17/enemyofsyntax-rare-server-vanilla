CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);


CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Categories ('label') VALUES ('Entertainment');
INSERT INTO Categories ('label') VALUES ('World');
INSERT INTO Tags ('label') VALUES ('Test-Tag1');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');
INSERT INTO Users ('first_name', 'last_name', 'email','username','password')
VALUES ('Test', 'User', 'testuser@email.com','testuser', 'testuser');
INSERT INTO  Posts ('user_id',  'category_id' ,  'title' ,  'publication_date' ,  'image_url' ,  'content' ,  'approved' )
values(1,  1 ,  'Ukraine' ,  '12-14-2021' ,  'www.cnn.com' ,  'International help on the way' ,  1 );
INSERT INTO  Posts ('user_id',  'category_id' ,  'title' ,  'publication_date' ,  'image_url' ,  'content' ,  'approved' )
values(2,  2 ,  'Nashville' ,  '12-14-2022' ,  'www.foxnews.com' ,  'Music festival approaching' ,  1 );
INSERT INTO  Posts ('user_id',  'category_id' ,  'title' ,  'publication_date' ,  'image_url' ,  'content' ,  'approved' )
values(3,  3 ,  'New York' ,  '12-14-2022' ,  'www.nytimes.com' ,  'Business week' ,  1 )
SELECT a.id, a.label FROM categories a
SELECT t.id, t.label FROM tags t

update posts set title = 'Memphis' where id=1
select * from Posts