--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920

SELECT name, class
FROM ships 
WHERE launched > 1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942

SELECT name, class
FROM ships 
WHERE launched > 1920 and launched <= 1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class

select count(name), class 
from ships s 
group by class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)

select class, country 
from classes
where bore >= 16
group by class, country

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.

select ship
from outcomes 
where result = 'sunk' and battle = 'North Atlantic'

-- Задание 6: Вывести название (ship) последнего потопленного корабля

select o1.ship 
from outcomes o1 
join battles b1 
	on o1.battle = b1.name
where 1=1
	and result = 'sunk' 
	and date = (select
					max(date)
				from battles b2
				join outcomes o2 on o2.battle = b2.name
				)

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля

select o1.ship, s.class 
from outcomes o1 
join battles b1 
	on o1.battle = b1.name
join ships s 
	on o1.ship = s.name
where 1=1
	and result = 'sunk' 
	and date = (select
					max(date)
				from battles b2
				join outcomes o2 on o2.battle = b2.name
				)

-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class

select o1.ship, s.class 
from outcomes o1 
join ships s 
	on o1.ship = s.name
join classes c
	on c.class = s.class
where 1=1
	and result = 'sunk' 	
	and bore >= 16


-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class

select c.class 
from classes c
join ships s
	on c.class = s.class
join outcomes o 
	on s.name = o.ship
where country = 'USA'


-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class

select name, s.class 
from ships s 
join classes c
	on c.class = s.class
where country = 'USA'
