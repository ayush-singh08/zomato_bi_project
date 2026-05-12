SELECT ROUND(AVG(rating), 2) AS avg_rating
FROM zomato_cleaned_data;

SELECT COUNT(DISTINCT name) AS namess
FROM zomato_cleaned_data;

SELECT ROUND(AVG(cost_for_two), 2) AS avg_cost
FROM zomato_cleaned_data;

SELECT
    location,
    ROUND(AVG(rating), 2) AS avg_rating,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY location
ORDER BY avg_rating DESC
LIMIT 10;

# Most Popular Restaurant Types
SELECT
    restaurant_type,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY restaurant_type
ORDER BY total_restaurants DESC;

# online order impact
SELECT
    online_order,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(votes), 0) AS avg_votes,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY online_order;

# Most Common Cuisine Types
SELECT
    cuisines,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY cuisines
ORDER BY total_restaurants DESC
LIMIT 10;