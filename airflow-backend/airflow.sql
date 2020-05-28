-- Create user for Airflow
CREATE USER 'airflow' IDENTIFIED BY 'eirfloub!*';

-- Create database for storing Airflow metadata
CREATE DATABASE airflow;
GRANT ALL ON airflow.* TO 'airflow';