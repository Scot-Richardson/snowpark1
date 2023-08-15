This is the readme file for the Hello Snowflake Application!


Create an Application Package
At its core, an application package is a Snowflake database that is extended to include additional information about an application. In that sense, it is a container for an application that includes:


To create an application package:

1. To grant the CREATE APPLICATION PACKAGE privilege to your role, run the following command:

GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE accountadmin;

Although the ACCOUNTADMIN role has this privilege by default, to be able to create an application package, you must ensure that your role has been granted this privilege.

2. To create the application package, run the following command:

CREATE APPLICATION PACKAGE hello_snowflake_package;
Note

After running this command, the current context changes to HELLO_SNOWFLAKE_PACKAGE.

3. To verify the application package was successfully created, run the following command:

SHOW APPLICATION PACKAGES;
You should see HELLO_SNOWFLAKE_PACKAGE in the name column of the output. Refer to SHOW APPLICATION PACKAGES for additional information on this command.

In this section you learned that an application package is a container for the resources used by an application. You also learned how to create an application package.

Create a Named Stage
In this section you will create a named stage to store files required by the Native Apps Framework. A named stage is also required to store any external code files you want to include in your application. Uploading these files to a named stage makes them available when creating your application.

To create a named stage, do the following:

1. To set the context to the application package you created in the previous section, run the following command:

USE APPLICATION PACKAGE hello_snowflake_package;

2. To create the required schema for the named stage, run the following command:
 
CREATE SCHEMA stage_content;


3.To create the named stage, run the following command.

CREATE OR REPLACE STAGE hello_snowflake_package.stage_content.hello_snowflake_stage
  FILE_FORMAT = (TYPE = 'csv' FIELD_DELIMITER = '|' SKIP_HEADER = 1);

This command creates the named stage in the database and schema you created in the previous steps.

Note:
You must include FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = '|' SKIP_HEADER = 1); as part of this command. These are not optional.


