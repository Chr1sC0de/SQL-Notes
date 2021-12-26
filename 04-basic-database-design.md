# Basic Database Design

- [Basic Database Design](#basic-database-design)
  - [What is Database Design?](#what-is-database-design)
    - [Types of Keys](#types-of-keys)
    - [Things to consider](#things-to-consider)
  - [Database Normalization](#database-normalization)
  - [One-to-many Relationship](#one-to-many-relationship)
  - [Many-to-many Relationships](#many-to-many-relationships)

## What is Database Design?

During database design we organize data according do a database model.
Database design is rich and complex field, however, as a basic introduction we
can boil it down to a few **Basic Rule**:

- Don't repeat things, use a relationship instead

- Use copies of `keys` which point to the desired data element and use `relations`
 to link data contained within different tables.

By removing replicated data and using `keys` and `relations` it allow us to
build "webs of data" making it easier for the database to read through the data quickly.

### Types of Keys

* _Primary Key_:
  * Minimal set of attributes which uniquely specify a tuple within a relation.
  * Never use a logical key as a primary key
  * String field based primary keys are less efficient than integers
* _Logical Key_:
  * What the outside world uses for lookups
* _Foreign Key_:
  * A key which points to another key (normally a primary key) of another table
  * It is very efficient to use integer Foreign+Primary keys

### Things to consider

* Is a piece of data we want to store an object or an attribute to some other
  object
* What are the relationships between various objects

## Database Normalization

Database Normalization is very complicated, however, at its most basic level we
can use the following thinking:

* References over duplicates
* Integers for keys and references
* Create tables with a referable special "key" column for each table

## One-to-many Relationship

A relationship between two entities, e.g. A and B where A type entities can be
connected to many B entities however B type entities can only connect to a
single A entity. For example a singer to their original songs.

## Many-to-many Relationships

Similar to one-to-many however A now behaves similarly to B.
