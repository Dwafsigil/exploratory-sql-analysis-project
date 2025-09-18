
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

INSERT INTO observations (species_id, region_id, observer, observation_date, latitude, longitude, count) VALUES (269, 1, 'obsr201342', '2001-09-09', -30.9134123, 179.32345, 5);
SELECT * FROM observations WHERE latitude = -30.9134123 ;

INSERT OR IGNORE INTO species (scientific_name, common_name, genus, family, order_name) VALUES ('Tachycineta leucorhoa', 'White-rumped Swallow', 'Tachycineta', 'Hirundinidae', 'Passeriformes');
SELECT id, scientific_name FROM species WHERE scientific_name LIKE '%Tachycineta leucor%';
UPDATE species SET scientific_name = "Tachycineta leucorrhoa test" WHERE ID = 1266;
SELECT id, * FROM species WHERE scientific_name = "Tachycineta leucorrhoa test";



DELETE FROM observations WHERE id = 518;
SELECT * FROM observations WHERE id = 518;


-- SELECT * FROM regions;
-- SELECT * FROM species;
-- SELECT * FROM climate;
-- SELECT * FROM observations;



