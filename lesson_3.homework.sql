--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select classes.class, count(t1.ship)
FROM classes
left join
(select outcomes.ship, ships.class
       from outcomes
      left join ships on ships.name = outcomes.ship
       where outcomes.result = 'sunk'
    ) as t1 on t1.class = classes.class or t1.ship = classes.class
group by classes.class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен,
-- определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

	
select c.class, min(launched)
	from ships s
join classes c
	on s.class = c.class 
group by c.class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select name, s 
from (
SELECT c.class as name, SUM(outc) as s, count(*) as c
FROM Classes c LEFT JOIN 
 Ships s ON c.class = s.class LEFT JOIN 
 (
 SELECT ship, 1 as outc 
 FROM Outcomes 
 WHERE result = 'sunk'
 ) o ON s.name = o.ship OR 
 c.class = o.ship 
GROUP BY c.class
) a 
where s is not null and c >= 3
	

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select s.name, sum(c.numguns) Cnt_gun
from ships s
join classes c
on s.class = c.class
group by c.displacement, s.name
order by Cnt_gun desc 
limit 1


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и 
--с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select p.maker
from product p 
join pc p2 
	on p.model = p2.model 
where ram = (select min(ram) from pc)
	and speed = (select max(speed) from pc)
group by p.maker, ram
having ram = (select min(ram) from pc)
