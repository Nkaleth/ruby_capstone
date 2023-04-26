/* Database schema to keep the structure of entire database. */
CREATE DATABASE catalog_of_things;

\c catalog_of_things

CREATE TABLE books(
  id INT GENERATED ALWAYS AS IDENTITY,
  publish_date DATE,
  archived BOOLEAN,
  publisher VARCHAR(250),
  cover_state VARCHAR(250),
  label_id INT,
  CONSTRAINT fk_labels FOREIGN KEY(label_id) REFERENCES labels(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);
