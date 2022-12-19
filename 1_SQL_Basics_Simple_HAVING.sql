/*
For this challenge you need to create a simple HAVING statement, 
you want to count how many people have the same age and
return the groups with 10 or more people who have that age.
*/

-- my
SELECT age, COUNT(id) as total_people
FROM people
GROUP BY age
HAVING COUNT(id) > 9;

-- bp
select age, count(*) as total_people
from people
group by age
having count(*) >= 10