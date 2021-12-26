<link rel="stylesheet" type="text/css" href="./assets/white-bg.css">

# Structured Query Language Introduction and Basics

- [Structured Query Language Introduction and Basics](#structured-query-language-introduction-and-basics)
  - [SQL Definition:](#sql-definition)
  - [Types of SQL Commands and Data Types](#types-of-sql-commands-and-data-types)
  - [Statements, Keywords and Clauses](#statements-keywords-and-clauses)

## SQL Definition:

SQL is the language used to issue commands to a database i.e. query. Allows us to:

- Describe the shape of the data to be stored
- Provide hints to the database engin about how data is to be accesses
- Provides CRUD operations on our database:
  - Create
  - Read
  - Update
  - Delete


## Types of SQL Commands and Data Types

- _Data Definition Language (DDL)_: Specify database schema (i.e. structure). The
  output of a DDL is placed within metadata.

- _Data Manipulation Language (DML)_: Allows users to access/manipulate data
  within relational database.

- _Data Control Language_: Enables urs to provide access to various database
  objects.

- _Transaction Control Language_: Specifies commands for beginning and ending a
  transaction.

<div class="image">
  <img src="images/sql-basics/sql-commands-and-datatypes.svg"></img>
</div>

## Statements, Keywords and Clauses

_Statement_: Refers to a complete query, i.e.

```sql
select
  colName1, colName2, ...
FROM
  tableName
```

_Clauses_: Clause are parts of an sql query i.e.

```sql
select
  colName1, colName2, ...
```

_Keywords_: Keywords are predefined individual tokens in our clauses/statements,
whose meanings cannot be modified i.e. the `SELECT` or `FROM` keywords within
our statements.