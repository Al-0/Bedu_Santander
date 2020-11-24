CREATE DATABASE IF NOT EXISTS Sesion_7;
USE Sesion_7;
CREATE TABLE IF NOT EXISTS users(
	id INT PRIMARY KEY,
    gender CHAR(1),
    age INT1,
    ocupation INT,
    zip_code VARCHAR(15)
);
-- Reto #1
CREATE TABLE IF NOT EXISTS movies(
	id INT PRIMARY KEY,
    title VARCHAR(80),
    genres VARCHAR(80)
);
DROP TABLE IF EXISTS movies;
CREATE TABLE IF NOT EXISTS ratings(
	users_id INT PRIMARY KEY,
    movies_id INT,
    rating INT1,
    time_stamp BIGINT,
    FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (movies_id) REFERENCES movies(id)
);
DROP TABLE IF EXISTS ratings;
-- Reto #2
SELECT * FROM movies;