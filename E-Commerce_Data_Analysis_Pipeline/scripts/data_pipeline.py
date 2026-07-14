# Importing the core libraries required for the project
import pandas as pd
from sqlalchemy import create_engine
import urllib

# Defining the core configuration parameters for the database connection and data source
SERVER_NAME = r'.\SQLEXPRESS'
DATABASE_NAME = 'E-CommerceDB'
DATA_FILE_PATH = 'data.csv'

# Configuring the SQL Server database connection and initializing the database engine
CONNECTION_STRING = urllib.parse.quote_plus(
    f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER_NAME};DATABASE={DATABASE_NAME};Trusted_Connection=yes;'
)
engine = create_engine(f"mssql+pyodbc:///?odbc_connect={CONNECTION_STRING}", fast_executemany=True)

try:
    print("--- Process Started ---")

    # Loading the dataset and initiating the data preprocessing stage
    df = pd.read_csv(DATA_FILE_PATH, encoding='ISO-8859-1')

    df.columns = [c.replace(' ', '_') for c in df.columns]

    df.dropna(subset=['CustomerID'], inplace=True)
    print("Data preprocessing completed successfully. Initiating data transfer....")

    # Transferring the cleaned dataset to the SQL Server database
    df.to_sql('Sales', engine, if_exists='replace', index=False, chunksize=50000)

    print("--- Data Transfer Process Completed Successfully ---")

# Handling and reporting unexpected runtime exceptions
except Exception as e:
    print(f"An error occurred during the process: {e}")