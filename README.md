Function and operator for JSON type PostgreSQL 9.2+
======================================

This PostgreSQL extension implements a group of operator for JSON type


IMPORTANT: There're bugs in the existing version. I'm working on it and will
be releasing another version very soon.


Building
--------

run `make install` 
In PostgreSQL execute: create extension json_utils


operators
--------
```
=  check that 2 json data are iquals
?  check if  data (json) contain a specific key.
@> check if  data (json) contain a key/value
```

Example
-------

```sql
CREATE TABLE table2( campo1 serial NOT NULL, campo22 json);
 
with data as 
(select '{"field1":"valor1","field2":'||generate_series(1,1000)::text||'}' as j_son) 

insert into tabla2 ( campo2) select j_son::json from datos


--find a row whit  json value  '{"field1":"valor1","field2":341}' ... (operator =)
select * from tabla2 where campo2= '{"field1":"valor1","field2":341}'::json


--find a row that contain in json data the key/value ='"field2":341' (operator @>)
select * from tabla1 where campo2 @> '"field2":341'
```






 

Anthony R. Sotolongo leon<asotolongo@ongres.com>

Daymel Bonne <dbonne@ongres.com>

