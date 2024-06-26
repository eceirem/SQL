use test;
CREATE TABLE Student(
snum INT NOT NULL,
sname VARCHAR(15),
major VARCHAR(10),
level VARCHAR(10),
age INT
);
CREATE TABLE Class(
name CHAR(6) NOT NULL,
meetsat VARCHAR(20),
room CHAR(4),
fid INT NOT NULL
);

CREATE TABLE Faculty(
fid INT NOT NULL,
fname VARCHAR(10) NOT NULL,
deptid CHAR(4)
);

CREATE TABLE Enrolled(
SNUM INT NOT NULL,
name CHAR(6) NOT NULL
);

INSERT INTO Student
VALUES
(1234,'Ahmet Kartal','History','Senior',21),
(3456,'Mehmet Sahin','Math','Junior',18),
(2356,'Hasan Dogan','Statistics','Freshmen',17),
(3345,'Ali Serce','Comp. Eng.','Sophomore',18),
(1256,'Murat Baykus','History','Junior',20),
(9874,'Fatma Seyhan','History','Junior',18),
(5643,'Emine Ceyhan','Comp. Eng.','Senior',19),
(5649,'Gulay Sakarya','Comp. Eng','Senior',20);


INSERT INTO Class
VALUES
('HIS105','Tuesday 10:30','R128',48),
('MAT108','Thursday 13:30','R128',48),
('MAT107','Friday 14:30','R111',45),
('HIS207','Monday 15:30','R111',48),
('HIS105','Wednesday 15:30','R345',48),
('ENG208','Monday 15:30','R345',46),
('MAT101','Wednesday 11:30','R345',45),
('ENG205','Friday 10:30','R128',41);

INSERT INTO Faculty
VALUES
(45,'Bugra H.',1298),
(46,'Demir R.',1317),
(48,'Semih Z.',1405),
(41,'Selin C.',2396),
(47,'Zeynep Z.',2453),
(49,'Zafer K.',2198);

INSERT INTO Enrolled
VALUES
(1234,'HIS105'),
(1234,'HIS207'),
(1234,'ENG208'),
(1234,'ENG205'),
(3456,'MAT108'),
(3456,'MAT107'),
(3456,'MAT101'),
(2356,'MAT107'),
(3345,'MAT101'),
(3345,'ENG208'),
(1256,'HIS105'),
(1256,'HIS207'),
(1256,'MAT101'),
(1256,'ENG208'),
(9874,'HIS105'),
(9874,'HIS207'),
(9874,'MAT108'),
(5643,'ENG208'),
(5643,'MAT107'),
(5643,'ENG205');

/*1. 45 id li faculty (instructor) tarafından verilen derslere kayıt yaptıran tüm 
‘Junior’ ların isimlerini bulan bir sorgu yazınız.*/
SELECT DISTINCT S.sname
FROM Class AS C, Enrolled AS E, Student AS S
WHERE C.fid = 45 AND C.name = E.name AND E.snum = S.snum AND S.level = 'Junior' ;

/*2. 45 id li faculty (instructor) tarafından verilen derslere kayıt yaptıran ya 
da ‘History’ bölümünden olanlar arasında en yaşlı öğrencinin yaşını bulan 
bir sorgu yazınız.*/

SELECT MAX(AGE)
FROM STUDENT
WHERE (SELECT MAX(AGE)
        FROM CLASS,ENROLLED,STUDENT
        WHERE fid=45 and Class.name=Enrolled.name and Enrolled.snum = Student.snum)
        
        OR
        
        (SELECT MAX(AGE)
        FROM STUDENT
        WHERE major='History');
        
/*Alternatif çözüm*/
select max(age) from student where (student.major='History') or
(student.snum in (select enrolled.SNUM 
                from class, enrolled 
                where fid = 45 and enrolled.name = class.name));

/*3. R128 dersliğinde yapılan ya da üç veya daha fazla öğrencinin kayıt 
olduğu derslerin (class) isimlerini bulan bir sorgu yazınız. */

select DISTINCT class.name
from class
where (class.room = 'R128' )
        OR 
        (class.name in (select enrolled.name 
        from enrolled 
        GROUP BY Enrolled.name
        HAVING COUNT(*)>=3));


/*4. Aynı zamanda yapılan iki derse de (çakışan derslere) kayıt olan 
öğrencilerin isimlerini bulan bir sorgu yazınız.*/
select distinct student.sname
from student
where student.snum in (select e1.snum
                        from class as c1, class as c2, enrolled as e1, enrolled as e2
                        where e1.snum = e2.snum /*dersleri çakşan öğrenciler için 
                        snum eşitliği lazım. 1234 ile 3456 nın aynı dersi alması bir çakışma değil
                        farklı numaralara sahipler 1234'ün aynı dersten alması lazım*/
                        and
                        e1.name <> e2.name /*iki farklı dersin çakışması için kontrol yani HIS105
                        ile HIS105'i karşılaştırmak saçma olur*/
                        and
                        e1.name=c1.name
                        and
                        e2.name = c2.name
                        and
                        c1.meetsat = c2.meetsat);

/*5. Ders verilen bütün dersliklerde ders veren faculty (instructor) lerin 
isimlerini bulan bir sorgu yazınız.*/
SELECT F.fname
FROM Faculty AS F
INNER JOIN Class AS C ON F.fid = C.fid
GROUP BY F.fname
HAVING COUNT(DISTINCT C.room) = (SELECT COUNT(DISTINCT room) FROM Class);

/*6. Verdiği tüm derslere kayıt olan öğrencilerin sayısı toplamda 5 ten az 
olan faculty (instructor) lerin isimlerini bulan bir sorgu yazınız.
*/
select distinct fname 
from faculty f 
where 5 > (select count(e.snum)
            from enrolled e,class c 
            where 
            c.name=e.name
            and 
            c.fid=f.fid);
            
            
/*7. Her bir ‘level’ için o ‘level’ ın ismini ve o ‘level’ daki öğrencilerin ortalama 
yaşını bulan bir sorgu yazınız*/
SELECT level, avg(age)
from student
group by level;


/*8. ‘Junior’ dışındaki her bir ‘level’ için o ‘level’ ın ismini ve o ‘level’ daki 
öğrencilerin ortalama yaşını bulan bir sorgu yazınız.*/
SELECT level, avg(age)
from student
where level <> 'junior'
group by level;

