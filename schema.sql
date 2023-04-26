/* Database schema to keep the structure of entire database. */
CREATE DATABASE catalog_of_things;

\c catalog_of_things

CREATE TABLE books(
  ID INT GENERATED ALWAYS AS IDENTITY,
  publish_date DATE,
  archived BOOLEAN,
  publisher VARCHAR(250),
  cover_state VARCHAR(250),
  PRIMARY KEY(id)
);
