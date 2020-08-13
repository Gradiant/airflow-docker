# Apache Airflow in Docker Compose
[Apache Airflow](https://airflow.apache.org) is an open-source tool to programmatically author, schedule and monitor workflows. These workflows are designed in Python, and monitored, scheduled and managed with a web UI. Airflow can easily integrate with data sources like HTTP APIs, databases (MySQL, SQLite, Postgres...) and more.

For understanding in detail how Airflow is deployed using Docker Compose, read this post at [Medium](https://medium.com/gradiant-talks/deploying-apache-airflow-with-docker-compose-67eb19334f95). 

## Airflow deployment in Docker
There's an Apache Airflow image [in DockerHub](https://hub.docker.com/r/apache/airflow). We can also build our own image with the following Dockerfile:

```Dockerfile
FROM python:3.7
RUN pip3 install 'apache-airflow'
RUN airflow initdb

CMD (airflow scheduler &) && airflow webserver
```

For running the container: `docker run -it -p 8080:8080 -v :/root/airflow airflow`

## Improving performance with MySQL
By default, Airflow uses a SQLite database as a backend. This is the easiest option, but its performance is quite weak. Using a MySQL database instead would increase a lot the performance. With the Docker Compose of this repo, two containers will be deployed: `airflow-engine` with Airflow, and `airflow-backend` with MySQL. The Docker Compose file will also take care of opening the port for the Airflow web server, mapping a volume for persistance, and automatically setting up the connection of Airflow to the MySQL backend.

## Improving security with Fernet key
By default, Airflow stores all the data into the database as plaintext, including third-party services credentials. To avoid this, it's highly recommended to setup a Fernet key, which will encrypt this sensible data. The `airflow-engine/fernet.py` file takes care of this.

## Removing restrictions on XCom size
XCom is the Airflow message queue for exchanging data between Tasks. If you try to store in a XCom an object bigger than 65KB, it will crash. The `airflow-engine/airflow.sh` file takes care of this, by modifying the database structure.

## Airflow + MySQL Deployment
```bash
docker-compose build
docker-compose up
```
