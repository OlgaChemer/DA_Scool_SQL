--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
     case 
        when g.Grade < 8 
        then NULL 
        else  s.Name
        end Name,
    g.Grade, 
    s.Marks
FROM Students s,  Grades g
WHERE s.Marks BETWEEN Min_Mark AND Max_Mark
ORDER BY g.Grade DESC, s.Name

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
    ) temp
group by RowNumber;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

select distinct CITY 
from STATION
where CITY REGEXP '^[^aeiou]';

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct CITY 
from STATION
where CITY not REGEXP '[aeiou]$';

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

select distinct CITY 
from STATION
where CITY  REGEXP '^[^aeiou]'
or CITY not REGEXP '[aeiou]$';

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct CITY 
from STATION
where CITY  REGEXP '^[^aeiou]'
and CITY not REGEXP '[aeiou]$';

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select name
from Employee
where months < 10 and salary > 2000
order by employee_id 

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
     case 
        when g.Grade < 8 
        then NULL 
        else  s.Name
        end Name,
    g.Grade, 
    s.Marks
FROM Students s,  Grades g
WHERE s.Marks BETWEEN Min_Mark AND Max_Mark
ORDER BY g.Grade DESC, s.Name
