/*
CREATED BY: Brandy Nolan
CREATED ON: June 20,2024
DESCRIPTION: Exploratory data analysis  of fitness tracker product dataset.
*/

-- Clean data Step 1: Remove commas
UPDATE 
	fitness
SET 
	selling_price = REPLACE(selling_price, ',', ''),
    original_price = REPLACE(original_price, ',', '');
    
-- Clean data Step 2: Convert data types
ALTER TABLE fitness 
MODIFY selling_price int,
MODIFY original_price int,
MODIFY reviews int;


---- Clean data Step 2: Identify and delete duplicates
DELETE f
FROM `fitbit`.`fitness` f
JOIN (
    SELECT `Brand_Name`,
           `Device_Type`,
           `Model_Name`,
           `Color`,
           `Selling_Price`,
           `Original_Price`,
           `Display`,
           `Rating`,
           `Strap_Material`,
           `Average_Battery_Life`,
           `Reviews`
    FROM `fitbit`.`fitness`
    GROUP BY `Brand_Name`,
             `Device_Type`,
             `Model_Name`,
             `Color`,
             `Selling_Price`,
             `Original_Price`,
             `Display`,
             `Rating`,
             `Strap_Material`,
             `Average_Battery_Life`,
             `Reviews`
    HAVING COUNT(*) > 1
) d ON f.`Brand_Name` = d.`Brand_Name`
     AND f.`Device_Type` = d.`Device_Type`
     AND f.`Model_Name` = d.`Model_Name`
     AND f.`Color` = d.`Color`
     AND f.`Selling_Price` = d.`Selling_Price`
     AND f.`Original_Price` = d.`Original_Price`
     AND f.`Display` = d.`Display`
     AND f.`Rating` = d.`Rating`
     AND f.`Strap_Material` = d.`Strap_Material`
     AND f.`Average_Battery_Life` = d.`Average_Battery_Life`
     AND f.`Reviews` = d.`Reviews`;


-- Brand name count
SELECT
	COUNT(DISTINCT brand_name) total_device_count
FROM 
	fitness;

-- Device type count
SELECT
	device_type, 
    count(*) total_count
FROM 
	fitness
GROUP BY 
	device_type
ORDER BY 2 DESC;

-- how many displays are there
-- what different colors are offered
-- Device type avg rating
SELECT 
	device_type,
    round(avg(rating),2) avg_rating
FROM 
	fitness
group by 
	device_type;

    
-- Brand name rating
SELECT 
	brand_name,
    round(avg(rating),2) avg_rating
FROM 
	fitness
GROUP BY
	brand_name
ORDER BY 2 DESC;

-- brand avg orig and selling price
-- what different straps are offered
     





