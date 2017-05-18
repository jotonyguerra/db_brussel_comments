-- Define the structure of your database, here.
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS comments;

CREATE TABLE recipes(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE comments(
  id SERIAL PRIMARY KEY,
  body VARCHAR(500),
  recipe_id INTEGER
);
