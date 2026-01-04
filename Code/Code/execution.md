1. Create API using AWS App Runner


2. Create AWS Kinesis stream (my-kinesis-stream) - Input to Kinesis firehose


3. Create AWS S3 Bucket (my-destination-bucket) - Output from Kinesis firehose


4. Create AWS Kinesis Firehose 
 - Input - AWS Kinesis stream (my-kinesis-stream)
 - Output - AWS S3 Bucket (my-destination-bucket) - specify location "data/"
 - Create Lambda function - Transform and convert record - Change configuration 512, 512, 10 mins, python3.10


5. Create Python script to fetch data from API and push it to kinesis stream in Google colab
 - https://colab.research.google.com/drive/1lDL4BRaS5fbYDliziKXaEcjrObdk6lqb#scrollTo=nr0aiAoJe0rG


CREATE DATABASE FOOD_DB;

6. Create a Snowflake external stage pointing to the S3 bucket
    CREATE OR REPLACE STAGE s3_stage
    URL = 's3://bucket-name/data'
    CREDENTIALS = (
    AWS_KEY_ID=''
    AWS_SECRET_KEY=''
    );


7. -- Create a file format (Modify according to your file structure)
  CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'


8. Create table RAW_FOOD_DATA

CREATE OR REPLACE TABLE RAW_FOOD_DATA (
    country VARCHAR,
    mkt_name VARCHAR,
    DATES DATE,
    year INT,
    month INT,
    o_apples FLOAT,
h_apples FLOAT,
l_apples FLOAT,
c_apples FLOAT,
inflation_apples FLOAT,
trust_apples FLOAT,
o_bananas FLOAT,
h_bananas FLOAT,
l_bananas FLOAT,
c_bananas FLOAT,
inflation_bananas FLOAT,
trust_bananas FLOAT,
o_beans FLOAT,
h_beans FLOAT,
l_beans FLOAT,
c_beans FLOAT,
inflation_beans FLOAT,
trust_beans FLOAT,
o_bread FLOAT,
h_bread FLOAT,
l_bread FLOAT,
c_bread FLOAT,
inflation_bread FLOAT,
trust_bread FLOAT,
o_bulgur FLOAT,
h_bulgur FLOAT,
l_bulgur FLOAT,
c_bulgur FLOAT,
inflation_bulgur FLOAT,
trust_bulgur FLOAT,
o_cabbage FLOAT,
h_cabbage FLOAT,
l_cabbage FLOAT,
c_cabbage FLOAT,
inflation_cabbage FLOAT,
trust_cabbage FLOAT,
o_carrots FLOAT,
h_carrots FLOAT,
l_carrots FLOAT,
c_carrots FLOAT,
inflation_carrots FLOAT,
trust_carrots FLOAT,
o_cassava FLOAT,
h_cassava FLOAT,
l_cassava FLOAT,
c_cassava FLOAT,
inflation_cassava FLOAT,
trust_cassava FLOAT,
o_cassava_flour FLOAT,
h_cassava_flour FLOAT,
l_cassava_flour FLOAT,
c_cassava_flour FLOAT,
inflation_cassava_flour FLOAT,
trust_cassava_flour FLOAT,
o_cassava_meal FLOAT,
h_cassava_meal FLOAT,
l_cassava_meal FLOAT,
c_cassava_meal FLOAT,
inflation_cassava_meal FLOAT,
trust_cassava_meal FLOAT,
o_cheese FLOAT,
h_cheese FLOAT,
l_cheese FLOAT,
c_cheese FLOAT,
inflation_cheese FLOAT,
trust_cheese FLOAT,
o_chickpeas FLOAT,
h_chickpeas FLOAT,
l_chickpeas FLOAT,
c_chickpeas FLOAT,
inflation_chickpeas FLOAT,
trust_chickpeas FLOAT,
o_chili FLOAT,
h_chili FLOAT,
l_chili FLOAT,
c_chili FLOAT,
inflation_chili FLOAT,
trust_chili FLOAT,
o_coffee_instant FLOAT,
h_coffee_instant FLOAT,
l_coffee_instant FLOAT,
c_coffee_instant FLOAT,
inflation_coffee_instant FLOAT,
trust_coffee_instant FLOAT,
o_couscous FLOAT,
h_couscous FLOAT,
l_couscous FLOAT,
c_couscous FLOAT,
inflation_couscous FLOAT,
trust_couscous FLOAT,
o_cowpeas FLOAT,
h_cowpeas FLOAT,
l_cowpeas FLOAT,
c_cowpeas FLOAT,
inflation_cowpeas FLOAT,
trust_cowpeas FLOAT,
o_cucumbers FLOAT,
h_cucumbers FLOAT,
l_cucumbers FLOAT,
c_cucumbers FLOAT,
inflation_cucumbers FLOAT,
trust_cucumbers FLOAT,
o_dates FLOAT,
h_dates FLOAT,
l_dates FLOAT,
c_dates FLOAT,
inflation_dates FLOAT,
trust_dates FLOAT,
o_eggplants FLOAT,
h_eggplants FLOAT,
l_eggplants FLOAT,
c_eggplants FLOAT,
inflation_eggplants FLOAT,
trust_eggplants FLOAT,
o_eggs FLOAT,
h_eggs FLOAT,
l_eggs FLOAT,
c_eggs FLOAT,
inflation_eggs FLOAT,
trust_eggs FLOAT,
o_fish FLOAT,
h_fish FLOAT,
l_fish FLOAT,
c_fish FLOAT,
inflation_fish FLOAT,
trust_fish FLOAT,
o_fish_catfish FLOAT,
h_fish_catfish FLOAT,
l_fish_catfish FLOAT,
c_fish_catfish FLOAT,
inflation_fish_catfish FLOAT,
trust_fish_catfish FLOAT,
o_fish_mackerel FLOAT,
h_fish_mackerel FLOAT,
l_fish_mackerel FLOAT,
c_fish_mackerel FLOAT,
inflation_fish_mackerel FLOAT,
trust_fish_mackerel FLOAT,
o_fish_salted FLOAT,
h_fish_salted FLOAT,
l_fish_salted FLOAT,
c_fish_salted FLOAT,
inflation_fish_salted FLOAT,
trust_fish_salted FLOAT,
o_fish_sardine_canned FLOAT,
h_fish_sardine_canned FLOAT,
l_fish_sardine_canned FLOAT,
c_fish_sardine_canned FLOAT,
inflation_fish_sardine_canned FLOAT,
trust_fish_sardine_canned FLOAT,
o_fish_smoked FLOAT,
h_fish_smoked FLOAT,
l_fish_smoked FLOAT,
c_fish_smoked FLOAT,
inflation_fish_smoked FLOAT,
trust_fish_smoked FLOAT,
o_fish_tilapia FLOAT,
h_fish_tilapia FLOAT,
l_fish_tilapia FLOAT,
c_fish_tilapia FLOAT,
inflation_fish_tilapia FLOAT,
trust_fish_tilapia FLOAT,
o_fish_tuna_canned FLOAT,
h_fish_tuna_canned FLOAT,
l_fish_tuna_canned FLOAT,
c_fish_tuna_canned FLOAT,
inflation_fish_tuna_canned FLOAT,
trust_fish_tuna_canned FLOAT,
o_gari FLOAT,
h_gari FLOAT,
l_gari FLOAT,
c_gari FLOAT,
inflation_gari FLOAT,
trust_gari FLOAT,
o_garlic FLOAT,
h_garlic FLOAT,
l_garlic FLOAT,
c_garlic FLOAT,
inflation_garlic FLOAT,
trust_garlic FLOAT,
o_groundnuts FLOAT,
h_groundnuts FLOAT,
l_groundnuts FLOAT,
c_groundnuts FLOAT,
inflation_groundnuts FLOAT,
trust_groundnuts FLOAT,
o_groundnuts_paste FLOAT,
h_groundnuts_paste FLOAT,
l_groundnuts_paste FLOAT,
c_groundnuts_paste FLOAT,
inflation_groundnuts_paste FLOAT,
trust_groundnuts_paste FLOAT,
o_lentils FLOAT,
h_lentils FLOAT,
l_lentils FLOAT,
c_lentils FLOAT,
inflation_lentils FLOAT,
trust_lentils FLOAT,
o_lettuce FLOAT,
h_lettuce FLOAT,
l_lettuce FLOAT,
c_lettuce FLOAT,
inflation_lettuce FLOAT,
trust_lettuce FLOAT,
o_livestock_sheep_two_year_old_male FLOAT,
h_livestock_sheep_two_year_old_male FLOAT,
l_livestock_sheep_two_year_old_male FLOAT,
c_livestock_sheep_two_year_old_male FLOAT,
inflation_livestock_sheep_two_year_old_male FLOAT,
trust_livestock_sheep_two_year_old_male FLOAT,
o_livestocksheep_castrated_male FLOAT,
h_livestocksheep_castrated_male FLOAT,
l_livestocksheep_castrated_male FLOAT,
c_livestocksheep_castrated_male FLOAT,
inflation_livestocksheep_castrated_male FLOAT,
trust_livestocksheep_castrated_male FLOAT,
o_maize FLOAT,
h_maize FLOAT,
l_maize FLOAT,
c_maize FLOAT,
inflation_maize FLOAT,
trust_maize FLOAT,
o_maize_flour FLOAT,
h_maize_flour FLOAT,
l_maize_flour FLOAT,
c_maize_flour FLOAT,
inflation_maize_flour FLOAT,
trust_maize_flour FLOAT,
o_maize_meal FLOAT,
h_maize_meal FLOAT,
l_maize_meal FLOAT,
c_maize_meal FLOAT,
inflation_maize_meal FLOAT,
trust_maize_meal FLOAT,
o_meat_beef FLOAT,
h_meat_beef FLOAT,
l_meat_beef FLOAT,
c_meat_beef FLOAT,
inflation_meat_beef FLOAT,
trust_meat_beef FLOAT,
o_meat_beef_canned FLOAT,
h_meat_beef_canned FLOAT,
l_meat_beef_canned FLOAT,
c_meat_beef_canned FLOAT,
inflation_meat_beef_canned FLOAT,
trust_meat_beef_canned FLOAT,
o_meat_beef_chops FLOAT,
h_meat_beef_chops FLOAT,
l_meat_beef_chops FLOAT,
c_meat_beef_chops FLOAT,
inflation_meat_beef_chops FLOAT,
trust_meat_beef_chops FLOAT,
o_meat_beef_minced FLOAT,
h_meat_beef_minced FLOAT,
l_meat_beef_minced FLOAT,
c_meat_beef_minced FLOAT,
inflation_meat_beef_minced FLOAT,
trust_meat_beef_minced FLOAT,
o_meat_buffalo FLOAT,
h_meat_buffalo FLOAT,
l_meat_buffalo FLOAT,
c_meat_buffalo FLOAT,
inflation_meat_buffalo FLOAT,
trust_meat_buffalo FLOAT,
o_meat_chicken FLOAT,
h_meat_chicken FLOAT,
l_meat_chicken FLOAT,
c_meat_chicken FLOAT,
inflation_meat_chicken FLOAT,
trust_meat_chicken FLOAT,
o_meat_chicken_broiler FLOAT,
h_meat_chicken_broiler FLOAT,
l_meat_chicken_broiler FLOAT,
c_meat_chicken_broiler FLOAT,
inflation_meat_chicken_broiler FLOAT,
trust_meat_chicken_broiler FLOAT,
o_meat_chicken_frozen FLOAT,
h_meat_chicken_frozen FLOAT,
l_meat_chicken_frozen FLOAT,
c_meat_chicken_frozen FLOAT,
inflation_meat_chicken_frozen FLOAT,
trust_meat_chicken_frozen FLOAT,
o_meat_chicken_plucked FLOAT,
h_meat_chicken_plucked FLOAT,
l_meat_chicken_plucked FLOAT,
c_meat_chicken_plucked FLOAT,
inflation_meat_chicken_plucked FLOAT,
trust_meat_chicken_plucked FLOAT,
o_meat_chicken_whole FLOAT,
h_meat_chicken_whole FLOAT,
l_meat_chicken_whole FLOAT,
c_meat_chicken_whole FLOAT,
inflation_meat_chicken_whole FLOAT,
trust_meat_chicken_whole FLOAT,
o_meat_chicken_whole_frozen FLOAT,
h_meat_chicken_whole_frozen FLOAT,
l_meat_chicken_whole_frozen FLOAT,
c_meat_chicken_whole_frozen FLOAT,
inflation_meat_chicken_whole_frozen FLOAT,
trust_meat_chicken_whole_frozen FLOAT,
o_meat_goat FLOAT,
h_meat_goat FLOAT,
l_meat_goat FLOAT,
c_meat_goat FLOAT,
inflation_meat_goat FLOAT,
trust_meat_goat FLOAT,
o_meat_lamb FLOAT,
h_meat_lamb FLOAT,
l_meat_lamb FLOAT,
c_meat_lamb FLOAT,
inflation_meat_lamb FLOAT,
trust_meat_lamb FLOAT,
o_meat_pork FLOAT,
h_meat_pork FLOAT,
l_meat_pork FLOAT,
c_meat_pork FLOAT,
inflation_meat_pork FLOAT,
trust_meat_pork FLOAT,
o_milk FLOAT,
h_milk FLOAT,
l_milk FLOAT,
c_milk FLOAT,
inflation_milk FLOAT,
trust_milk FLOAT,
o_millet FLOAT,
h_millet FLOAT,
l_millet FLOAT,
c_millet FLOAT,
inflation_millet FLOAT,
trust_millet FLOAT,
o_oil FLOAT,
h_oil FLOAT,
l_oil FLOAT,
c_oil FLOAT,
inflation_oil FLOAT,
trust_oil FLOAT,
o_onions FLOAT,
h_onions FLOAT,
l_onions FLOAT,
c_onions FLOAT,
inflation_onions FLOAT,
trust_onions FLOAT,
o_oranges FLOAT,
h_oranges FLOAT,
l_oranges FLOAT,
c_oranges FLOAT,
inflation_oranges FLOAT,
trust_oranges FLOAT,
o_parsley FLOAT,
h_parsley FLOAT,
l_parsley FLOAT,
c_parsley FLOAT,
inflation_parsley FLOAT,
trust_parsley FLOAT,
o_pasta FLOAT,
h_pasta FLOAT,
l_pasta FLOAT,
c_pasta FLOAT,
inflation_pasta FLOAT,
trust_pasta FLOAT,
o_peas FLOAT,
h_peas FLOAT,
l_peas FLOAT,
c_peas FLOAT,
inflation_peas FLOAT,
trust_peas FLOAT,
o_plantains FLOAT,
h_plantains FLOAT,
l_plantains FLOAT,
c_plantains FLOAT,
inflation_plantains FLOAT,
trust_plantains FLOAT,
o_potatoes FLOAT,
h_potatoes FLOAT,
l_potatoes FLOAT,
c_potatoes FLOAT,
inflation_potatoes FLOAT,
trust_potatoes FLOAT,
o_pulses FLOAT,
h_pulses FLOAT,
l_pulses FLOAT,
c_pulses FLOAT,
inflation_pulses FLOAT,
trust_pulses FLOAT,
o_rice FLOAT,
h_rice FLOAT,
l_rice FLOAT,
c_rice FLOAT,
inflation_rice FLOAT,
trust_rice FLOAT,
o_rice_various FLOAT,
h_rice_various FLOAT,
l_rice_various FLOAT,
c_rice_various FLOAT,
inflation_rice_various FLOAT,
trust_rice_various FLOAT,
o_salt FLOAT,
h_salt FLOAT,
l_salt FLOAT,
c_salt FLOAT,
inflation_salt FLOAT,
trust_salt FLOAT,
o_sesame FLOAT,
h_sesame FLOAT,
l_sesame FLOAT,
c_sesame FLOAT,
inflation_sesame FLOAT,
trust_sesame FLOAT,
o_sorghum FLOAT,
h_sorghum FLOAT,
l_sorghum FLOAT,
c_sorghum FLOAT,
inflation_sorghum FLOAT,
trust_sorghum FLOAT,
o_sorghum_food_aid FLOAT,
h_sorghum_food_aid FLOAT,
l_sorghum_food_aid FLOAT,
c_sorghum_food_aid FLOAT,
inflation_sorghum_food_aid FLOAT,
trust_sorghum_food_aid FLOAT,
o_sugar FLOAT,
h_sugar FLOAT,
l_sugar FLOAT,
c_sugar FLOAT,
inflation_sugar FLOAT,
trust_sugar FLOAT,
o_tea FLOAT,
h_tea FLOAT,
l_tea FLOAT,
c_tea FLOAT,
inflation_tea FLOAT,
trust_tea FLOAT,
o_tomatoes FLOAT,
h_tomatoes FLOAT,
l_tomatoes FLOAT,
c_tomatoes FLOAT,
inflation_tomatoes FLOAT,
trust_tomatoes FLOAT,
o_tomatoes_paste FLOAT,
h_tomatoes_paste FLOAT,
l_tomatoes_paste FLOAT,
c_tomatoes_paste FLOAT,
inflation_tomatoes_paste FLOAT,
trust_tomatoes_paste FLOAT,
o_wheat FLOAT,
h_wheat FLOAT,
l_wheat FLOAT,
c_wheat FLOAT,
inflation_wheat FLOAT,
trust_wheat FLOAT,
o_wheat_flour FLOAT,
h_wheat_flour FLOAT,
l_wheat_flour FLOAT,
c_wheat_flour FLOAT,
inflation_wheat_flour FLOAT,
trust_wheat_flour FLOAT,
o_yogurt FLOAT,
h_yogurt FLOAT,
l_yogurt FLOAT,
c_yogurt FLOAT,
inflation_yogurt FLOAT,
trust_yogurt FLOAT,
o_food_price_index FLOAT,
h_food_price_index FLOAT,
l_food_price_index FLOAT,
c_food_price_index FLOAT,
inflation_food_price_index FLOAT,
trust_food_price_index FLOAT)

8. -- Create Snowpipe to load data into the table
  CREATE OR REPLACE PIPE my_snowpipe
  AUTO_INGEST = TRUE
  AS
  COPY INTO RAW_FOOD_DATA
  FROM @s3_stage
  FILE_FORMAT = (FORMAT_NAME = csv_format);

show pipes;

copy arn


9. Add Snowpipe's ARN in S3 bucket's Properties
- Go to bucket - properties - Event notification - Add - Name - All object create events - Destination (SQS Queue) - Enter SQS ARN


# Create row_count table
create or replace table row_count (
  index_no number autoincrement start 1 increment 1,
  no_of_rows bigint,
  date varchar(100),
  no_of_rows_added bigint,
  no_of_rows_in_transformed_table bigint
  );

# 10. Data Transformation in Snowpark

Code:

# The Snowpark package is required for Python Worksheets. 
# You can add more packages by selecting them using the Packages control and then importing them.

import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
import pandas as pd

def main(session: snowpark.Session): 
    # Your code goes here, inside the "main" handler.
    tableName = 'raw_food_data'
    
    snow_table = session.table(tableName)

    # convert table to pandas dataframe
    df=snow_table.to_pandas()

    print(df.shape)

    tableName = 'row_count'
    
    row_count_table = session.table(tableName)

    # convert table to pandas dataframe
    row_count_df=row_count_table.to_pandas()

    if row_count_df.shape[0]!=0:
        row_count_df = row_count_df[row_count_df['INDEX_NO']==max(row_count_df['INDEX_NO'])].reset_index(drop=True)
        old_rows = row_count_df['NO_OF_ROWS'][0]
        df = df.sort_values(by='YEAR').reset_index(drop=True)
        df1 = df.tail(df.shape[0] - old_rows)
        #add date and another column appended rows
    else:
        df1 = df
    print('Shape 1 :',df1.shape)

    print('Shape 1 :',df1['DATES'].unique())

    # select all columns with atleast one non null value
    df_notnull=df1.loc[:, df1.notnull().any()]
    
    # Get a list of columns to keep
    keep_cols = ['COUNTRY', 'MKT_NAME', 'DATES']

    # Filter out columns not in the keep_cols list
    df_1 = df_notnull[keep_cols + [col for col in df_notnull.columns if col.startswith(('O_', 'H_', 'L_', 'C_', 'INFLATION_', 'TRUST_'))]]

    # Convert the dataframe in desired format
    final_component_df = df_1.melt(id_vars=keep_cols, var_name='ITEM', value_name='VALUE')

    # Split the variable names to get the type of data (open, high, low, close, inflation, trust)
    final_component_df.insert(loc=4,column='TYPE', value= final_component_df['ITEM'].str.split('_').str[0])
    final_component_df['TYPE'] = final_component_df['TYPE'].replace({'O': 'OPEN', 'H': 'HIGH','L':'LOW','C':'CLOSE'})

    final_component_df['ITEM'] = final_component_df['ITEM'].str.split('_').str[1]

    pivot_type_df=final_component_df.pivot_table(index=['COUNTRY', 'MKT_NAME', 'DATES','ITEM'],values='VALUE',columns='TYPE').reset_index()

    present_cols=pivot_type_df.columns.tolist()
    expected_cols=['COUNTRY', 'MKT_NAME', 'DATES','ITEM', 'CLOSE', 'HIGH',
       'INFLATION', 'LOW', 'OPEN', 'TRUST']    

    add_cols=list(set(expected_cols)-set(present_cols))
    if add_cols:
       for col in add_cols:
              pivot_type_df[col] = 0
           
    final_df=pivot_type_df[expected_cols]
    
    print('Shape ClEANSED_FOOD_DATA_NEW:',pivot_type_df.shape)

    print(pivot_type_df['DATES'].unique())  

    if row_count_df.shape[0]==0:
        d = {'INDEX_NO':1,'NO_OF_ROWS':df.shape[0],'DATE':str(pd.Timestamp.now()),'NO_OF_ROWS_ADDED':df.shape[0],'NO_OF_ROWS_IN_TRANSFORMED_TABLE':pivot_type_df.shape[0]}
        session.create_dataframe(pd.DataFrame([d])).write.save_as_table('row_count', mode="append", table_type="")
    else:
        d = {'INDEX_NO':row_count_df['INDEX_NO'][0]+1,'NO_OF_ROWS':df.shape[0],'DATE':str(pd.Timestamp.now()),'NO_OF_ROWS_ADDED':int(df.shape[0] - old_rows),'NO_OF_ROWS_IN_TRANSFORMED_TABLE':pivot_type_df.shape[0]}
        session.create_dataframe(pd.DataFrame([d])).write.save_as_table('row_count', mode="append", table_type="")
            
    snow_component = session.create_dataframe(final_df)

    snow_component.write.save_as_table("ClEANSED_FOOD_DATA_NEW", mode="append")  
    
    # Return value will appear in the Results tab.
    return snow_component


connection_parameters = {
    "account": "",
    "user": "",
    "password": "",
    "role": "ACCOUNTADMIN",  # optional
    "warehouse": "COMPUTE_WH",  # optional
    "database": "HEALTHDB",  # optional
    "schema": "PUBLIC",  # optional
  }  




EXPORT INTO STORED PROCEDURE

11. Create cron job task
--- Create the Task which calls the procedure

create or replace task cloneschema 
  warehouse = COMPUTE_WH 
  schedule = 'USING CRON 0 12 * * * UTC' --schedule daily at 12 PM UTC 
as 
  call DATA_TRANSFORMATION();

--start the task 
alter task cloneschema resume;
 



 10 am - u r fetching data from api


 12 noon - you are scheduling the task to run data_transformation SP.


 2 pm - refresh data






