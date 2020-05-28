# Apache Airflow in Docker Compose
[Apache Airflow](https://airflow.apache.org) is an open-source tool to programmatically author, schedule and monitor workflows. These workflows are designed in Python, and monitored, scheduled and managed with a web UI. Airflow can easily integrate with data sources like HTTP APIs, databases (MySQL, SQLite, Postgres...) and more.

## Airflow deployment in Docker
There's no official image in DockerHub for Apache Airflow. With a Dockerfile with the following lines it would be enough for deploying Airflow:

```Dockerfile
FROM python:3.7
RUN pip3 install 'apache-airflow'
RUN initdb

CMD (airflow scheduler &) && (airflow webserver &) && wait
```

Note that when running the container, port 8080 has to be opened and directory /root/airflow mapped to a volume.

## Improving performance with MySQL
By default, Airflow uses a SQLite database as a backend. This is the easiest option, but its performance is quite weak. Using a MySQL database instead would increase a lot the performance. With the Docker Compose of this repo, two containers will be deployed: `airflow-engine` with Airflow, and `airflow-backend` with MySQL. The Docker Compose file will also take care of opening the port for the Airflow web server, mapping a volume for persistance, and automatically setting up the connection of Airflow to the MySQL backend.

## Deployment
```bash
docker-compose build
docker-compose up
```
