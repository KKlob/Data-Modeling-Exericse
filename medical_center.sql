-- Medical center database

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors (
    "id" SERIAL PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone_number" FLOAT UNIQUE NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "role" TEXT NOT NULL);

CREATE TABLE patients (
    "id" SERIAL PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "phone_number" FLOAT UNIQUE NOT NULL,
    "email" TEXT UNIQUE,
    "primary_care" INT REFERENCES doctors (id) ON DELETE SET NULL);

CREATE TABLE diseases (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "neg_effects" TEXT NOT NULL);

CREATE TABLE visits (
    "id" SERIAL PRIMARY KEY,
    "doctor_id" INT REFERENCES doctors (id) ON DELETE SET NULL,
    "patient_id" INT REFERENCES patients (id) ON DELETE SET NULL,
    "date" DATE NOT NULL,
    "patient_reason" TEXT NOT NULL,
    "doctors_notes" TEXT NOT NULL,
    "multiple_diseases" BOOLEAN DEFAULT False,
    "disease1_id" INT REFERENCES diseases (id) ON DELETE CASCADE,
    "disease2_id" INT REFERENCES diseases (id) ON DELETE CASCADE,
    "disease3_id" INT REFERENCES diseases (id) ON DELETE CASCADE);

INSERT INTO doctors (first_name, last_name, phone_number, email, "role")
VALUES
    ('John', 'Smith', 5183210495, 'john.smith@gmail.com', 'Radiologist'),
    ('April', 'Stevenson', 9072348574, 'april.stevenson@gmail.com', 'Surgeon'),
    ('Steven', 'Strange', 1234567890, 'Strange.Steven@gmail.com', 'Best Surgeon Ever');

INSERT INTO patients (first_name, last_name, phone_number, email, primary_care)
VALUES
    ('John', 'Candy', 9893746253, 'john.candy@gmail.com', 2),
    ('Bob', 'LeGrasse', 7486237838, 'bob.legrasse@gmail.com', 1),
    ('Sydney', 'Stiffled', 2386729825, 'sydney.stiffled@gmail.com', 3);

INSERT INTO diseases ("name", neg_effects)
VALUES
    ('Common Cold', 'Sniffly nose, cough, fatigue'),
    ('Flu', 'nausia, intense fatigue, other sympoms'),
    ('Cancer', 'cells attack themselves oh no!');

INSERT INTO visits (doctor_id, patient_id, "date",  patient_reason, doctors_notes, multiple_diseases, disease1_id, disease2_id)
VALUES
    (1,1,'2022-1-10', 'feels unwell', 'shows symptoms of common cold', False, 1, NULL),
    (1,2,'2022-2-3', 'feels unwell', 'shows symptoms of flu + common cold', True,  2, 1),
    (3,1,'2022-2-21', 'collpased at home', 'scans show signs of cancer',False, 3, NULL),
    (2,3,'2022-3-17', 'consistent vommiting at home, fatigue', 'classic signs of the flu', False, 2, NULL);
