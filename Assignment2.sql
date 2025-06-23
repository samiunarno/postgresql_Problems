-- --------------------------------------------
-- 1️⃣ Register a new ranger with provided data
-- --------------------------------------------
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- --------------------------------------------
-- 2️⃣ Count unique species ever sighted
-- --------------------------------------------
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- --------------------------------------------
-- 3️⃣ Find all sightings where the location includes "Pass"
-- --------------------------------------------
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';

-- --------------------------------------------
-- 4️⃣ List each ranger's name and their total number of sightings
-- --------------------------------------------
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- --------------------------------------------
-- 5️⃣ List species that have never been sighted
-- --------------------------------------------
SELECT common_name
FROM species
WHERE species_id NOT IN (
  SELECT DISTINCT species_id FROM sightings
);

-- --------------------------------------------
-- 6️⃣ Show the most recent 2 sightings
-- --------------------------------------------
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- --------------------------------------------
-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'
-- --------------------------------------------
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- --------------------------------------------
-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'
-- --------------------------------------------
SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- --------------------------------------------
-- 9️⃣ Delete rangers who have never sighted any species
-- --------------------------------------------
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);
