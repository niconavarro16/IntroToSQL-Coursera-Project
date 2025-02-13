-- CREATING THE TABLES

CREATE TABLE cheese_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);


CREATE TABLE honey_production (
    Year INTEGER,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE milk_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);


CREATE TABLE coffee_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE egg_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Value INTEGER
);


CREATE TABLE state_lookup (
    State TEXT,
    State_ANSI INTEGER
);


CREATE TABLE yogurt_production (
    Year INTEGER,
    Period TEXT,
    Geo_Level TEXT,
    State_ANSI INTEGER,
    Commodity_ID INTEGER,
    Domain TEXT,
    Value INTEGER
);


-- CLEANING

UPDATE cheese_production SET value = REPLACE(value, ',', '');
UPDATE coffee_production SET value = REPLACE(value, ',', '');
UPDATE egg_production SET value = REPLACE(value, ',', '');
UPDATE honey_production SET value = REPLACE(value, ',', '');
UPDATE milk_production SET value = REPLACE(value, ',', '');
UPDATE yogurt_production SET value = REPLACE(value, ',', '');


-- PRACTICE QUESTIONS

-- Find the total milk production for the year 2023.
SELECT SUM(Value) 
FROM milk_production mp 
WHERE Year = 2023

-- Show coffee production data for the year 2015.
SELECT SUM(Value) 
FROM coffee_production cp 
WHERE Year = 2015

-- Find the average honey production for the year 2022.
SELECT AVG(Value) 
FROM honey_production hp 
WHERE Year = 2022

-- Get the state names with their corresponding ANSI codes from the state_lookup table.
SELECT State, State_ANSI 
FROM state_lookup sl 

-- Find the highest yogurt production value for the year 2022.
SELECT MAX(Value) 
FROM yogurt_production yp 
WHERE Year = 2022
 
-- Find states where both honey and milk were produced in 2022.
SELECT DISTINCT hp.State_ANSI
FROM honey_production hp 
	JOIN milk_production mp 
	ON hp.State_ANSI = mp.State_ANSI 
WHERE hp.Year = 2022 AND mp.Year = 2022

-- Find the total yogurt production for states that also produced cheese in 2022.
SELECT SUM(yp.Value) AS Total_Yogurt_Production
FROM yogurt_production yp
JOIN cheese_production cp
    ON yp.State_ANSI = cp.State_ANSI
WHERE yp.Year = 2022 AND cp.Year = 2022;


-- FINAL PROJECT

-- What is the total milk production for 2023? CORRECT
SELECT SUM(Value)
FROM milk_production mp 
WHERE Year = 2023
	
-- Which states had cheese production greater than 100 million in April 2023?  CORRECT
SELECT DISTINCT State_ANSI
FROM cheese_production cp 
WHERE Value > 100000000
	AND Period = 'APR'
	AND Year = 2023
	
-- What is the total value of coffee production for 2011? CORRECT
SELECT SUM(VALUE) 
FROM coffee_production cp 
WHERE Year = 2011

-- Find the average honey production for 2022 so you're prepared. INCORRECT
SELECT AVG(Value) AS Average_Honey_Production
FROM honey_production
WHERE Year = 2022;

	
-- What is the State_ANSI code for Florida? CORRECT
SELECT State, State_ANSI
FROM state_lookup sl 
WHERE State = "FLORIDA"

-- Can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
-- What is the total for NEW JERSEY? INCORRECT
SELECT sl.State, SUM(cp.Value)
FROM state_lookup sl 
	LEFT JOIN cheese_production cp 
	ON sl.State_ANSI = cp."State_ANSI"
GROUP BY sl.State


-- Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? INCORRECT
SELECT SUM(yp.Value) AS Total_Yogurt_Production
FROM yogurt_production yp
WHERE yp.Year = 2022
  AND yp.State_ANSI IN (
      SELECT DISTINCT cp.State_ANSI
      FROM cheese_production cp
      WHERE cp.Year = 2023
  );


-- List all states from state_lookup that are missing from milk_production in 2023. CORRECT
SELECT sl.State AS Missing_State
FROM state_lookup sl
LEFT JOIN milk_production mp
    ON sl.State_ANSI = mp.State_ANSI
    AND mp.Year = 2023
WHERE mp.State_ANSI IS NULL;


-- List all states with their cheese production values, including states that didn't produce any cheese in April 2023. INCORRECT
SELECT sl.State, SUM(cp.Value)
FROM state_lookup sl 
	LEFT JOIN cheese_production cp
    ON sl.State_ANSI = cp.State_ANSI
 GROUP BY sl.State
 
 
-- Find the average coffee production for all years where the honey production exceeded 1 million. INCORRECT
SELECT AVG(cp.Value) AS Average_Coffee_Production
FROM coffee_production cp
WHERE cp.Year IN (
    SELECT DISTINCT hp.Year
    FROM honey_production hp
    WHERE hp.Value > 1000000
);





