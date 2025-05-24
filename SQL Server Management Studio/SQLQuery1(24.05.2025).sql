select * from users where gender='K' --e�ittir
select * from users where PASSWORD_ = 'srige'
--b�y�kt�r,k���kt�r,b�y�k e�ittir
select * from users where ID >= 7000
select * from users where ID < 10

--aras�nda
select * from USERS where ID between 10 and 15

--ba�layan biten
select * from users where NAMESURNAME like '%mu%'

--ba�layan
select * from users where NAMESURNAME like '%mu'
select * from users where NAMESURNAME like 'Ece%'

--in 
select * from users where ID in (3,4,5) --(id'si 3,4,5 aras�nda olanlardan)

--not in
select * from users where gender not in ('E')

---do�duklar� y�la g�re ya� hesab�n� yap�yoruz
update users set age=DATEDIFF(YEAR,BIRTHDATE,GETDATE())

select * from users where age>60 and gender='E' and NAMESURNAME like 'ali%'

---tekrarlama olmas�n
select distinct age,gender from users

---order by ile verileri s�ralar�z
select * from users where age>60 and GENDER='E' and NAMESURNAME like 'Ali%'
order by age desc

---isim koyup sat�� tablosundaki 2020 y�l�ndaki ciro:
select sum(LINETOTAL) as C�RO from SALEORDERS where YEAR_=2020

---2020 y�l�nda ka� tane i�lem oldu�unu getiriyoruz
select COUNT(*) as ��LEMLER from SALEORDERS where YEAR_ = 2020

---bir m��terinin minimum yapt��� al��veri� tutar�
select min(LINETOTAL) from SALEORDERS where YEAR_=2020
select max(LINETOTAL) from SALEORDERS where YEAR_=2020
select avg(LINETOTAL) from SALEORDERS where YEAR_=2020

select sum(LINETOTAL) as TotalLineTotal,
 min(LINETOTAL) as mintutar,
 max(LINETOTAL) as maxtutar,
 avg(LINETOTAL) as ortalamatutar
 from SALEORDERS where YEAR_=2020

---bir de il baz�nda bakal�m
select sum(LINETOTAL) as TotalLineTotal,
 min(LINETOTAL) as mintutar,
 max(LINETOTAL) as maxtutar,
 avg(LINETOTAL) as ortalamatutar
 from SALEORDERS where YEAR_=2020 and CITY='Samsun'

 ---Group by
 ---�ehirlerin toplam cirosu isteniyor, ancak altta yazan kodda bir �ehirden birden fazla var
 select CITY,LINETOTAL from SALEORDERS where YEAR_=2020

 ---�imdi her �ehir 1 kere g�z�ks�n ve alfabetik s�ralans�n
 select CITY as �ehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
 group by CITY
 order by �ehir

---�imdi her �ehir 1 kere g�z�ks�n ve k�ra g�re s�ralans�n �oktan aza
select CITY as �ehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
group by CITY
order by ciro desc

---hem �ehir hem markaya g�re gruplayal�m
select BRAND as marka, CITY as �ehir,sum(LINETOTAL) as ciro from SALEORDERS where YEAR_=2020
group by CITY,BRAND
order by ciro desc

---dalin markas�n�n g�n bazl� sat�� adedini ar�yorum 
---ki o g�nlerde reklam yapay�m ya da kampanya ��karay�m
select DAYOFWEEK_ , SUM(AMOUNT) as G�nl�kSat��
from SALEORDERS 
where BRAND='DALIN'
group by DAYOFWEEK_

--- 
select * from SALEORDERS
where BRAND = 'DALIN'


---dalin markas�n�n hangi kategorisi satt���n� bulmak istiyorum
select CATEGORY1,CATEGORY2,CATEGORY3, sum(AMOUNT)Amount 
from SALEORDERS
where BRAND='DALIN'
group by CATEGORY1,CATEGORY2,CATEGORY3