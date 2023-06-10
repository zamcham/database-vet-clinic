/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT new_savepoint_1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT new_savepoint_1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* questions */
SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS non_escape_animals
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

SELECT a.name AS last_animal_seen
FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS num_animals_seen
FROM visits v
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez';

SELECT v.name, s.name AS specialty
FROM vets v
LEFT JOIN specializations sp ON sp.vet_id = v.id
LEFT JOIN species s ON s.id = sp.species_id;

SELECT a.name
FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS most_visited_animal
FROM animals a
JOIN visits v ON v.animal_id = a.id
GROUP BY a.name
ORDER BY COUNT(v.animal_id) DESC
LIMIT 1;

SELECT a.name AS first_visit_animal
FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM visits v
JOIN animals a ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON a.id = v.animal_id
LEFT JOIN specializations sp ON sp.vet_id = v.vet_id AND sp.species_id = a.species_id
WHERE sp.species_id IS NULL;

SELECT s.name AS recommended_specialty
FROM visits v
JOIN animals a ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
JOIN specializations sp ON sp.vet_id = vt.id
JOIN species s ON s.id = sp.species_id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;
