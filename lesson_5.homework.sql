--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц


sample:
1 1
2 1
1 2
2 2
1 3
2 3

SELECT *, 
      case when num % 2 = 1 then 1 else 2 end as num_in_page,
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num
FROM (
      SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num
      FROM Laptop
) X;

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)

create view distribution_by_type as 
select maker, 
sum(flag_printer) * 100.0 / count(flag_printer) as printer_distr,
sum(flag_laptop) * 100.0  / count(flag_laptop) as laptop_distr, 
sum(flag_pc) * 100.0  / count(flag_pc) as pc_distr
from (
  select *, 
  case when type = 'Printer' then 1 else 0 end flag_printer, 
  case when type = 'Laptop' then 1 else 0 end flag_laptop, 
  case when type = 'PC' then 1 else 0 end flag_pc
  from product 
) a 
group by maker

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/



--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов

create table ships_two_words as 
select * 
from ships
where name like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select name
from ships s 
where 1=1
	--and class is null 
	and name like 'S%';

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select product.model 
from printer
join product 
on product.model = printer.model 
where maker  = 'A' 
and price  > (
  select avg(price) 
  from printer
  join product 
  on product.model = printer.model 
  where maker  = 'C' 
)
union all 
select model
from (
  select product.model, price, row_number(*) over (order by price desc) as rn  
  from printer
  join product 
  on product.model = printer.model 
) a 
where rn <= 3
