DROP DATABASE IF EXISTS black_friday_db;
Create DATABASE black_friday_db;


USE black_friday_db;

-- 1. Create the table structure
CREATE TABLE black_friday_data (
    User_ID INT,
    Product_ID TEXT,
    Gender TEXT,
    Age TEXT,
    Occupation INT,
    City_Category TEXT,
    Stay_In_Current_City_Years TEXT,
    Marital_Status INT,
    Product_Category_1 INT,
    Product_Category_2 TEXT,
    Product_Category_3 TEXT,
    Purchase INT
);

USE black_friday_db;
SET GLOBAL local_infile=1;
LOAD DATA LOCAL INFILE 'C:/Users/sharm/OneDrive/Attachments/Uploads/data.csv.csv'
INTO TABLE black_friday_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    User_ID,
    Product_ID,
    Gender,
    Age,
    Occupation,
    City_Category,
    Stay_In_Current_City_Years,
    Marital_Status,
    Product_Category_1,
    Product_Category_2,
    Product_Category_3,
    Purchase
);
DESCRIBE black_friday_data;

SELECT count(*) FROM black_friday_data;

-- Check for Missing Values and Nulls
Select sum(case when User_ID is null then 1 else 0 end)as missing_users,
sum(case when Product_ID is null then 1 else 0 end) as missing_products,
sum(case when Purchase is null then 1 else 0 end) as missing_purchases
from black_friday_data;

-- Double Check 268 rows are empty my data is good to go
select * from black_friday_data where User_ID = 'User_ID';

-- Check Unique Customers and Products
select count(distinct user_id)as unique_customers,
       count(distinct product_id) as unique_products
from black_friday_data;

-- Check Total Revenue and Average Purchase values
select sum(purchase) as total_revenue,
       avg(purchase) as average_purchase_amount
from black_friday_data;

-- Data Types
Describe black_friday_data;

-- Spending by Gender
select gender,count(*)as total_transactions,
sum(purchase) as total_revenue,
avg(purchase) as average_purchase_amount
from black_friday_data
Group by gender;

-- Spending by the Age Group
select Age,count(*) as total_transactions,
sum(purchase) as total_revenue,
avg(purchase) as average_purchase_amount
from black_friday_data
group by age
order by total_revenue desc;

-- Spending by City Category
select City_Category,count(*) as total_transactions,
sum(purchase) as total_revenue,
avg(purchase) as avg_purchase_amount
from black_friday_data
group by City_Category
order by total_revenue desc;
 
 -- Top 10 Products by Revenue
 Select Product_ID, count(*) as total_units_sold,
 sum(purchase) as total_revenue
 from black_friday_data
 group by Product_ID
 order by total_revenue desc
 limit 10;
 
 -- Top 10 Customers by Total Spend
 select USER_ID ,count(product_id) as items_purchase,
 sum(purchase) as total_spent
 from black_friday_data
 group by User_ID
 order by total_spent desc
 limit 10;
 
 
 -- Revenue Ranking by City Category
 -- Note : My Sql shows false warning you can run and check it thank you 
 select City_Category,total_revenue,rank()over(order by total_revenue desc) as revenue_rank
 from(
	select City_Category,sum(purchase)as total_revenue
    from black_friday_data
    group by City_Category) as city_totals;
    
    -- Purchasing Power By Occupation
 select occupation,count(*) as total_transactions,
 sum(purchase) as total_revenue,
 avg(purchase) as avg_purchase_amount
 from black_friday_data
 group by occupation
 order by total_revenue desc;
 
 
 
 
 
 
 