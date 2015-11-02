-- Question 1: furthest destination
SELECT dest, distance FROM flights
GROUP BY dest ORDER BY distance DESC LIMIT 1;
-- The furthest airport is Honolulu Intl (HNL) at 4,983 miles


-- Question 2: number of engines and seats
SELECT engines FROM planes
GROUP BY engines ORDER BY engines;
-- Planes have 1, 2, 3, or 4 engines.
SELECT manufacturer, model, seats FROM planes
WHERE engines = 1 GROUP BY manufacturer, model
ORDER BY seats DESC, manufacturer, model;
-- The 1-engine aircraft with the most seats is the
-- DEHAVILLAND OTTER DHC-3 with 16 seats.
SELECT manufacturer, model, seats FROM planes
WHERE engines = 2 GROUP BY manufacturer, model
ORDER BY seats DESC, manufacturer, model;
-- The 2-engine aircraft with the most seats are the
-- BOEING 777-200, 777-222, 777-224, and 777-232, each with 400 seats.
SELECT manufacturer, model, seats FROM planes
WHERE engines = 3 GROUP BY manufacturer, model
ORDER BY seats DESC, manufacturer, model;
-- The 3-engine aircraft with the most seats is the
-- AIRBUS A330-223 with 379 seats.
SELECT manufacturer, model, seats FROM planes
WHERE engines = 4 GROUP BY manufacturer, model
ORDER BY seats DESC, manufacturer, model;
-- The 4-engine aircraft with the most seats is the
-- BOEING 747-451 with 450 seats.


-- Question 3: total flights
SELECT COUNT(*) FROM flights;
-- There were 336,776 flights


-- Question 4: flights by airline
SELECT carrier, COUNT(*) FROM flights
GROUP BY carrier;

-- Question 5: flights by airline, descending order
SELECT carrier, COUNT(*) FROM flights
GROUP BY carrier
ORDER BY COUNT(*) DESC;

-- Question 6: top 5 flights by airline, descending order
SELECT carrier, COUNT(*) FROM flights
GROUP BY carrier
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Question 7: top 5 flights over 1000 miles by airline, descending order
SELECT carrier, COUNT(*) FROM flights
WHERE distance < 1000
GROUP BY carrier
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Question 8:
-- Which airline, flying out of which airport, has the lowest delay on arrival times into LAX?
SELECT carrier, origin, AVG(arr_delay) AS ExpectedDelay FROM flights
WHERE arr_delay IS NOT NULL AND dest = 'LAX'
GROUP BY carrier, origin
ORDER BY ExpectedDelay LIMIT 1;
-- The shortest expected delay into LAX is flying Delta from JFK (-3.8 minutes).