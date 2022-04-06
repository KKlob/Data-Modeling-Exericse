-- Soccer league database
-- Assumptions
-- 1) Each game requires 3 refs

DROP DATABASE IF EXISTS soccer_league_db;

CREATE DATABASE soccer_league_db;

\c soccer_league_db

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    s_date DATE UNIQUE NOT NULL,
    e_date DATE UNIQUE NOT NULL
    );

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
    );

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL,
    team_abbr VARCHAR(3) UNIQUE NOT NULL
    );

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    team INT REFERENCES teams (id) DEFAULT NULL
    );

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    season_id INT REFERENCES seasons (id) NOT NULL,
    game_date DATE,
    team1 INT REFERENCES teams (id) NOT NULL,
    team2 INT REFERENCES teams (id) NOT NULL,
    winner INT REFERENCES teams (id) NOT NULL CHECK (winner = team1 OR winner = team2),
    ref1_id INT REFERENCES referees (id) NOT NULL,
    ref2_id INT REFERENCES referees (id) NOT NULL CHECK (ref1_id != ref2_id),
    ref3_id INT REFERENCES referees (id) NOT NULL CHECK (ref2_id != ref3_id)
    );

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    goal_timestamp TIMESTAMP,
    game_id INT REFERENCES games (id) NOT NULL,
    player_id INT REFERENCES players (id) NOT NULL
    );

-- Insert values below
INSERT INTO seasons (s_date, e_date)
VALUES
    ('2020-04-01', '2020-04-30'),
    ('2021-04-01', '2021-04-30'),
    ('2022-04-01', '2022-04-30');

INSERT INTO referees (first_name, last_name)
VALUES
    ('Bob', 'Smith'),
    ('Dan', 'Coats'),
    ('Smith', 'Smithson'),
    ('Kyle', 'Woodwind'),
    ('Samantha', 'Blanco');

INSERT INTO teams (team_name, team_abbr)
VALUES
    ('The Red Dragons', 'TRD'),
    ('The Blue Whales', 'TBW'),
    ('Swift Samurai', 'SWS'),
    ('Crazy Cookoos', 'CRC');

INSERT INTO players (first_name, last_name, team)
VALUES
    ('Sasha', 'Henkle',1),
    ('Kear', 'Ollis',1),
    ('Thalmus', 'Chatriand',1),
    ('Bazellius', 'Humbert',1),
    ('Barie', 'Lapar',1),
    ('Frantisek','Emard',2),
    ('Bertil','Merksamer',2),
    ('Somersby','Kiracofe',2),
    ('Frigyes','Heerkes',2),
    ('Garvan', 'Starley',2),
    ('Henry','Spohnholz',3),
    ('Duff','Blaida',3),
    ('Woodson','Pery',3),
    ('Salhdene','Montone',3),
    ('Alysdare','Gaskin',3),
    ('Issiah','Helper',4),
    ('Obadias','Facey',4),
    ('Christos','Maruco',4),
    ('Kristof','Zavtiz',4),
    ('Andre','Ketterer',4);

INSERT INTO games (season_id, game_date, team1, team2, winner, ref1_id, ref2_id, ref3_id)
VALUES
    (1,'2020-04-01', 1,2,1,1,2,3),
    (1,'2020-04-03', 3,4,3,3,4,5),
    (1,'2020-04-09', 1,4,1,2,5,3),
    (1,'2020-04-11', 2,3,2,1,4,3),
    (1,'2020-04-17', 1,3,1,2,1,5),
    (1,'2020-04-20', 2,4,4,4,5,3),
    (1,'2020-04-22', 2,3,2,1,2,3);

INSERT INTO goals (goal_timestamp, game_id, player_id)
VALUES
    ('2020-04-01 06:10:25-07', 1,3),
    ('2020-04-01 07:10:25-07', 1,4),
    ('2020-04-01 08:10:25-07', 1,8),
    ('2020-04-03 06:10:25-07', 2,11),
    ('2020-04-03 07:10:25-07', 2,12),
    ('2020-04-03 08:10:25-07', 2,18),
    ('2020-04-09 06:10:25-07', 3,18),
    ('2020-04-09 07:10:25-07', 3,3),
    ('2020-04-09 08:10:25-07', 3,3),
    ('2020-04-11 06:10:25-07', 4,6),
    ('2020-04-11 07:10:25-07', 4,7),
    ('2020-04-11 08:10:25-07', 4,12),
    ('2020-04-17 06:10:25-07', 5,3),
    ('2020-04-17 07:10:25-07', 5,4),
    ('2020-04-17 08:10:25-07', 5,11),
    ('2020-04-20 06:10:25-07', 6,8),
    ('2020-04-20 07:10:25-07', 6,6),
    ('2020-04-20 08:10:25-07', 6,18),
    ('2020-04-22 06:10:25-07', 7,7),
    ('2020-04-22 07:10:25-07', 7,9),
    ('2020-04-22 08:10:25-07', 7,14);

-- Selects below --

-- Show rankings for teams for Season 1 --
SELECT teams.team_name, COUNT(winner) AS games_won
FROM games
JOIN teams ON winner = teams.id AND season_id = 1
GROUP BY team_name
ORDER BY games_won DESC;