USE DBIS;
SELECT DATABASE();
SHOW TABLES;
SELECT * FROM milk_collections limit 5;
SELECT * FROM sales limit 5;
SELECT * FROM spoilage_loss_estimation limit 5;
SHOW tables;

SELECT count(*) FROM sales;
SELECT COUNT(*) FROM product_costs;
SELECT COUNT(*) FROM profit_table;
SELECT COUNT(*) FROM milk_collections;
SELECT COUNT(*) FROM spoilage_loss_estimation;

ALTER TABLE sales MODIFY date VARCHAR(20);

ALTER TABLE sales MODIFY date DATE;

ALter table sales add constraint fk_sales_product foreign key (product_name) references product_costs(product_name);
show create table spoilage_loss_estimation;
ALTER TABLE product_costs modify product_name varchar(100);
SHOW CREATE TABLE product_costs;
SELECT product_name, COUNT(*) FROM product_costs GROUP BY product_name HAVING COUNT(*) > 1;
ALTER TABLE product_costs ADD PRIMARY KEY (product_name);
SELECT sale_id, COUNT(*) FROM sales GROUP BY sale_id HAVING COUNT(*) > 1;
ALTER TABLE sales ADD PRIMARY KEY (sale_id);
ALTER TABLE profit_table ADD CONSTRAINT fk_profit_sale FOREIGN KEY (sale_id) REFERENCES sales(sale_id);

SHOW CREATE TABLE profit_table;

SELECT collection_id, count(*) from milk_collections group by collection_id having count(8) >1;
ALTER TABLE milk_collections ADD PRIMARY KEY (collection_id);

ALTER TABLE spoilage_loss_estimation ADD CONSTRAINT fk_spoilage_collection FOREIGN KEY (collection_id) REFERENCES milk_collections(collection_id);
SELECT s.sale_id, s.product_name, p.total_cost_per_unit FROM sales s JOIN product_costs p ON s.product_name = p.product_name LIMIT 10;
Create INDEX idx_sales_product ON sales(product_name);
desc sales;
ALTER TABLE spoilage_loss_estimation MODIFY date DATE;
CREATE INDEX idx_profit_date ON profit_table(date);
SELECT * from profit_table;
CREATE INDEX idx_spoilage_supplier ON spoilage_loss_estimation(supplier_id);
SELECT product_name, SUM(profit) AS total_profit FROM profit_table GROUP BY product_name ORDER BY total_profit DESC LIMIT 5;

-- DATA CLEANING AND VALIDATION:-
-- CHECK DUPLICATE SALES RECORDS:
SELECT sale_id, COUNT(*) AS duplicate_count
	FROM sales
	GROUP BY sale_id
	HAVING COUNT(*) > 1;

-- FIND NULL VALUES IN CRITICAL COLUMNS:
SELECT * FROM milk_collections WHERE supplier_id IS NULL OR liters_collected IS NULL OR fat_percent IS NULL;

-- DETECT NEGATIVE OR INVALID VALUES:
SELECT * FROM sales WHERE units_sold <= 0 OR price_per_unit <= 0;

-- STANDARDIZE DATE FORMAT( IF STORES IN TEXT):
UPDATE sales SET date = STR_TO_DATE(date, '%d/%m/%y');
SET SQL_SAFE_UPDATES = 1;

-- REMOVE EXACT DUPLICATE ROWS (USING CTE):
DELETE s1 FROM sales s1 INNER JOIN sales s2 WHERE s1.sale_id = s2.sale_id AND s1.id > s2.id;

desc product_costs;
    
-- JOINS & RELATIONSHIP ANALYSIS:-
-- SALES WITH PRODUCT COST:
SELECT 
    s.sale_id,
    s.product_name,
    s.revenue,
    (s.units_sold * p.total_cost_per_unit) AS total_cost,
    s.revenue - (s.units_sold * p.total_cost_per_unit) AS profit
	FROM sales s
	JOIN product_costs p
	ON s.product_name = p.product_name;

-- PROFIT PER SALE:
SELECT s.sale_id,
       SUM(s.units_sold * s.price_per_unit) AS revenue,
       SUM(s.units_sold * p.total_cost_per_unit) AS cost,
       SUM(s.units_sold * s.price_per_unit) -
       SUM(s.units_sold * p.total_cost_per_unit) AS profit
	FROM sales s
	JOIN product_costs p
	ON s.product_name = p.product_name
	GROUP BY s.sale_id;

-- MILK COLLECTION WITH SPOILAGE DATA:
SELECT m.collection_id,
       m.liters_collected,
       s.spoilage_rate,
       (m.liters_collected * s.spoilage_rate/100) AS spoilage_liters
	FROM milk_collections m
	LEFT JOIN spoilage_loss_estimation s
	ON m.collection_id = s.collection_id;

-- MONTHLY SALES REVENUE:
SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(units_sold * price_per_unit) AS monthly_revenue
	FROM sales
	GROUP BY month
	ORDER BY month;

-- TOP 5 BEST SELLING PRODUCTS:
SELECT product_name,
       SUM(units_sold) AS total_sold
	FROM sales
	GROUP BY product_name
	ORDER BY total_sold DESC
	LIMIT 5;

-- ADVANCED ANALYSIS:-
-- RANK PRODUCTS BY REVENUE:
SELECT product_name,
       SUM(units_sold * price_per_unit) AS revenue,
       RANK() OVER (ORDER BY SUM(units_sold * price_per_unit) DESC) AS revenue_rank
	FROM sales
	GROUP BY product_name;

-- RUNNING TOTAL REVENUE:
SELECT date,
       SUM(units_sold * price_per_unit) AS daily_revenue,
       SUM(SUM(units_sold * price_per_unit)) OVER (ORDER BY date) AS running_total
	FROM sales
	GROUP BY date;

-- MOVING AVERAGE (7-DAY):

SELECT date,
       AVG(units_sold * price_per_unit) 
       OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
       AS moving_avg
	FROM sales;

-- SUPPLIER PERFORMANCE RANKING:
SELECT supplier_id,
       SUM(liters_collected) AS total_milk,
       DENSE_RANK() OVER (ORDER BY SUM(liters_collected) DESC) AS rank_position
	FROM milk_collections
	GROUP BY supplier_id;

-- SUBQUERIES & CTEs:-
-- PRODUCTS WITH ABOVE AVERAGE SALES:
SELECT product_name
FROM sales
GROUP BY product_name
HAVING SUM(units_sold) >
(
   SELECT AVG(total_qty)
   FROM (
       SELECT SUM(units_sold) AS total_qty
       FROM sales
       GROUP BY product_name
   ) AS sub
);

-- CTE: High Profit Sales:

WITH profit_cte AS (
    SELECT s.sale_id,
           SUM(s.units_sold * s.price_per_unit) -
           SUM(s.units_sold * p.total_cost_per_unit) AS profit
    FROM sales s
    JOIN product_costs p
    ON s.product_name = p.product_name
    GROUP BY s.sale_id
)
SELECT *
FROM profit_cte
WHERE profit > 1000;

-- Detect Outlier Milk Collections:
SELECT *
FROM milk_collections
WHERE liters_collected >
(
    SELECT AVG(liters_collected) + 
           2 * STDDEV(liters_collected)
    FROM milk_collections
);


-- PERFORMANCE OPTIMIZATION:-
-- CREATE INDEX ON SLAES DATA:
CREATE INDEX idx_sales_date ON sales(date);

-- CREATE COMPOSITE INDEX:
CREATE INDEX idx_sales_product_date 
ON sales(product_name, date);

-- DATA MODIFICATION & BUSINESS LOGIC:-
-- INCRESE PRICE BY 5%:
UPDATE sales
SET price_per_unit = price_per_unit * 1.05
WHERE date >= '2024-10-01';

-- ADD PROFIT COLUMN:
ALTER TABLE profit_table
ADD COLUMN profit_margin DECIMAL(10,2);


SET SQL_SAFE_UPDATES = 1;

-- UPDATE PROFIT MARGIN:
UPDATE profit_table
SET profit_margin = (profit / revenue) * 100;

-- BUSINESS INSIGHTS:-
-- DAILY REVENUE TREND:
SELECT date,
       SUM(units_sold * price_per_unit) AS revenue
FROM sales
GROUP BY date
ORDER BY date;

-- PRODUCT CONTRIBUTION PERCENTAGE:
SELECT product_name,
       SUM(units_sold * price_per_unit) AS revenue,
       SUM(units_sold * price_per_unit) /
       (SELECT SUM(units_sold * price_per_unit) FROM sales) * 100
       AS contribution_percent
FROM sales
GROUP BY product_name;

-- BEST PERFORMING MONTH:
SELECT DATE_FORMAT(date, '%Y-%m') AS month,
       SUM(units_sold * price_per_unit) AS revenue
FROM sales
GROUP BY month
ORDER BY revenue DESC LIMIT 1;

-- AVERAGE FAT % BY SUPPLIER:
SELECT supplier_id,
       AVG(fat_percent) AS avg_fat
FROM milk_collections
GROUP BY supplier_id;

-- Spoilage Impact on Total Milk:
SELECT SUM(m.liters_collected) AS total_milk,
       SUM(m.liters_collected * s.spoilage_rate/100) AS total_spoilage
FROM milk_collections m
JOIN spoilage_loss_estimation s
ON m.collection_id = s.collection_id;

-- ADVANCED INSIGHT QUERIES:-
-- Revenue Growth % Month Over Month:
SELECT month,
       revenue,
       (revenue - LAG(revenue) OVER (ORDER BY month)) /
       LAG(revenue) OVER (ORDER BY month) * 100 AS growth_percent
FROM (
   SELECT DATE_FORMAT(date, '%Y-%m') AS month,
          SUM(units_sold * price_per_unit) AS revenue
   FROM sales
   GROUP BY month
) t;


-- IDENTIFY SEASONAL PEAK:
SELECT MONTH(date) AS month,
       SUM(units_sold) AS total_sales
FROM sales
GROUP BY MONTH(date)
ORDER BY total_sales DESC;


-- Most Profitable Product:
SELECT s.product_name,
       SUM(s.units_sold * s.price_per_unit) -
       SUM(s.units_sold * p.total_cost_per_unit) AS profit
FROM sales s
JOIN product_costs p
ON s.product_name = p.product_name
GROUP BY s.product_name
ORDER BY profit DESC;

-- CORRELATION INSIGHTS (FAT VS OUALITY GRADE APPROX):
SELECT fat_percent,
       COUNT(*) AS count_records
FROM milk_collections
GROUP BY fat_percent
ORDER BY fat_percent;
