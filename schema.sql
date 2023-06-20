/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR,
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR
);

ALTER TABLE animals
id SERIAL PRIMARY KEY,
DROP COLUMN species,
ADD COLUMN species_id INTEGER REFERENCES species(id),
ADD COLUMN owner_id INTEGER REFERENCES owners(id);


CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id),
  PRIMARY KEY (vet_id, species_id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX visits_animal_id_asc ON visits(animal_id ASC);
CREATE INDEX owners_email_asc ON owners(email ASC);

-- CREATE PARTITION TABLE
CREATE TABLE visits_partitioned (
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  vet_id INT,
  date_of_visit DATE,
  PRIMARY KEY(id, vet_id)
) PARTITION BY RANGE (vet_id);

CREATE TABLE visits_partition_1 PARTITION OF visits_partitioned FOR VALUES FROM (1) TO (2);
CREATE TABLE visits_partition_2 PARTITION OF visits_partitioned FOR VALUES FROM (2) TO (3);
CREATE TABLE visits_partition_3 PARTITION OF visits_partitioned FOR VALUES FROM (3) TO (4);
CREATE TABLE visits_partition_4 PARTITION OF visits_partitioned FOR VALUES FROM (4) TO (MAXVALUE);

