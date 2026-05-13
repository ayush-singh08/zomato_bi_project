-- =========================================
-- RESTAURANT BUSINESS INTELLIGENCE DASHBOARD
-- =========================================

-- =========================================
-- DATABASE SELECTION
-- =========================================
USE zomato_db;

-- =========================================
-- PREVIEW DATA
-- =========================================
SELECT *
FROM zomato_cleaned_data
LIMIT 10;

-- =========================================
-- TOTAL RECORDS
-- =========================================
SELECT COUNT(*) AS total_records
FROM zomato_cleaned_data;

-- =========================================
-- KPI QUERIES
-- =========================================

-- Total Restaurant Listings
SELECT COUNT(name) AS total_restaurant_listings
FROM zomato_cleaned_data;

-- Unique Restaurant Names
SELECT COUNT(DISTINCT name) AS unique_restaurants
FROM zomato_cleaned_data;

-- Average Restaurant Rating
SELECT ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data;

-- Average Cost for Two
SELECT ROUND(AVG(cost_for_two), 2) AS average_cost_for_two
FROM zomato_cleaned_data;

-- Total Customer Votes
SELECT SUM(votes) AS total_votes
FROM zomato_cleaned_data;

-- =========================================
-- LOCATION ANALYSIS
-- =========================================

-- Restaurant Distribution by Location
SELECT
    location,
    COUNT(name) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY location
ORDER BY total_restaurants DESC;

-- Best Rated Locations
SELECT
    location,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY location
ORDER BY average_rating DESC
LIMIT 10;

-- Locations with Highest Customer Votes
SELECT
    location,
    SUM(votes) AS total_votes
FROM zomato_cleaned_data
GROUP BY location
ORDER BY total_votes DESC
LIMIT 10;

-- =========================================
-- ONLINE ORDER ANALYSIS
-- =========================================

-- Online Ordering Distribution
SELECT
    online_order,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY online_order;

-- Online Ordering Impact on Ratings
SELECT
    online_order,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(votes), 0) AS average_votes
FROM zomato_cleaned_data
GROUP BY online_order;

-- =========================================
-- TABLE BOOKING ANALYSIS
-- =========================================

-- Table Booking Distribution
SELECT
    book_table,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY book_table;

-- Table Booking Impact
SELECT
    book_table,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(cost_for_two), 0) AS average_cost
FROM zomato_cleaned_data
GROUP BY book_table;

-- =========================================
-- RESTAURANT TYPE ANALYSIS
-- =========================================

-- Most Common Restaurant Types
SELECT
    restaurant_type,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY restaurant_type
ORDER BY total_restaurants DESC;

-- Restaurant Type vs Ratings
SELECT
    restaurant_type,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY restaurant_type
ORDER BY average_rating DESC;

-- =========================================
-- CUISINE ANALYSIS
-- =========================================

-- Most Popular Cuisines
SELECT
    cuisines,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY cuisines
ORDER BY total_restaurants DESC
LIMIT 10;

-- Highest Rated Cuisines
SELECT
    cuisines,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY cuisines
HAVING COUNT(*) > 20
ORDER BY average_rating DESC
LIMIT 10;

-- =========================================
-- COST ANALYSIS
-- =========================================

-- Cost Category Distribution
SELECT
    cost_category,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY cost_category;

-- Cost Category vs Ratings
SELECT
    cost_category,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(votes), 0) AS average_votes
FROM zomato_cleaned_data
GROUP BY cost_category;

-- =========================================
-- RATING ANALYSIS
-- =========================================

-- Rating Category Distribution
SELECT
    rating_category,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY rating_category;

-- Highest Rated Restaurants
SELECT
    name,
    rating,
    votes,
    location
FROM zomato_cleaned_data
WHERE votes > 500
ORDER BY rating DESC
LIMIT 10;

-- Most Popular Restaurants by Votes
SELECT
    name,
    votes,
    rating,
    location
FROM zomato_cleaned_data
ORDER BY votes DESC
LIMIT 10;

-- =========================================
-- ADVANCED BUSINESS INSIGHTS
-- =========================================

-- Relationship Between Cost and Ratings
SELECT
    cost_category,
    ROUND(AVG(cost_for_two), 0) AS average_cost,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY cost_category;

-- Customer Engagement Analysis
SELECT
    restaurant_type,
    ROUND(AVG(votes), 0) AS average_votes,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY restaurant_type
ORDER BY average_votes DESC;

-- Top Performing Restaurants
SELECT
    name,
    location,
    rating,
    votes,
    cost_for_two
FROM zomato_cleaned_data
WHERE rating >= 4.5
AND votes >= 500
ORDER BY rating DESC, votes DESC;

-- Premium Restaurants Analysis
SELECT
    name,
    location,
    cuisines,
    rating,
    cost_for_two
FROM zomato_cleaned_data
WHERE cost_category = 'Premium'
ORDER BY rating DESC
LIMIT 20;

-- Budget Friendly Highly Rated Restaurants
SELECT
    name,
    location,
    cuisines,
    rating,
    cost_for_two
FROM zomato_cleaned_data
WHERE cost_category = 'Budget'
AND rating >= 4
ORDER BY rating DESC
LIMIT 20;

-- =========================================
-- DATA QUALITY CHECKS
-- =========================================

-- Check Missing Values
SELECT
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS missing_rating,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS missing_location
FROM zomato_cleaned_data;

-- Check Duplicate Restaurants
SELECT
    name,
    location,
    COUNT(*) AS duplicate_count
FROM zomato_cleaned_data
GROUP BY name, location
HAVING COUNT(*) > 1;

-- =========================================
-- ADVANCED SQL QUERIES
-- =========================================

-- =========================================
-- LOCATION PERFORMANCE ANALYSIS
-- =========================================

-- Top 5 Locations with Highest Average Ratings
SELECT
    location,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY location
HAVING COUNT(*) > 50
ORDER BY average_rating DESC
LIMIT 5;

-- Locations with Highest Average Cost
SELECT
    location,
    ROUND(AVG(cost_for_two), 0) AS average_cost
FROM zomato_cleaned_data
GROUP BY location
ORDER BY average_cost DESC
LIMIT 10;

-- Most Competitive Restaurant Locations
SELECT
    location,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY location
ORDER BY restaurant_count DESC
LIMIT 10;

-- =========================================
-- CUSTOMER BEHAVIOR ANALYSIS
-- =========================================

-- Restaurants with High Votes but Low Ratings
SELECT
    name,
    location,
    votes,
    rating
FROM zomato_cleaned_data
WHERE votes > 1000
AND rating < 3.5
ORDER BY votes DESC;

-- Restaurants with Low Votes but High Ratings
SELECT
    name,
    location,
    votes,
    rating
FROM zomato_cleaned_data
WHERE votes < 100
AND rating >= 4.5
ORDER BY rating DESC;

-- Average Votes by Rating Category
SELECT
    rating_category,
    ROUND(AVG(votes), 0) AS average_votes
FROM zomato_cleaned_data
GROUP BY rating_category;

-- =========================================
-- ONLINE ORDER & DELIVERY ANALYSIS
-- =========================================

-- Online Order vs Offline Restaurant Ratings
SELECT
    online_order,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(cost_for_two), 0) AS average_cost,
    SUM(votes) AS total_votes
FROM zomato_cleaned_data
GROUP BY online_order;

-- Percentage of Restaurants Offering Online Orders
SELECT
    online_order,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_cleaned_data),
        2
    ) AS percentage
FROM zomato_cleaned_data
GROUP BY online_order;

-- =========================================
-- CUISINE INSIGHTS
-- =========================================

-- Average Cost by Cuisine
SELECT
    cuisines,
    ROUND(AVG(cost_for_two), 0) AS average_cost
FROM zomato_cleaned_data
GROUP BY cuisines
HAVING COUNT(*) > 20
ORDER BY average_cost DESC
LIMIT 15;

-- Cuisine Popularity by Votes
SELECT
    cuisines,
    SUM(votes) AS total_votes
FROM zomato_cleaned_data
GROUP BY cuisines
ORDER BY total_votes DESC
LIMIT 10;

-- Most Affordable Highly Rated Cuisines
SELECT
    cuisines,
    ROUND(AVG(cost_for_two), 0) AS average_cost,
    ROUND(AVG(rating), 2) AS average_rating
FROM zomato_cleaned_data
GROUP BY cuisines
HAVING average_rating >= 4
ORDER BY average_cost ASC
LIMIT 10;

-- =========================================
-- RESTAURANT PERFORMANCE ANALYSIS
-- =========================================

-- Top Restaurants in Each Location
SELECT
    location,
    name,
    rating,
    votes
FROM zomato_cleaned_data z1
WHERE rating = (
    SELECT MAX(rating)
    FROM zomato_cleaned_data z2
    WHERE z1.location = z2.location
)
ORDER BY location;

-- Restaurants with Above Average Ratings
SELECT
    name,
    location,
    rating
FROM zomato_cleaned_data
WHERE rating > (
    SELECT AVG(rating)
    FROM zomato_cleaned_data
)
ORDER BY rating DESC;

-- Restaurants with Highest Cost but Low Ratings
SELECT
    name,
    location,
    cost_for_two,
    rating
FROM zomato_cleaned_data
WHERE cost_for_two > 2000
AND rating < 3.5
ORDER BY cost_for_two DESC;

-- =========================================
-- COST & PRICING ANALYSIS
-- =========================================

-- Average Rating by Cost Range
SELECT
    cost_category,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY cost_category;

-- Percentage Distribution of Cost Categories
SELECT
    cost_category,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_cleaned_data),
        2
    ) AS percentage_distribution
FROM zomato_cleaned_data
GROUP BY cost_category;

-- =========================================
-- TABLE BOOKING ANALYSIS
-- =========================================

-- Percentage of Restaurants Offering Table Booking
SELECT
    book_table,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM zomato_cleaned_data),
        2
    ) AS percentage
FROM zomato_cleaned_data
GROUP BY book_table;

-- Premium Restaurants with Table Booking
SELECT
    name,
    location,
    cuisines,
    rating,
    cost_for_two
FROM zomato_cleaned_data
WHERE book_table = 'Yes'
AND cost_category = 'Premium'
ORDER BY rating DESC;

-- =========================================
-- RANKING & WINDOW FUNCTIONS
-- =========================================

-- Rank Restaurants by Ratings
SELECT
    DISTINCT name,
    location,
    rating,
    RANK() OVER (ORDER BY rating DESC) AS restaurant_rank
FROM zomato_cleaned_data;

-- Top 3 Restaurants in Each Location
SELECT *
FROM (
    SELECT
        name,
        location,
        rating,
        ROW_NUMBER() OVER (
            PARTITION BY location
            ORDER BY rating DESC
        ) AS rank_in_location
    FROM zomato_cleaned_data
) ranked_restaurants
WHERE rank_in_location <= 3;

-- =========================================
-- TREND & SEGMENTATION ANALYSIS
-- =========================================

-- Restaurant Segmentation by Ratings
SELECT
    CASE
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 4 THEN 'Very Good'
        WHEN rating >= 3 THEN 'Average'
        ELSE 'Poor'
    END AS rating_segment,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY rating_segment;

-- Customer Engagement Segmentation
SELECT
    CASE
        WHEN votes >= 1000 THEN 'High Engagement'
        WHEN votes >= 300 THEN 'Medium Engagement'
        ELSE 'Low Engagement'
    END AS engagement_level,
    COUNT(*) AS total_restaurants
FROM zomato_cleaned_data
GROUP BY engagement_level;

-- =========================================
-- BUSINESS RECOMMENDATION QUERIES
-- =========================================

-- Best Locations for Opening Premium Restaurants
SELECT
    location,
    ROUND(AVG(rating), 2) AS average_rating,
    ROUND(AVG(cost_for_two), 0) AS average_cost,
    SUM(votes) AS total_votes
FROM zomato_cleaned_data
GROUP BY location
HAVING average_rating >= 4
ORDER BY total_votes DESC
LIMIT 10;

-- Locations with Strong Online Ordering Demand
SELECT
    location,
    COUNT(*) AS online_order_restaurants
FROM zomato_cleaned_data
WHERE online_order = 'Yes'
GROUP BY location
ORDER BY online_order_restaurants DESC
LIMIT 10;

-- Best Budget Restaurants
SELECT
    name,
    location,
    cuisines,
    rating,
    cost_for_two
FROM zomato_cleaned_data
WHERE cost_for_two <= 500
AND rating >= 4.2
ORDER BY rating DESC, votes DESC
LIMIT 20;