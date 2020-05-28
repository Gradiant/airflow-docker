INIT_FILE=.airflowinitialized
if [ ! -f "$INIT_FILE" ]; then
    # Create all Airflow configuration files
    airflow initdb
    rm /root/airflow/airflow.db

    # Secure the storage of connections' passwords
    python fernet.py

    # Wait until the DB is ready
    sleep 30

    # Setup the DB
    python mysqlconnect.py
    airflow initdb

    # Allow XComs to store objects bigger than 65KB
    apt update && apt install -y default-mysql-client
    mysql --host airflow-backend --user=root --password=sOmErAnDoMsTuFF --database=airflow --execute="ALTER TABLE xcom MODIFY value LONGBLOB;"
    apt remove -y default-mysql-client

    # This configuration is done only the first time
    touch "$INIT_FILE"
fi

# Run the Airflow webserver and scheduler
airflow scheduler &
airflow webserver &
wait