--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

import pandas as pd
import sqlite3
conn = sqlite3.connect('TestDB.db')

conn.execute("drop table series")

df = pd.read_sql('''
with recursive generate_series(r1,r2,r3) as (
    select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    union all select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    from generate_series
    limit 10000)
select * from generate_series;
''', conn)


df.to_sql(name='series', con=conn)

import seaborn as sns
import matplotlib.pyplot as plt

fig, axs = plt.subplots(nrows=3, ncols=1,figsize = (10,6))
for i, coun in enumerate(df.columns):
    print(i,coun)
    ax = axs[i]
    sns.histplot(df[coun], color='g', alpha=0.7, ax=ax)

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

    select email
from (
    select email, count(*) as c
    from Person
    group by email  
)
where c >= 2

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select 
     t1.name as Employee
from 
     Employee t1,
     Employee t2 
where 1=1
    and t1.managerId  = t2.id
    and t1.Salary > t2.Salary
    
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
    
select score,
        dense_rank() over(order by score desc) as rank
from Scores;

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

    select p.firstName, p.lastName, a.city, a.state 
from Person p
left join Address a using (personId)
