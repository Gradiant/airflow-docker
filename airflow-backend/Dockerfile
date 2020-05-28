# Airflow has authentication problems with MySQL 8.0+
FROM mysql:latest

# Ensures airflow database and user is created
COPY airflow.sql /docker-entrypoint-initdb.d/