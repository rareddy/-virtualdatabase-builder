CREATE DATABASE sample OPTIONS (ANNOTATION 'Sample VDB');
USE DATABASE sample;

CREATE SERVER sampledb FOREIGN DATA WRAPPER h2;

CREATE SCHEMA accounts SERVER sampledb;

-- H2 converts the schema name to capital case
IMPORT FOREIGN SCHEMA PUBLIC FROM SERVER sampledb INTO accounts;