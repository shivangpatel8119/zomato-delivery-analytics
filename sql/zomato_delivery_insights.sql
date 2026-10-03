USE zomato_delivery;;

-- =========================================================
-- ZOMATO DELIVERY - FINAL INSIGHT EXTRACTION
-- =========================================================


-- 1. OVERALL KPIs
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT Delivery_person_ID) AS unique_delivery_persons,
    COUNT(DISTINCT City) AS total_cities,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(MIN(`Time_taken (min)`), 2) AS min_delivery_time,
    ROUND(MAX(`Time_taken (min)`), 2) AS max_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance_km,
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating
FROM zomato_food_delivery_final_cleaned;


-- 2. DELIVERY PERFORMANCE
SELECT
    Delivery_Performance,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Delivery_Performance
ORDER BY orders DESC;


-- 3. DELIVERY SPEED
SELECT
    delivery_speed,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY delivery_speed
ORDER BY orders DESC;


-- 4. TRAFFIC IMPACT
SELECT
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Road_traffic_density
ORDER BY avg_delivery_time DESC;


-- 5. DISTANCE IMPACT
SELECT
    CASE
        WHEN distance_km < 3 THEN 'Short (<3 km)'
        WHEN distance_km < 7 THEN 'Medium (3-7 km)'
        WHEN distance_km < 12 THEN 'Long (7-12 km)'
        ELSE 'Very Long (12+ km)'
    END AS distance_category,
    COUNT(*) AS orders,
    ROUND(AVG(distance_km), 2) AS avg_distance,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY distance_category
ORDER BY avg_delivery_time DESC;


-- 6. PEAK HOUR IMPACT
SELECT
    Peak_Hour,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Peak_Hour
ORDER BY avg_delivery_time DESC;


-- 7. TIME OF DAY
SELECT
    Time_of_Day,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Time_of_Day
ORDER BY avg_delivery_time DESC;


-- 8. WEEKEND VS WEEKDAY
SELECT
    Is_Weekend,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Is_Weekend;


-- 9. VEHICLE TYPE
SELECT
    Type_of_vehicle,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Type_of_vehicle
ORDER BY avg_delivery_time;


-- 10. VEHICLE CONDITION
SELECT
    Vehicle_condition,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Vehicle_condition
ORDER BY Vehicle_condition;


-- 11. MULTIPLE DELIVERIES
SELECT
    multiple_deliveries,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY multiple_deliveries
ORDER BY multiple_deliveries;


-- 12. WEATHER IMPACT
SELECT
    Weather_conditions,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Weather_conditions
ORDER BY avg_delivery_time DESC;


-- 13. FESTIVAL IMPACT
SELECT
    Festival,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Festival;


-- 14. CITY PERFORMANCE
SELECT
    City,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance,
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating
FROM zomato_food_delivery_final_cleaned
GROUP BY City
ORDER BY avg_delivery_time DESC;


-- 15. ORDER TYPE
SELECT
    Type_of_order,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Type_of_order
ORDER BY avg_delivery_time DESC;


-- 16. DELIVERY PERSON AGE GROUP
SELECT
    CASE
        WHEN Delivery_person_Age < 25 THEN 'Under 25'
        WHEN Delivery_person_Age < 35 THEN '25-34'
        WHEN Delivery_person_Age < 45 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating
FROM zomato_food_delivery_final_cleaned
WHERE Delivery_person_Age IS NOT NULL
GROUP BY age_group
ORDER BY avg_delivery_time;


-- 17. RATING IMPACT
SELECT
    ROUND(Delivery_person_Ratings, 1) AS rating,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
WHERE Delivery_person_Ratings IS NOT NULL
GROUP BY ROUND(Delivery_person_Ratings, 1)
ORDER BY rating;


-- 18. EXTREME DELIVERY CASES
SELECT
    Extreme_Delivery,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned), 2
    ) AS order_percentage,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Extreme_Delivery
ORDER BY orders DESC;


-- 19. WEATHER + TRAFFIC COMBINATION
SELECT
    Weather_conditions,
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Weather_conditions, Road_traffic_density
HAVING COUNT(*) >= 20
ORDER BY avg_delivery_time DESC
LIMIT 10;


-- 20. TRAFFIC + DISTANCE COMBINATION
SELECT
    Road_traffic_density,
    CASE
        WHEN distance_km < 3 THEN 'Short'
        WHEN distance_km < 7 THEN 'Medium'
        WHEN distance_km < 12 THEN 'Long'
        ELSE 'Very Long'
    END AS distance_category,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY
    Road_traffic_density,
    distance_category
HAVING COUNT(*) >= 20
ORDER BY avg_delivery_time DESC
LIMIT 15;


-- 21. HIGH-RISK DELIVERY CONDITIONS
SELECT
    Road_traffic_density,
    Weather_conditions,
    Peak_Hour,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY
    Road_traffic_density,
    Weather_conditions,
    Peak_Hour
HAVING COUNT(*) >= 20
ORDER BY avg_delivery_time DESC
LIMIT 15;


-- 22. TOP 10 LONGEST DELIVERIES
SELECT
    Delivery_person_ID,
    City,
    distance_km,
    `Time_taken (min)`,
    Road_traffic_density,
    Weather_conditions,
    Type_of_vehicle
FROM zomato_food_delivery_final_cleaned
ORDER BY `Time_taken (min)` DESC
LIMIT 10;


-- 23. TOP 10 LONGEST DISTANCE ORDERS
SELECT
    Delivery_person_ID,
    City,
    distance_km,
    `Time_taken (min)`,
    Road_traffic_density,
    Weather_conditions
FROM zomato_food_delivery_final_cleaned
ORDER BY distance_km DESC
LIMIT 10;


-- 24. OVERALL FINAL KPI SUMMARY
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT Delivery_person_ID) AS delivery_persons,
    COUNT(DISTINCT City) AS cities,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance_km,
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating,
    SUM(delivery_speed = 'Fast') AS fast_deliveries,
    SUM(delivery_speed = 'Average') AS average_speed_deliveries,
    SUM(delivery_speed = 'Slow') AS slow_deliveries
FROM zomato_food_delivery_final_cleaned;
