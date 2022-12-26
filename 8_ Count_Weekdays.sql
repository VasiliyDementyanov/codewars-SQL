/*
You need to create a function that calculates the number of weekdays (Monday through Friday) between two dates inclusively.

The function should be named weekdays accept two arguments of type DATE and return an INTEGER value.

weekdays(DATE, DATE) INTEGER
The order of arguments shouldn't matter. To illustrate both of the following queries

SELECT weekdays('2016-01-01', '2016-01-10');
SELECT weekdays('2016-01-10', '2016-01-01');
should produce the same result

 weekdays
----------
        6
(1 row)

  2019-01-01 |         2 | tuesday  
  2019-01-02 |         3 | wednesday
  2019-01-03 |         4 | thursday 
  2019-01-04 |         5 | friday   
  2019-01-05 |         6 | saturday 
  2019-01-06 |         0 | sunday   
  ...
  2019-01-14 |         1 | monday   
  2019-01-15 |         2 | tuesday  
*/

-- my 
-- Replace with your code
CREATE FUNCTION weekdays(startDate DATE, endDate DATE)
RETURNS INTEGER
language plpgsql
as
$$
declare
   weekDaysCount INTEGER;
begin
        SELECT COUNT(*)
        FROM generate_series(
          CASE WHEN startDate <= endDate THEN startDate ELSE endDate END,
          CASE WHEN endDate <= startDate THEN startDate ELSE endDate END, '1 day'::interval) AS s
        WHERE extract(DOW from s) not in (0, 6)
        INTO weekDaysCount;
               
        RETURN weekDaysCount;
end;
$$;

SELECT weekdays('2016-01-01', '2016-01-10');

-- bp
-- Replace with your code
create or replace function weekdays(_start date, _finish date) 
returns integer
as
$$

  select count(*) filter (where extract(dow from g.d) between 1 and 5)::int as weekdays
  from generate_series(least(_start, _finish), greatest(_start, _finish), interval '1 day') as g(d);

$$ language sql;