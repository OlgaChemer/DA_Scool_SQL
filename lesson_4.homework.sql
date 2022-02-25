--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select model, maker, type
from product 
order by maker, type

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *, 
	case 	
		when price > (select avg(price) from printer)
		then 1
		else 0
		end flag
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select 
	ship,
	"class" as class_
from 
	outcomes o
left join
	ships sh on sh."name" = o.ship 
where 1=1
	and "class" is null



--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

select b.name
from battles b
join outcomes o 
	on b.name = o.battle
join ships s
	on o.ship = s.name
where Extract(YEAR from date::date ) != launched



--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select b.name
from battles b 
join outcomes o 
	on b.name = o.battle
join ships s
	on o.ship = s.name
where class = 'Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, 
-- если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as
	with t1 (model, price)
	as (select model, price 
					from pc p 
					union all
					select model, price
					from printer p2 
					union all
					select model, price
					from laptop)
	select *, 
			case
				when price > 300
				then 1
				else 0
				end flag
	from t1

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
	with t1 (model, price)
	as (select model, price 
					from pc p 
					union all
					select model, price
					from printer p2 
					union all
					select model, price
					from laptop)
	select *, 
			case
				when price > (select avg(price) from t1)
				then 1
				else 0
				end flag
	from t1	
	
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам 
-- производителя = 'D' и 'C'. Вывести model

select p.model
from printer p 
join product p2 
	on p.model = p2.model
where 1=1
	and maker = 'A'
	and price > (select avg(price)
				 from printer p 
				 join product p2 
					on p.model = p2.model
				 where maker in ('D', 'C')
				 )
	
	
--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. 
--Вывести model

select p.model
from product p 
join (select model, price 
		from pc p 
		union all
		select model, price
		from printer p2 
		union all
		select model, price
		from laptop) t1
	on p.model = t1.model
where 1=1
	and maker = 'A'
	and price > (select avg(price)
				 from printer p 
				 join product p2 
					on p.model = p2.model
				 where maker in ('D', 'C'))
				 
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)

select round(avg(avg_price), 2)
from (select avg(price) as avg_price
		from product p
		join (select model, price 
				from pc p 
				union all
				select model, price
				from printer p2 
				union all
				select model, price
				from laptop) t1
			on p.model = t1.model
		where maker = 'A'
		group by t1.model) tt

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. 
-- Во view: maker, count
create view count_products_by_makers as(
	select maker, count(model) as cnt
	from product
	group by maker
	order by cnt)
	
		
--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

-- Done
	
--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'

	
create table printer_updated as (
	select *
	from printer
	where model in (select p.model
					from printer p
					join product po
						on p.model = po.model
					where maker !='D')
	)
	
--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой 
-- производителя (название printer_updated_with_makers)

create view printer_updated_with_makers as (
	select 	pu.code, 
			pu.model, 
			pu.color, 
			pu.type, 
			pu.price, 
			po.maker
	from printer_updated pu
	join product po
		on pu.model = po.model
	)

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). 
-- Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
	
create view sunk_ships_by_classes as
	select count(o.result) as cnt,
	case 
		when class is null
		then '0'
		else "class" 
		end class_
	from outcomes o
	left join
		ships sh on sh."name" = o.ship 
	group by "class";

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

-- Done
		
--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий 
--больше или равно 9 - то 1, иначе 0

create table classes_with_flag as 
select *, 
	case 
		when numguns >= 9
		then 1
		else 0
		end flag
from classes c
		
--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

select country, count("class") cnt
from classes
group by country 
		
--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(*)
from 
	(select ship
	from outcomes o 
	union 
	select name
	from ships s ) t1
where ship like 'O%' 
	or t1.ship like 'M%'

	
--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(*)
from 
	(select ship
	from outcomes o 
	union 
	select name
	from ships s ) t1
where ship like '%_ %_' 
		
	
	
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

select 
	count(name) as cnt,
	launched as year
from 
	ships s
group by year
