-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

-- Added --
CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  name TEXT[] NOT NULL
);

-- Added --
CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

-- Updated album/producers to reference respective table ids --
CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artists TEXT[] NOT NULL,
  album INT REFERENCES albums (id) NOT NULL,
  song_producers INT REFERENCES producers (id) NOT NULL
);

INSERT INTO producers (name)
VALUES
  ('{"Dust Brothers", "Stephen Lironi"}'),
  ('{"Roy Thomas Baker"}'),
  ('{"Walter Afanasieff"}'),
  ('{"Benjamin Rice"}'),
  ('{"Rick Parashar"}'),
  ('{"Al Shux"}'),
  ('{"Max Martin", "Cirkut"}'),
  ('{"Shellback", "Benny Blanco"}'),
  ('{"The Matrix"}'),
  ('{"Darkchild"}');

INSERT INTO albums (name)
VALUES
  ('Middle of Nowhere'),
  ('A Night at the Opera'),
  ('Daydream'),
  ('A Star Is Born'),
  ('Silver Side Up'),
  ('The Blueprint 3'),
  ('Prism'),
  ('Hands All Over'),
  ('Let Go'),
  ('The Writing''s on the Wall');


INSERT INTO songs
  (title, duration_in_seconds, release_date, artists, album, song_producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 1, 1),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 2, 2),
  ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 3, 3),
  ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 4, 4),
  ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 5, 5),
  ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 6, 6),
  ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 7, 7),
  ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 8, 8),
  ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 9, 9),
  ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 10, 10);
