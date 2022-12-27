/*
Yes it's Fibonacci yet again ! But this time it's SQL.

You need to create a select statement which will produce first 90 Fibonnacci numbers. The column name is - number

Fibbonaccii sequence is:

 0, 1, 1, 2, 3, 5, 8, 13, ..., 89, 144, 233, 377, ...
where

f(0) = 0
f(1) = 1
...
f(n) = f(n-1) + f(n-2)
Have fun!
*/

-- my
CREATE OR REPLACE FUNCTION fib(f integer)
RETURNS SETOF bigint
LANGUAGE SQL
AS $$
WITH RECURSIVE fibb
AS (
    SELECT 1::bigint as n, 0::bigint as a, 1::bigint as b
UNION ALL
    SELECT n+1, b as a, (a+b) as b FROM fibb
)
SELECT a FROM fibb limit $1;
$$;

select fib(90) AS number;

-- bp
WITH RECURSIVE fib(number,n2) AS (
      SELECT 0::bigint,1::bigint
    UNION ALL
      SELECT n2::bigint,number+n2::bigint 
      FROM fib
)
SELECT number FROM fib LIMIT 90