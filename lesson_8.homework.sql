--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select d.name as Department, e.name as Employee, e.Salary
from Employee e
join Department d on e.departmentId = d.id
where 3 > (select count(distinct e2.Salary from Employee e2
          where e2.Salary > e.Salary
            AND e.departmentId = e2.departmentId ))
order by d.name, e.Salary;

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

select fm.member_name, fm.status, sum(p.amount * p.unit_price) as costs
from FamilyMembers fm
join Payments p on fm.member_id = p.family_member
where date like '2005%'
group by fm.member_name, fm.status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name 
from Passenger
group by name 
having count(*) > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count(*) as Count
from student 
where first_name = 'Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(classroom) as count
from  Schedule 
where date like '2019-09-02%'
group by date

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count(*) as Count
from student 
where first_name = 'Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

select FLOOR(avg(YEAR(CURRENT_DATE) - YEAR(birthday))) as age
from FamilyMembers;

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select GoodTypes.good_type_name, sum(Payments.amount * Payments.unit_price) as costs
from GoodTypes 
join Goods on GoodTypes.good_type_id = Goods.type
join Payments on Goods.good_id = Payments.good
where Payments.date like '2005%'
group by  GoodTypes.good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

select MIN(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE)) as year
from Student


--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

select max(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE)) as max_year
from Student
join Student_in_class on Student.id = Student_in_class.student
join Class on Student_in_class.class = Class.id
where Class.name LIKE '10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select FamilyMembers.status, 
       FamilyMembers.member_name, 
       SUM(Payments.amount * Payments.unit_price) as costs
FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id = Payments.family_member
JOIN Goods ON Payments.good = Goods.good_id 
JOIN GoodTypes ON Goods.type = GoodTypes.good_type_id
WHERE GoodTypes.good_type_name = 'entertainment'
group by FamilyMembers.status, FamilyMembers.member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from Company
where Company.id in 
    (SELECT company 
    from Trip 
    group by company
    having count(id) = (select min(count)
                        from (select count(id) as count
                              from Trip
                              group by company) as a)
                  );
                 
--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select classroom
from Schedule
group by classroom
having count(classroom) = (select count(classroom) from Schedule
                            GROUP BY classroom
                            order by classroom DESC 
                            limit 1);


--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name
from Teacher
join Schedule on Teacher.ID = Schedule.teacher
join Subject ON Schedule.subject = Subject.id
where Subject.name = 'Physical Culture'
order by last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select concat(last_name, '.', left(first_name, 1), '.', left(middle_name, 1), '.') as name
from Student
order by last_name, first_name;
