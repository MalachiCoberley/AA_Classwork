PRAGMA foreign_keys = ON;

--Users table

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(120) NOT NULL,
  lname VARCHAR(120) NOT NULL

);

-- Questions table

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(120) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Question_follows table

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


--REPLIES

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question_id INTEGER NOT NULL,
  reply_to_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,


  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_to_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Ned', 'Ned_last');

INSERT INTO
  users(fname, lname)
VALUES
  ('Kush', 'Kush_last');

INSERT INTO
  users(fname, lname)
VALUES
  ('Earl', 'Earl_last');


INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Ned Question', 'NED NED NED', 1);

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Kush Question', 'KUSH KUSH KUSH', 2);

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Earl Question', 'MEOW MEOW MEOW', 3);
