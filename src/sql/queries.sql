
SELECT * FROM observations LIMIT 10;

SELECT DISTINCT region_id FROM observations; 

SELECT COUNT(Distinct species_id) FROM observations;

SELECT COUNT(*) FROM observations WHERE region_id = 2;

SELECT COUNT(*) FROM observations WHERE observation_date = '1998-08-08';

SELECT region_id, COUNT(*) as observation_count FROM observations GROUP BY region_id ORDER BY observation_count DESC LIMIT 1;

SELECT species_id, COUNT(*) as observation_count FROM observations GROUP BY species_id ORDER BY observation_count DESC LIMIT 5;

SELECT species_id, COUNT(*) as observation_count FROM observations GROUP BY species_id HAVING COUNT(*) < 5; 

SELECT observer, COUNT(*) as observation_count FROM observations GROUP BY observer ORDER BY observation_count DESC LIMIT 1;

SELECT o.id as observation_id, r.name AS region_name FROM observations o JOIN regions r ON o.region_id = r.id;

SELECT s.scientific_name as scientific_name FROM observations o JOIN species s ON o.species_id = s.id;

SELECT r.name AS region_name, s.scientific_name, COUNT(*) AS observation_count FROM observations o JOIN regions r ON o.region_id = r.id JOIN species s On o.species_id = s.id  GROUP BY r.id, s.id ORDER BY r.name, observation_count DESC;

-- INSERT INTO observations(id, species_id, region_id, observer, observation_date, latitude, longitude, "count") VALUES(501,1, 1, 'obsr201342', '2001-09-09', -30.234123, 179.32345, 5);

-- SELECT * FROM regions;
-- SELECT * FROM species;
-- SELECT * FROM climate;
-- SELECT * FROM observations;



