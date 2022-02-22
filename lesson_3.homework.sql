--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select c.class, count(o.ship)
from ships s
left join outcomes o
on o.ship = s.name
LEFT join classes c 
on c.class = s.class
where result = 'sunk'
group by c.class
having count(o.ship) >= 0

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

select c.class, count(o.result)
from ships s
join outcomes o 
on s.name = o.ship
join classes c 
on s.class = c.class
group by c.class
having result = 'sunk' and count(o.ship) > 2
	

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
