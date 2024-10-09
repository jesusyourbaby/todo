 CREATE DATABASE todo_app;

 USE todo_app;

 CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255)
);

CREATE TABLE todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  completed BOOLEAN DEFAULT false,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE 
);

CREATE TABLE shared_todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  todo_id INT,
  user_id INT,
  shared_with_id INT,
  FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert two users into the users table
INSERT INTO users (name, email, password) VALUES ('Jesus', 'jesus@example.com', '1234');
INSERT INTO users (name, email, password) VALUES ('Jhon', 'jhon@example.com', '1234');

INSERT INTO todos (title, user_id) 
VALUES 
("Going for a walk in the mornings", 1),
("Working at noon", 1),
("Shopping on Saturday mornings", 1),
("Play on my nintendo switch", 1),
("Finish my degree project", 1),
("Making snacks for my family", 1),
("Exercising at night", 1),
("Listening to music at night", 1),
("Clean my room", 1),
("Get 8 hours of sleep", 1);

-- share todo 1 of user 1 with user 2
INSERT INTO shared_todos (todo_id, user_id, shared_with_id) VALUES (1, 1, 2);

-- Get todos including shared todos by id
SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = 2 OR shared_todos.shared_with_id = 2;