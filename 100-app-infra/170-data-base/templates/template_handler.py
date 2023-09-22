import pymysql
import boto3
import hvac
import json
from botocore.exceptions import ClientError

region          = '${region}'
sql_file        = 'mysql_setup_script.sql'
database_name   = '${db_name}'
db_endpoint     = '${db_endpoint}'
vault_endpoint  = '${vault_endpoitn}'

admin_secret_path           = '${db_admin_secret_path}'
workoutrecorder_secret_path = '${db_workoutrecorder_secret_path}'


def get_vault_token():
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId='cicd-vault-${environment}-token'
        )
    except ClientError as e:
        raise e

    secret_string = get_secret_value_response['SecretString']
    secret_dict = json.loads(secret_string)
    
    return secret_dict['cicd-token']

def get_vault_secrets(vault_token, vault_endpoint, secret_path):
    client = hvac.Client(
        url=vault_endpoint, 
        token=vault_token
        )
    secrets = client.secrets.kv.v2.read_secret_version(
        path=secret_path, 
        mount_point='kv'
        )
    return secrets

def parse_sql(sql_content):
    sql_statements = sql_content.split(';')
    sql_statements = [stmt.strip() for stmt in sql_statements if stmt.strip()]
    return sql_statements

def render_sql_file_conntent():
    vault_token = get_vault_token()
    with open(sql_file, 'r') as file:
        sql_content = file.read()
    workoutrecorder_secrets = get_vault_secrets(
        vault_token, 
        vault_endpoint, 
        workoutrecorder_secret_path
    )
    updated_sql_content = sql_content.replace(
        '<db_workoutrecorder_password>', 
        workoutrecorder_secrets['data']['data']['password']
    )
    return updated_sql_content

def setup_db(event, context):
    vault_token = get_vault_token()
    admin_secrets = get_vault_secrets(vault_token, vault_endpoint, admin_secret_path)
    admin_username = admin_secrets['data']['data']['username']
    admin_password = admin_secrets['data']['data']['password']
    
    conn = pymysql.connect(host=db_endpoint, user=admin_username, passwd=admin_password, db=database_name, connect_timeout=5)
    stmts = parse_sql(render_sql_file_conntent())
    with conn.cursor() as cursor:
        for stmt in stmts:
            cursor.execute(stmt)
        conn.commit()