# SQL Data Types

- [SQL Data Types](#sql-data-types)
  - [Character Types](#character-types)
    - [Integral Types](#integral-types)
      - [AUTO_INCREMENT](#auto_increment)
    - [Non-Integral Types](#non-integral-types)
    - [Miscellaneous Types](#miscellaneous-types)

## Character Types

Used for storing character/text based data.

  - `char(n)` or `character(n)`:
    - **predetermined** length characters.
    - Applies trailing spaces to data shorter than **n**.
    - **1999bytes** max size
    - Fastest for small strings where length is known
  - `varchar1(n)` (ANSI standard), `varchar2(n)` (oracle standard) or
    `character varying(n)`:
      - **varying** length characters.
      - size = actual no. of characters + metadata for length
      - **3999bytes** max size
  - `TEXT`
    - Fixed max size
    - Cannot choose size
    - Depending on th database may not be:
      - Indexable
      - Searchable
      - Sortable

### Integral Types

Used for storing **whole numbers**. Oracle DB does not define size limits. **All** have
  **37** digits of precision internally
    - `SMALLINT`
    - `INTEGER`
    - `INT`

#### AUTO_INCREMENT

when multiple tables are to be joined together we require a `PRIMARY KEY`
to reference as a  `FOREIGN KEY`. This can either be performed using an integral
data type or a `SERIAL` data type. A serial data type automatically generates
unique integer number fo a column.

NOTE: `SERIAL` does not automatically have a `UNIQUE` constraint and must be
handled explicitly i.e

```sql
CREATE TABLE tableName (
  colName SERIAL PRIMARY KEY
);
```


### Non-Integral Types

Contains **integer and fractional part** controlled via **precision and scale**.

  - _Precision_:
      - Total number of significant digits
      - Digits before and after the decimal point.
  - _Scale_:
      - Number of digits after decimal point. If not provided data type can store integral values
  - _Digits to Left of Decimal Point_: = Precision - Scale
  - `numeric(precision, scale)`
  - `decimal(precision, scale)`
  - `number(precision, scale)`

### Miscellaneous Types

  - `DATE`:
    - Format:
      - 'DD-MM-YY' e.g. '01-JUL-81'
      - 'YYYY-MM-DD'
  - `TIMEA:`
    - 'HH:MM:SS'
  - `TIMESTAMP`:
      - Record exact time with up to  0 billionth precision
      - e.g. 19-JUL-69 08:18:00.000000 PM
      - Best Practices:
        - Store with timezome
        - prefer UTC for stored time stamps
        - convert to locatl time when retrieving
  - `CLOB` (character large object):
      - Large character based data over 3999bytes size limit
  - `BLOB` (binary large object):
      - Large binary data i.e. movies, images, up to 3GB