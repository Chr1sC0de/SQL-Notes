# Basic Database Definition Language Statements

- [Basic Database Definition Language Statements](#basic-database-definition-language-statements)
  - [Creating a Database](#creating-a-database)
    - [PostgreSQL](#postgresql)
      - [Creating databases from the command-line](#creating-databases-from-the-command-line)
      - [Creating a tablespace and database within postgreSQL](#creating-a-tablespace-and-database-within-postgresql)
      - [Show All Tablespaces](#show-all-tablespaces)
      - [Setting The Default Tablespace](#setting-the-default-tablespace)
      - [Show All Databases](#show-all-databases)
      - [Show Default Tablespace](#show-default-tablespace)
      - [Show Current Database Connection](#show-current-database-connection)
      - [Connect to different database](#connect-to-different-database)
  - [Create and Drop Tables](#create-and-drop-tables)
  - [Constraint Keywords](#constraint-keywords)
  - [Alter Table Statements](#alter-table-statements)
  - [On Delete](#on-delete)

## Creating a Database

### PostgreSQL

Documentation for:

- [Creating a database cluster](https://www.postgresql.org/docs/14/creating-cluster.html)
- [Creating a database](https://www.postgresql.org/docs/current/tutorial-createdb.html)
- [Creating a database in a specified location](https://www.postgresql.org/docs/6.3/c0702.htm)

#### Creating databases from the command-line

```powershell
# initialize database in specified storage area
% createdb.exe -D <directory> <database_name>
```

NOTE: A tablespace should exist within the selected directory.

#### Creating a tablespace and database within postgreSQL

To create a tablespace:

```sql
-- without owner
CREATE TABLESPACE
  tablespace_name
LOCATION
  directory_path;
-- with owner owner
CREATE TABLESPACE
  tablespace_name
OWNER
  user_name
LOCATION
  directory_path;
```


NOTE: on windows you might need to provide access to allow permissions to
generate the tablespace with postgresql refer to the following [link](https://www.youtube.com/watch?v=FQzBgEFkdes).

```sql
-- create database given tablespace
CREATE DATABASE
  mydb
WITH TABLESPACE
  tablespace_name
```

#### Show All Tablespaces

we can view all the tablespaces available using

```sql
select * from pg_tablespace
```

or with

```psql
\db
```

#### Setting The Default Tablespace

Sets default tablespace for `CREATE TABLE` and `CREATE INDEX` commands

```sql
SET default_tablespace = table_space_name;
```

#### Show All Databases

```postgresql
\l
-- show databases with tablespaces
\l+
```

or

```sql
select * from pg_database;
```

#### Show Default Tablespace

```sql
show pg_default;
```

#### Show Current Database Connection

```sql
SELECT current_database();
```

or

```postgresql
\conninfo
or
\c

```

#### Connect to different database

```sql
SELECT current_database();
```

or

```postgresql
\connect database_name
or
\c database_name

```

## Create and Drop Tables

Create a table in sql

```sql
CREATE TABLE tableName (
  colName DTYPE,
  colName DTYPE,
  ...
)
```

Remove existing tables

```sql
DROP TABLE tableName
```

## Constraint Keywords

Used to maintain data integrity by enforcing data format

Constraint Operations:

- `CHECK`
- `DEFAULT`
- `FOREIGN KEY`
- `NOT NULL`
- `PRIMARY KEY`
- composite `PRIMARY KEY`
- `UNIQUE`

Types of Constraints

- _Column-Level Constraint_: refer to a single column within a table and do
  not specify a column name. i.e. constraint is specified with column definition.
- _Table-Level Constraints_: Refer to one or more columns in a table and specify
  the names of the columns where they are applied.

Example Statements:

Column-Level Constraints:

```sql
CREATE TABLE tableName (
  -- make colName1 a PRIMARY KEY at the column level
  colName1 DTYPE CONSTRAINT columnLevelPrimaryKey PRIMARY KEY,
  -- make colName2 NOT NULL at the column level
  colName2 DTYPE CONSTRAINT columnLevelNotNull NOT NULL,
  -- alternative syntax for column level NOT NULL constraint
  colName3 DTYPE NOT NULL,
  -- add column level CHECK constraint
  colName4 DTYPE CONSTRAINT columnLevelCheck CHECK(colName4 in(domain)),
  -- add column level UNIQUE constraint
  colName5 DTYPE UNIQUE,
  -- add column level DEFAULT constraint, make default date the system date
  colName6 DATE SYSDATE,
);
```

Table-Level Constraints:

```sql
CREATE TABLE tableName (
  colName1 DTYPE,
  colName2 DTYPE,
  colName3 DTYPE,
  colName4 DTYPE,
  colName5 DTYPE,
  -- bellow are table level constraints
  CONSTRAINT tableLevelCompositePrimaryKey PRIMARY KEY(colName1, colName2,...),
  CONSTRAINT tableLevelCheck CHECK(colName3 in(DOMAIN)),
  UNIQUE(colName4),
  CONSTRAINT tabelLevelForeignKey
      FOREIGN KEY(colName5) REFERENCES externalTableName(externalTableAttribute)
);
```

## Alter Table Statements

Change structure of existing table

```SQL
ALTER TABLE tableName ADD colName DTYPE -- add a column
ALTER TABLE tableName MODIFY colName DTYPE -- change column dtype
ALTER TABLE tableName RENAME COLUMN colName TO newColName -- change column name
ALTER TABLE tableName DROP colName -- delete column
ALTER TABLE tableName ADD CONSTRAINT constraint_name PRIMARY KEY (colName) -- add primary key constraint
ALTER TABLE tableName DROP CONSTRAINT constraint_name -- remove constraint
```

## On Delete

The method dictates what happens to a child table if an entry is deleted from
the parent table.

- `ON DELETE CASCADE`: Remove  child rows to maintain consistency if reference
  row from parent table is deleted

```sql
CREATE TABLE tableName (
  colName DTYPE REFERENCES tableName(table_primary key) ON DELETE CASCADE,
  ...
)
```

- `ON DELETE DEFAULT` or `ON DELETE RESTRICT`: don't allow changes that break
  the constraint, i.e. give a warning if we try to delete the parent row

```sql
CREATE TABLE tableName (
  colName DTYPE REFERENCES tableName(table_primary key) ON DELETE RESTRICT,
  ...
)
```

- `SET NULL`: Set the foreign key field to null if the parent row is deleted

```sql
CREATE TABLE tableName (
  colName DTYPE REFERENCES tableName(table_primary key) ON DELETE SET NULL,
  ...
)
```