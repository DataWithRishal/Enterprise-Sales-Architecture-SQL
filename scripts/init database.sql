/*
================================================================================
PROJECT      : Enterprise Sales Data Warehouse (EDW)
ARCHITECT    : Data With RISHAL 
VERSION      : 1.0
ENVIRONMENT  : Development / Production Initializer
DESCRIPTION  : 
    This script initializes a high-performance 3-tier Medallion Architecture. 
    It enforces physical data isolation, establishes security protocols, 
    and prepares the environment for ACID-compliant transformations.
================================================================================
*/

-- 1. ENVIRONMENT CLEANUP (The "Fresh Start" Protocol)
-- Ensures the environment is deterministic for every deployment.
DROP DATABASE IF EXISTS enterprise_bronze;
DROP DATABASE IF EXISTS enterprise_silver;
DROP DATABASE IF EXISTS enterprise_gold;

-- 2. PHYSICAL LAYER INITIALIZATION
-- Bronze: Immutable Raw Landing Zone
-- Silver: Quality-Enforced Integration Zone
-- Gold  : Analytical Consumption Zone (Star Schema)
CREATE DATABASE enterprise_bronze;
CREATE DATABASE enterprise_silver;
CREATE DATABASE enterprise_gold;

-- 3. SECURITY & ACCESS GOVERNANCE
-- Creating a dedicated 'Pipeline User' rather than using 'Root'.
-- This demonstrates knowledge of Enterprise Security Standards.
DROP USER IF EXISTS 'edw_pipeline_user'@'localhost';
CREATE USER 'edw_pipeline_user'@'localhost' IDENTIFIED BY 'EDW_Secure_Pass_2026';

-- Granting scoped permissions (Principle of Least Privilege)
GRANT ALL PRIVILEGES ON enterprise_bronze.* TO 'edw_pipeline_user'@'localhost';
GRANT ALL PRIVILEGES ON enterprise_silver.* TO 'edw_pipeline_user'@'localhost';
GRANT ALL PRIVILEGES ON enterprise_gold.* TO 'edw_pipeline_user'@'localhost';

-- 4. DEPLOYMENT METADATA LOGGING
-- Every professional warehouse tracks its own deployment history.
USE enterprise_gold;
CREATE TABLE IF NOT EXISTS deployment_logs (
    deployment_id INT AUTO_INCREMENT PRIMARY KEY,
    deployment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    architect_name VARCHAR(100),
    version_tag VARCHAR(10),
    status VARCHAR(20)
);

INSERT INTO deployment_logs (architect_name, version_tag, status)
VALUES ('Data With RISHAL', '1.0', 'SUCCESSFUL');

-- 5. SYSTEM VERIFICATION
SHOW DATABASES LIKE 'enterprise%';
SELECT * FROM deployment_logs;
