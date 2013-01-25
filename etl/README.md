Data processing tools for FS & OS
=================================

This folder contains scripts that convert pre-processed FarmSubsidy.org
data into a format that is recognized by OpenSpending as an
auto-generated database.

To execute this, the following requirements must be met:

* A PostgreSQL database called `farmsubsidy_etl` in which the current
  system user has full administrative privileges. 
* The farm subsidy source data files in the `data/` subfolder, each 
  source file named by the two-letter country code of the member state.

Once these pre-requisities are met, the script can be run via:

  sh load.sh

This will extract all source data, copy it into the database, perform
certain cleanup operations and then rename tables and indexes to conform
with OpenSpending database conventions.

The folder also contains a mapping file which can be POSTed to
OpenSpending to enforce the data model of the FS data.

