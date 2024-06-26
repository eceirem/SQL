use test;

CREATE TABLE Customer(
Name    varchar(20) not null,
Address varchar(15),
State   char(2),
ZIP     int(5),
Phone   char(8),
Remarks varchar(10) default null,
Primary Key (Name)
);

CREATE TABLE Part(
Partnum    int(2) not null,
Descripton varchar(15),
Price       decimal(10,2),
Primary Key (PartNum)
);

CREATE TABLE Orders(
Orderedon   date not null,
Name        varchar(20) not null,
Partnum     int(2) not null,
Quantity    int,
Remarks     varchar(10) default 'PAID',
Primary Key (Orderedon,Name,Partnum)
);

insert into Customer
values
('TRUE WHEEL','550 HUSKER','NE',58702,'555-4545','NONE'),
('BIKE SPEC','CPT SHRIVE','LA',45678,'555-1234','NONE'),
('LE SHOPPE','HOMETOWN','KS',54678,'555-1278','NONE'),
('AAA BIKE','10 OLDTOWN','NE',56784,'555-3421','JOHN-MGR'),
('JACKS BIKE','24 EGLIN','FL',34567,'555-2314','NONE');

insert into Part
values
(54,'PEDALS',54.25),
(42,'SEATS',24.50),
(46,'TIRES',15.25),
(23,'MOUNTAIN BIKE',350.45),
(76, 'ROAD BIKE',530.00),
(10, 'TANDEM',1200.00);

insert into Orders
values
('1996-05-15','TRUE WHEEL',23,6,'PAID'),
('1996-05-19','TRUE WHEEL',76,3,'PAID'),
('1996-09-02','TRUE WHEEL',10,1,'PAID'),
('1996-06-30','TRUE WHEEL',42,8,'PAID'),
('1996-06-30','BIKE SPEC',54,10,'PAID'),
('1996-05-30','BIKE SPEC',10,2,'PAID'),
('1996-05-30','BIKE SPEC',23,8,'PAID'),
('1996-01-17','BIKE SPEC',76,11,'PAID'),
('1996-01-17','LE SHOPPE',76,5,'PAID'),
('1996-06-01','LE SHOPPE',10,3,'PAID'),
('1996-06-01','AAA BIKE',10,1,'PAID'),
('1996-07-01','AAA BIKE',76,4,'PAID'),
('1996-07-01','AAA BIKE',46,14,'PAID'),
('1996-07-11','JACKS BIKE',76,14,'PAID');

/*toplam kazanılan para miktarını bulan sorguyu yazınız.*/
select sum(o.quantity*p.price)
from orders as o join part as p on p.Partnum=o.Partnum;

/*2.	Her bir customer a yapılan satış miktarını (parasal değeri) bulan sorguyu yazınız. */
select o.Name as Customers, sum(o.quantity*p.price) as Earned_Money
from orders as o join part as p on p.Partnum=o.Partnum
group by o.name;

/*3.	Her bir part dan kaç adet satıldığını bulan sorguyu yazınız. */
select p.Descripton as Sold_Item, sum(o.quantity) as Total_Item
from orders as o join part as p on p.Partnum=o.Partnum
group by p.Descripton;

/*4.	Mountain Bike satışlarından kazanılan toplam para miktarını bulan sorguyu yazınız. */
select sum(o.quantity*p.price) as Earned_Money
from orders as o join part as p on p.Partnum=o.Partnum
where p.Descripton = 'MOUNTAIN BIKE';

/*5.	Aşağıdaki çıktıyı veren sorguyu yazınız. 
Name-Address-Total-Description*/
select c.name,c.address,sum(o.quantity*p.price) as total, p.descripton
from Customer AS c
JOIN Orders AS o ON c.Name = o.Name
JOIN Part AS p ON o.Partnum = p.Partnum
group by name,descripton;

/*6. Aşağıdaki çıktıyı veren sorguyu yazınız. 
Çıktı:
orderedon - name - partnum - quantity
'1996-09-02' 'TRUE WHEEL' 10 1*/
select orderedon, name, partnum, quantity
from orders
where partnum=10 and name='TRUE WHEEL';

