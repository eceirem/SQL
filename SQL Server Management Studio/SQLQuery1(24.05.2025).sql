select * from users where gender='K' --eþittir
select * from users where PASSWORD_ = 'srige'
--büyüktür,küçüktür,büyük eþittir
select * from users where ID >= 7000
select * from users where ID < 10

--arasýnda
select * from USERS where ID between 10 and 15

--baþlayan biten
select * from users where NAMESURNAME like '%mu%'

--baþlayan
select * from users where NAMESURNAME like '%mu'
select * from users where NAMESURNAME like 'Ece%'

--in 
select * from users where ID in (3,4,5) --(id'si 3,4,5 arasýnda olanlardan)

--not in
select * from users where gender not in ('E')

---doðduklarý yýla göre yaþ hesabýný yapýyoruz
update users set age=DATEDIFF(YEAR,BIRTHDATE,GETDATE())

select * from users where age>60 and gender='E' and NAMESURNAME like 'ali%'

---tekrarlama olmasýn
select distinct age,gender from users

---order by ile verileri sýralarýz
select * from users where age>60 and GENDER='E' and NAMESURNAME like 'Ali%'
order by age desc

---isim koyup satýþ tablosundaki 2020 yýlýndaki ciro:
select sum(LINETOTAL) as CÝRO from SALEORDERS where YEAR_=2020

---2020 yýlýnda kaç tane iþlem olduðunu getiriyoruz
select COUNT(*) as ÝÞLEMLER from SALEORDERS where YEAR_ = 2020

---bir müþterinin minimum yaptýðý alýþveriþ tutarý
select min(LINETOTAL) from SALEORDERS where YEAR_=2020
select max(LINETOTAL) from SALEORDERS where YEAR_=2020
select avg(LINETOTAL) from SALEORDERS where YEAR_=2020

select sum(LINETOTAL) as TotalLineTotal,
 min(LINETOTAL) as mintutar,
 max(LINETOTAL) as maxtutar,
 avg(LINETOTAL) as ortalamatutar
 from SALEORDERS where YEAR_=2020

---bir de il bazýnda bakalým
select sum(LINETOTAL) as TotalLineTotal,
 min(LINETOTAL) as mintutar,
 max(LINETOTAL) as maxtutar,
 avg(LINETOTAL) as ortalamatutar
 from SALEORDERS where YEAR_=2020 and CITY='Samsun'

 ---Group by
 ---þehirlerin toplam cirosu isteniyor, ancak altta yazan kodda bir þehirden birden fazla var
 select CITY,LINETOTAL from SALEORDERS where YEAR_=2020

 ---þimdi her þehir 1 kere gözüksün ve alfabetik sýralansýn
 select CITY as þehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
 group by CITY
 order by þehir

---þimdi her þehir 1 kere gözüksün ve kâra göre sýralansýn çoktan aza
select CITY as þehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
group by CITY
order by ciro desc

---hem þehir hem markaya göre gruplayalým
select BRAND as marka, CITY as þehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
group by CITY,BRAND
order by ciro desc

---dalin markasýnýn gün bazlý satýþ adedini arýyorum 
---ki o günlerde reklam yapayým ya da kampanya çýkarayým
select DAYOFWEEK_ , SUM(AMOUNT) as GünlükSatýþ
from SALEORDERS 
where BRAND='DALIN'
group by DAYOFWEEK_

--- 
select * from SALEORDERS
where BRAND = 'DALIN'


---dalin markasýnýn hangi kategorisi sattýðýný bulmak istiyorum
select CATEGORY1,CATEGORY2,CATEGORY3, sum(AMOUNT)Amount 
from SALEORDERS
where BRAND='DALIN'
group by CATEGORY1,CATEGORY2,CATEGORY3