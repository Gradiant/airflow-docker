from cryptography.fernet import Fernet
import configparser

# Generate a random Fernet key
fernet_key = Fernet.generate_key().decode()

# Store the key
config = configparser.ConfigParser()
config.read('/root/airflow/airflow.cfg')
config['core']['fernet_key'] = fernet_key
with open('/root/airflow/airflow.cfg', 'w') as f:
    config.write(f)
