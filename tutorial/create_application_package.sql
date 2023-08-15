GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE accountadmin;

CREATE APPLICATION PACKAGE dee_solutions_hello_snowflake_package;

SHOW APPLICATION PACKAGES;

use application package dee_solutions_hello_snowflake_package;

CREATE SCHEMA stage_content;

CREATE OR REPLACE STAGE dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage
  FILE_FORMAT = (TYPE = 'csv' FIELD_DELIMITER = '|' SKIP_HEADER = 1);

LIST @dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage;

SHOW APPLICATIONS;

CREATE APPLICATION HELLO_SNOWFLAKE_APP
  FROM APPLICATION PACKAGE DEE_SOLUTIONS_HELLO_SNOWFLAKE_PACKAGE
  USING '@dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage';

SHOW APPLICATIONS;

CALL core.hello();



use application package dee_solutions_hello_snowflake_package;

CREATE SCHEMA IF NOT EXISTS shared_data;
CREATE TABLE IF NOT EXISTS accounts (ID INT, NAME VARCHAR, VALUE VARCHAR);
INSERT INTO accounts VALUES
  (1, 'Nihar', 'Snowflake'),
  (2, 'Frank', 'Snowflake'),
  (3, 'Benoit', 'Snowflake'),
  (4, 'Steven', 'Acme');


SELECT * FROM accounts;

GRANT USAGE ON SCHEMA shared_data TO SHARE IN APPLICATION PACKAGE dee_solutions_hello_snowflake_package;
GRANT SELECT ON TABLE accounts TO SHARE IN APPLICATION PACKAGE dee_solutions_hello_snowflake_package;

-- Updates to setup.sql in Named Stage

DROP APPLICATION hello_snowflake_app;

SHOW APPLICATIONS;

CREATE APPLICATION HELLO_SNOWFLAKE_APP
  FROM APPLICATION PACKAGE DEE_SOLUTIONS_HELLO_SNOWFLAKE_PACKAGE
  USING '@dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage';

SHOW APPLICATIONS;  


SELECT * FROM code_schema.accounts_view;

-- Updates to setup.sql.  Added python directory and hello_python.py file


DROP APPLICATION hello_snowflake_app;

SHOW APPLICATIONS;

CREATE APPLICATION HELLO_SNOWFLAKE_APP
  FROM APPLICATION PACKAGE DEE_SOLUTIONS_HELLO_SNOWFLAKE_PACKAGE
  USING '@dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage';

SHOW APPLICATIONS;  

SELECT code_schema.addone(3);

SELECT code_schema.multiply(2,2);


-- Add Streamlit Stuff

DROP APPLICATION hello_snowflake_app;

SHOW APPLICATIONS;

CREATE APPLICATION HELLO_SNOWFLAKE_APP
  FROM APPLICATION PACKAGE DEE_SOLUTIONS_HELLO_SNOWFLAKE_PACKAGE
  USING '@dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage';

SHOW APPLICATIONS;  

-- Add Version to Applicaiton

ALTER APPLICATION PACKAGE DEE_SOLUTIONS_HELLO_SNOWFLAKE_PACKAGE
  ADD VERSION v1_0 USING '@dee_solutions_hello_snowflake_package.stage_content.hello_snowflake_stage';

SHOW VERSIONS IN APPLICATION PACKAGE dee_solutions_hello_snowflake_package;


-- Install Application based on version:

DROP APPLICATION hello_snowflake_app;
CREATE APPLICATION hello_snowflake_app
  FROM APPLICATION PACKAGE dee_solutions_hello_snowflake_package
  USING VERSION V1_0;


-- Publish and Install Applicaiton
SHOW VERSIONS IN APPLICATION PACKAGE dee_solutions_hello_snowflake_package;

ALTER APPLICATION PACKAGE dee_solutions_hello_snowflake_package
  SET DEFAULT RELEASE DIRECTIVE
  VERSION = v1_0
  PATCH = 0;





