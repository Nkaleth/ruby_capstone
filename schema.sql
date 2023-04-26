/* Database schema to keep the structure of entire database. */
CREATE DATABASE catalog_of_things;

\c catalog_of_things

CREATE TABLE music_albums(
  id INT GENERATED ALWAYS AS IDENTITY,
  publish_date DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT,
  CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genres(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE TABLE genres(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  PRIMARY KEY(id)
);
