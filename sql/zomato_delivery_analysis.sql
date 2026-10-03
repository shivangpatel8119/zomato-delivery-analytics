USE zomato_delivery;
-- total orders 
SELECT COUNT(*) AS total_rows
FROM zomato_food_delivery_final_cleaned;

-- Duplicate records
SELECT 
    Delivery_person_ID,
    Order_Date,
    Time_Orderd,
    Restaurant_latitude,
    Restaurant_longitude,
    Delivery_location_latitude,
    Delivery_location_longitude,
    COUNT(*) AS duplicate_count
FROM zomato_food_delivery_final_cleaned
GROUP BY 
    Delivery_person_ID,
    Order_Date,
    Time_Orderd,
    Restaurant_latitude,
    Restaurant_longitude,
    Delivery_location_latitude,
    Delivery_location_longitude
HAVING COUNT(*) > 1;

-- Missing values ka overview

SELECT
    SUM(Delivery_person_ID IS NULL) AS missing_person_id,
    SUM(Delivery_person_Age IS NULL) AS missing_age,
    SUM(Delivery_person_Ratings IS NULL) AS missing_rating,
    SUM(Order_Date IS NULL) AS missing_order_date,
    SUM(Time_Orderd IS NULL) AS missing_order_time,
    SUM(Weather_conditions IS NULL) AS missing_weather,
    SUM(Road_traffic_density IS NULL) AS missing_traffic,
    SUM(Type_of_order IS NULL) AS missing_order_type,
    SUM(Type_of_vehicle IS NULL) AS missing_vehicle,
    SUM(Festival IS NULL) AS missing_festival,
    SUM(City IS NULL) AS missing_city,
    SUM(`Time_taken (min)` IS NULL) AS missing_delivery_time,
    SUM(distance_km IS NULL) AS missing_distance
FROM zomato_food_delivery_final_cleaned;

-- Q4 Average delivery time

SELECT
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned;

-- Q5. Minimum and maximum delivery time
SELECT
    MIN(`Time_taken (min)`) AS minimum_time,
    MAX(`Time_taken (min)`) AS maximum_time,
    ROUND(AVG(`Time_taken (min)`), 2) AS average_time
FROM zomato_food_delivery_final_cleaned;

-- Q6. Average distance

SELECT
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned;

-- Q7. Average delivery-person rating
SELECT
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating
FROM zomato_food_delivery_final_cleaned;

-- Q8. Delivery performance distribution
	SELECT
    Delivery_Performance,
    COUNT(*) AS orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM zomato_food_delivery_final_cleaned),
        2
    ) AS percentage
FROM zomato_food_delivery_final_cleaned
GROUP BY Delivery_Performance
ORDER BY orders DESC;

-- Q9. Extreme delivery cases

SELECT
    Extreme_Delivery,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY Extreme_Delivery
ORDER BY orders DESC;

-- Q10. Average delivery time by performance

SELECT
    Delivery_Performance,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Delivery_Performance
ORDER BY avg_delivery_time;

-- Q11. Delivery performance by traffic density
SELECT
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Q12. Traffic + performance

SELECT
    Road_traffic_density,
    Delivery_Performance,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY
    Road_traffic_density,
    Delivery_Performance
ORDER BY
    Road_traffic_density,
    orders DESC;
    
    -- Q13. Peak hour + traffic
    SELECT
    Peak_Hour,
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Peak_Hour, Road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Q14. Time of day analysis

SELECT
    Time_of_Day,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Time_of_Day
ORDER BY avg_delivery_time DESC;

-- Q15. Hour-wise delivery analysis

SELECT
    Order_Hour,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Order_Hour
ORDER BY Order_Hour;

-- Q16. Peak vs non-peak

SELECT
    Peak_Hour,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Peak_Hour;

-- Q17. Weekday vs weekend
SELECT
    Is_Weekend,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Is_Weekend;

-- Q18. Day-wise analysis

SELECT
    Day_Name,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Day_Name
ORDER BY avg_delivery_time DESC;

-- Q19. Distance vs delivery time
SELECT
    ROUND(AVG(distance_km), 2) AS avg_distance,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned;

-- Q20. Create distance buckets
SELECT
    CASE
        WHEN distance_km < 3 THEN 'Short'
        WHEN distance_km < 7 THEN 'Medium'
        WHEN distance_km < 12 THEN 'Long'
        ELSE 'Very Long'
    END AS distance_category,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY distance_category
ORDER BY avg_delivery_time;

-- Q21. Vehicle type performance
SELECT
    Type_of_vehicle,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Type_of_vehicle
ORDER BY avg_delivery_time;

-- Q22. Vehicle condition
SELECT
    Vehicle_condition,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Vehicle_condition
ORDER BY Vehicle_condition;

-- Q23. Vehicle condition + performance

SELECT
    Vehicle_condition,
    Delivery_Performance,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY Vehicle_condition, Delivery_Performance
ORDER BY Vehicle_condition, orders DESC;

-- Q24. Multiple deliveries ka impact

SELECT
    multiple_deliveries,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY multiple_deliveries
ORDER BY multiple_deliveries;

-- Q25. Multiple deliveries vs performance

SELECT
    multiple_deliveries,
    Delivery_Performance,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY multiple_deliveries, Delivery_Performance
ORDER BY multiple_deliveries, orders DESC;

-- Q26. Weather conditions ka impact

SELECT
    Weather_conditions,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Weather_conditions
ORDER BY avg_delivery_time DESC;

-- Q27. Weather + traffic

SELECT
    Weather_conditions,
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Weather_conditions, Road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Q28. Festival vs non-festival

SELECT
    Festival,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Festival;

-- Q29. Festival + traffic

SELECT
    Festival,
    Road_traffic_density,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
GROUP BY Festival, Road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Q30. City-wise performance

SELECT
    City,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY City
ORDER BY avg_delivery_time DESC;

-- Q31. City + delivery performance
SELECT
    City,
    Delivery_Performance,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY City, Delivery_Performance
ORDER BY City, orders DESC;

-- Q32. Type of order

SELECT
    Type_of_order,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance
FROM zomato_food_delivery_final_cleaned
GROUP BY Type_of_order
ORDER BY avg_delivery_time DESC;

-- Q33. Age groups
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
GROUP BY age_group
ORDER BY avg_delivery_time;

-- Q34. Rating vs delivery time

SELECT
    ROUND(Delivery_person_Ratings, 1) AS rating,
    COUNT(*) AS orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time
FROM zomato_food_delivery_final_cleaned
WHERE Delivery_person_Ratings IS NOT NULL
GROUP BY ROUND(Delivery_person_Ratings, 1)
ORDER BY rating;

-- Q35. Top 10 longest delivery orders
SELECT
    Delivery_person_ID,
    City,
    distance_km,
    `Time_taken (min)`,
    Weather_conditions,
    Road_traffic_density,
    Type_of_vehicle
FROM zomato_food_delivery_final_cleaned
ORDER BY `Time_taken (min)` DESC
LIMIT 10;

-- Q36. Top 10 longest-distance orders

SELECT
    Delivery_person_ID,
    City,
    distance_km,
    `Time_taken (min)`,
    Road_traffic_density
FROM zomato_food_delivery_final_cleaned
ORDER BY distance_km DESC
LIMIT 10;

-- Q37. High distance + high delivery time

SELECT
    City,
    distance_km,
    `Time_taken (min)`,
    Road_traffic_density,
    Weather_conditions,
    Type_of_vehicle
FROM zomato_food_delivery_final_cleaned
WHERE distance_km > 10
  AND `Time_taken (min)` > 40
ORDER BY `Time_taken (min)` DESC;

-- Q38. Traffic + distance + delivery time
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
ORDER BY avg_delivery_time DESC;

-- Delivery Speed
SELECT
    delivery_speed,
    COUNT(*) AS orders
FROM zomato_food_delivery_final_cleaned
GROUP BY delivery_speed
ORDER BY orders DESC;
-- Q39. City ke andar delivery time ranking
SELECT
    City,
    Delivery_person_ID,
    `Time_taken (min)`,
    RANK() OVER (
        PARTITION BY City
        ORDER BY `Time_taken (min)` DESC
    ) AS delivery_time_rank
FROM zomato_food_delivery_final_cleaned;

-- Q40. City-wise top 3 longest deliveries

	WITH ranked_deliveries AS (
    SELECT
        City,
        Delivery_person_ID,
        `Time_taken (min)`,
        RANK() OVER (
            PARTITION BY City
            ORDER BY `Time_taken (min)` DESC
        ) AS delivery_rank
    FROM zomato_food_delivery_final_cleaned
)
SELECT *
FROM ranked_deliveries
WHERE delivery_rank <= 3;

-- Kpi cards 
SELECT
    COUNT(*) AS total_orders,
    ROUND(AVG(`Time_taken (min)`), 2) AS avg_delivery_time,
    ROUND(MIN(`Time_taken (min)`), 2) AS min_delivery_time,
    ROUND(MAX(`Time_taken (min)`), 2) AS max_delivery_time,
    ROUND(AVG(distance_km), 2) AS avg_distance,
    ROUND(AVG(Delivery_person_Ratings), 2) AS avg_rating,
    COUNT(DISTINCT Delivery_person_ID) AS unique_delivery_persons,
    COUNT(DISTINCT City) AS cities
FROM zomato_food_delivery_final_cleaned;


