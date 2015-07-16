DROP TABLE IF EXISTS 'users';

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS 'questions';

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS 'question_follows';

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS 'replies';

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  reply_id INTEGER,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS 'question_likes';

CREATE TABLE question_likes(
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Eric', "Schwarzenbach"), ('Ryan', 'Glasett'), ('Ned', 'Stark');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How do you use SQL', 'Pls help me with my homework',
    (SELECT id FROM users WHERE fname = 'Ned' AND lname = 'Stark')),
  ('Lunch', 'Whats for lunch?', (SELECT id FROM users WHERE fname = 'Ryan'));

INSERT INTO
  question_follows(question_id, follower_id)
VALUES
  (2, 3);

INSERT INTO
  replies(body, question_id, user_id, reply_id)
VALUES
  ('Sandwich', 2, 1, NULL),
  ('I hate sandwiches', 2, 1, 1);

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (1, 2);
