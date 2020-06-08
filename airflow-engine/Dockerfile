LABEL maintainer="gbarreiro@gradiant.org" \
      organization="gradiant.org"

# Airflow seems to crash with Python 3.8, it's important to use version 3.7 instead
FROM python:3.7

# Install and setup Airflow
RUN pip3 install 'apache-airflow[mysql,crypto]' mysql-connector-python

# Configure Airflow: connect to backend
COPY airflow.sh /airflow.sh
RUN chmod +x airflow.sh
COPY fernet.py /fernet.py
COPY mysqlconnect.py /mysqlconnect.py
CMD ./airflow.sh
