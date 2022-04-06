-- Craigslist database

DROP DATABASE IF EXISTS craigslist_db;

CREATE DATABASE craigslist_db;

\c craigslist_db

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL
    );

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE,
    "password" TEXT,
    preferred_region INT REFERENCES regions (id) ON DELETE SET NULL
    );

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL
    );

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    category INT REFERENCES categories (id) ON DELETE SET NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    owner_id INT REFERENCES users (id) ON DELETE SET NULL,
    location_posted TEXT,
    region_posted INT REFERENCES regions (id) ON DELETE SET NULL
    );

CREATE INDEX categories_index ON posts (category);
CREATE INDEX users_index ON users (username);


INSERT INTO regions ("name")
VALUES
    ('San Francisco'),
    ('Atlanta'),
    ('Seattle');

INSERT INTO categories ("name")
VALUES 
    ('Cars/Trucks'),
    ('Electronics'),
    ('Housing');

INSERT INTO users (username, "password", preferred_region)
VALUES
    ('chickenbutt', 'odifhaio', 1),
    ('catdogduckgoose', 'doifhanwiofhne', 2),
    ('towelman', 'doifahoie', 3);

INSERT INTO posts (category, title, content, owner_id, location_posted, region_posted)
VALUES
    (1, 'My Civic for sale!', 'This is the content for my forsale ad', 1, 'some-locale', 1),
    (2, 'Selling DVD player!', 'content for dvd player ad', 2, 'some-other-locale', 2),
    (3, 'Apartment for Rent!', 'content for apartment ad', 2, 'nearby locale', 2),
    (3, 'New house just built!', 'content for house ad', 3, 'some other locale far far away', 3);