Create DATABASE DBIS;
USE DBIS;
CREATE TABLE product_costs (
    product_name VARCHAR(100) PRIMARY KEY,
    mrp DECIMAL(10,2),
    base_production_cost DECIMAL(10,2),
    packaging_cost DECIMAL(10,2),
    logistics_cost DECIMAL(10,2),
    storage_cost DECIMAL(10,2),
    total_cost_per_unit DECIMAL(10,2)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    date DATE,
    region VARCHAR(50),
    product_name VARCHAR(100),
    units_sold INT,
    price_per_unit DECIMAL(10,2),
    revenue DECIMAL(12,2),
    promotion_flag VARCHAR(10)
);
CREATE TABLE profit_table (
    sale_id INT PRIMARY KEY,
    date DATE,
    region VARCHAR(50),
    product_name VARCHAR(100),
    units_sold INT,
    revenue DECIMAL(12,2),
    total_cost DECIMAL(12,2),
    profit DECIMAL(12,2),
    profit_margin_pct DECIMAL(6,2)
);
CREATE TABLE milk_collections (
    collection_id INT PRIMARY KEY,
    date DATE,
    supplier_id INT,
    liters_collected DECIMAL(10,2),
    fat_percent DECIMAL(5,2),
    snf_percent DECIMAL(5,2),
    temperature_on_arrival_c DECIMAL(5,2),
    quality_grade VARCHAR(10)
);
CREATE TABLE spoilage_loss_estimation (
    collection_id INT PRIMARY KEY,
    date DATE,
    supplier_id INT,
    liters_collected DECIMAL(10,2),
    temperature_on_arrival_c DECIMAL(5,2),
    spoilage_rate DECIMAL(5,4),
    spoiled_liters DECIMAL(10,2),
    loss_amount_rs DECIMAL(12,2)
);

