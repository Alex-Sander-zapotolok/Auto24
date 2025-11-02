-- queries.sql
-- Harjutus: 6 kasulikku SELECT päringut teie antud MySQL andmebaasi skeemi põhjal
-- Kasutatud tabelid (vastavad teie SQL dumpile): makes, models, vehicles, users
-- Iga päringu juures on lühike selgitus ja oodatav tulemus. Kohandage vajadusel, kui teie reaalsed veerud erinevad.

-- Query 1: Viimased 20 sõidukit (make, model, year, price, kontakt)
SELECT
  v.ID AS vehicle_id,
  mk.name AS make,
  m.name AS model,
  v.year AS year,
  v.price AS price,
  v.location AS location,
  v.contact_name AS contact_name,
  v.contact_phone AS contact_phone,
  v.contact_email AS contact_email,
  v.created_at AS posted_at
FROM vehicles v
JOIN models m ON v.model_id = m.id
JOIN makes mk ON m.make_id = mk.id
WHERE v.price > 0
ORDER BY v.created_at DESC
LIMIT 20;


-- Query 2: Müüjate kokkuvõte (posted_count, avg_price) — JOIN users via Email
SELECT
  u.ID AS user_id,
  u.Username AS username,
  COUNT(v.ID) AS posted_count,
  ROUND(AVG(v.price), 2) AS avg_price
FROM users u
JOIN vehicles v ON v.contact_email = u.Email
GROUP BY u.ID, u.Username
HAVING COUNT(v.ID) > 0
ORDER BY posted_count DESC;


-- Query 3: Mudeli statistika (count, avg, min, max)
SELECT
  m.id AS model_id,
  mk.name AS make,
  m.name AS model,
  COUNT(v.ID) AS vehicles_count,
  ROUND(AVG(v.price), 2) AS avg_price,
  MIN(v.price) AS min_price,
  MAX(v.price) AS max_price
FROM models m
JOIN makes mk ON m.make_id = mk.id
LEFT JOIN vehicles v ON v.model_id = m.id
GROUP BY m.id, mk.name, m.name
ORDER BY vehicles_count DESC
LIMIT 15;


-- Query 4: Sõidukid, mille hind > sama mudeli keskmine (AVG) — subquery
SELECT
  v.ID AS vehicle_id,
  mk.name AS make,
  m.name AS model,
  v.year AS year,
  v.price AS price,
  ROUND((SELECT AVG(price) FROM vehicles WHERE model_id = v.model_id), 2) AS model_avg_price,
  ROUND(v.price - (SELECT AVG(price) FROM vehicles WHERE model_id = v.model_id), 2) AS diff
FROM vehicles v
JOIN models m ON v.model_id = m.id
JOIN makes mk ON m.make_id = mk.id
WHERE v.price > (SELECT AVG(price) FROM vehicles WHERE model_id = v.model_id)
ORDER BY diff DESC
LIMIT 50;


-- Query 5: Tootjad viimase aasta põhjal (count>=5, avg price)
SELECT
  mk.id AS make_id,
  mk.name AS make,
  COUNT(v.ID) AS vehicles_count_1yr,
  ROUND(AVG(v.price), 2) AS avg_price_1yr
FROM makes mk
JOIN models m ON m.make_id = mk.id
JOIN vehicles v ON v.model_id = m.id
WHERE v.created_at >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY mk.id, mk.name
HAVING COUNT(v.ID) >= 5
ORDER BY avg_price_1yr DESC
LIMIT 10;


-- Query 6: Kontaktide top (contact_email, post_count)
SELECT
  v.contact_email AS contact_email,
  v.contact_name AS contact_name,
  COUNT(*) AS post_count
FROM vehicles v
WHERE v.contact_email IS NOT NULL AND v.contact_email <> ''
GROUP BY v.contact_email, v.contact_name
ORDER BY post_count DESC
LIMIT 20;

-- Märkused:
-- 1) Kui teie tegelik skeem kasutab teistsuguseid veerunimesid (suured tähed nagu `ID` või `Email`), siis päringud on kohandatud antud dumpi järgi.
-- 2) Kui soovite täpsemat mediaani-arvutust, saan pakkuda MySQL-i spetsiifilist lahendust (ridade järjestamine ja keskväärtused).
-- 3) Kui soovite, testin päringud teie andmebaasis või teen lihtsa sample-ckeck-i andmetega.
