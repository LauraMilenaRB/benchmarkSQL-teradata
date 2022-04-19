
Instructions for running BenchmarkSQL on Teradata Express
--------------------------------------------------

# Requirements

These are the requirements to run this application:

* Use of JDK7.
* Maven to build the sources.
* Teradata Vantage Express.

## Maven build

This project is configured with Maven, you just need to build the package and
then change to `target` directory:

    mvn
    cd target

# Adjust the BenchmarkSQL configuration file

A sample JDBC connection property files is provided for IBM Db2 (LUW) called
`teradata.properties`.

Go to the `run/teradata` directory, edit the `teradata.properties` file to point to the
database you would like to test.

    cd run
    cd teradata
    vi teradata.properties

# Build the schema and initial database load

Change to the `run` directory.

    cd run
    cd teradata

Execute the `sqlTableCreates.sql` to create the base tables.

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlTableCreates.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlTableCreates.sql

Run the Loader command file to load all of the default data for a benchmark.

* Approximately half a million rows (per warehouse) will be loaded across 9
  tables.

To run the following command, indicating the quantity of warehouses:

_Windows:_

    runLoader teradata\teradata.properties numWarehouses 1

_Linux:_

    ./runLoader teradata/teradata.properties numWarehouses 1

NOTE: You should run the `sqlTableTruncates.sql` script if your tables are not
already empty.

* Alternatively, you may choose to generate the load data out to CSV files
  where it can be efficiently bulk loaded into the database as many times as
  required by your testing.

To run the following command, indicating the location of the files.

_Windows:_

    runLoader teradata\teradata.properties numWarehouses 1 fileLocation c:\tmp\csv        

_Linux:_

    ./runLoader teradata/teradata.properties numWarehouses 1 fileLocation /tmp/csv/        

These CSV files can be bulk loaded as follows:

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlTableCopies.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlTableCopies.sql

You may truncate the data via:

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlTableTruncates.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlTableTruncates.sql

In both cases, run the `runSQL` command file to execute the SQL script
`sqlIndexCreates.sql` to create the primary keys & other indexes on the tables.

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlIndexCreates.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlIndexCreates.sql

When you restart the test, and you will reload the data, you could delete the
indexes before this:

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlIndexDrops.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlIndexDrops.sql

# Run the configured benchmark

Run the `runBenchmark` command file to test the database.
This command will create terminals and automatically start the transaction
based on the parameters set in `teradata.properties`.

_Windows:_

    runBenchmark teradata\teradata.properties

_Linux:_

    ./runBenchmark teradata/teradata.properties

# Scale the benchmark configuration

Configure the following elements according to the workload:

* Bufferpools.
* Tablespaces.
* Table properties.
* Indexes.
* Transaction logs.

# Clean the environment

To clean the database, you can run.

_Windows:_

    runSQL teradata\teradata.properties teradata\sqlTableDrops.sql

_Linux:_

    ./runSQL teradata/teradata.properties teradata/sqlTableDrops.sql

