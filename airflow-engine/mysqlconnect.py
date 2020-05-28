import configparser

# Open the Airflow config file
config = configparser.ConfigParser()
config.read('/root/airflow/airflow.cfg')

# Store the URL of the MySQL database
config['core']['sql_alchemy_conn'] = 'mysql://airflow:eirfloub!*@airflow-backend/airflow'
config['core']['executor'] = 'LocalExecutor'
with open('/root/airflow/airflow.cfg', 'w') as f:
    config.write(f)