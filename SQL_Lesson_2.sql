-- Задание 9: Посчитать количество возможных типов cd в таблице PC
select count(distinct cd) from pc 

-- Задание 10: Какое количество принтеров у каждого производителя (maker), стоимость (price) которых (принтера) больше 280
select maker, count(*)
from product pt 
join printer p 
on pt.model = p.model
where price > 280
group by maker

-- Задание 11: Найти модели принтеров с самой высокой ценой. Вывести: model, price
select model, price
from printer 
where price = (select max(price) from printer)

-- Задание 12: Вывести разницу в средней цене между PC и принтерами (Printer)
select round((select AVG(price) from printer)
		-
		(select AVG(price) from pc), 2)

-- Задание 13: Вывести производителей самых дешевых принтеров. Вывести price, maker
select p.price, maker
from product pt
join printer p 
on pt.model = p.model 
where price = (select min(price) from printer)		

-- Задание 14: Вывести производителей самых дешевых цветных принтеров (color = 'y')
select maker
from product pt
join printer p 
on pt.model = p.model 
where price = (select min(price) from printer where color = 'y')
and color = 'y'

-- Задание 15: Вывести все принтеры со стоимостью выше средней по принтерам
select type 
from printer
where price > (select avg(price) from printer)

-- Задание 16: Какое количество уникальных продуктов среди PC и Laptop
select count(distinct model)
from product 
where type = 'PC' or type = 'Laptop'

-- Задание 17: Какая средняя цена среди уникальных продуктов производителя = 'A' (только printer & laptop, без pc)
select (
	(select sum(price)
	from printer 
	join product 
	on printer.model = product.model 
	where maker = 'A')
+ 
	(select sum(price)
	from laptop 
	join product 
	on laptop.model = product.model 
	where maker = 'A')
) / 
(
	(select count(price)
	from printer 
	join product 
	on printer.model = product.model 
	where maker = 'A')
+ 
	(select count(price)
	from laptop 
	join product 
	on laptop.model = product.model 
	where maker = 'A')
)

-- Задание 18: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D'. Вывести model
select product.model 
from product
join printer 
	on printer.model = product.model
where maker = 'A' 
	and price < (select avg(price) from printer
			join product 
			on printer.model = product.model
			where maker = 'D') 

-- Задание 19: Найдите производителей, которые производили бы как PC со скоростью (speed) не менее 750, так и laptop со скоростью (speed) не менее 750. Вывести maker
	
select distinct product.maker 
from product 
left join pc
	on pc.model = product.model
right join laptop
	on laptop.model = product.model
where pc.speed >= 750
	or laptop.speed >= 750

-- Задание 20: Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

select product.maker, avg(pc.hd)
from product
join pc 
	on pc.model = product.model
group by product.maker
having maker in (select distinct maker from product
				join printer 
					on printer.model = product.model)
					



