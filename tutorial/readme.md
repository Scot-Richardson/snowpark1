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



Upload the Application Files to the Named Stage

In the previous section, you created an application package that will serve as the container for your application. You also create a named stage within the application package that contains the required application files.

In this section you will upload these files to the named stage.

To upload application files, do one of the following:

Upload the application files using Snowsight as described in Staging Files Using Snowsight:  https://docs.snowflake.com/en/user-guide/data-load-local-file-system-stage-ui

Upload the application files using SnowSQL by running the following commands:

PUT file:///<path_to_your_root_folder>/tutorial/manifest.yml @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;
PUT file:///<path_to_your_root_folder>/tutorial/scripts/setup.sql @hello_snowflake_package.stage_content.hello_snowflake_stage/scripts overwrite=true auto_compress=false;
PUT file:///<path_to_your_root_folder>/tutorial/readme.md @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;
Note

Modify the path in the examples above to reflect the path to the root folder of your project.

In your worksheet, run the following command to verify that the file upload was successful:

LIST @hello_snowflake_package.stage_content.hello_snowflake_stage;
After running this command, you should see each of the files listed as shown in the following output:

+----------------------------------------+------+----------------------------------+-------------------------------+
| name                                   | size | md5                              | last_modified                 |
|----------------------------------------+------+----------------------------------+-------------------------------|
| hello_snowflake_stage/manifest.yml      |   80 | 9acab2ba718eebfa5f98f4e95c822db6 | Mon, 29 May 2023 22:51:04 GMT |
| hello_snowflake_stage/readme.md         |   64 | 1bc95f95109dc60a09b478dd95c31808 | Mon, 29 May 2023 22:51:05 GMT |
| hello_snowflake_stage/scripts/setup.sql |   64 | 7807ee1f2f27312799fc83c66ba775cf | Mon, 29 May 2023 22:51:04 GMT |
+----------------------------------------+------+----------------------------------+-------------------------------+
In this section, you uploaded the application files to a named stage. These files are now available to the application package as you continue to develop your application. In later sections, as you add features to your application, you will return to this section to upload revised versions of these files and new files.


