CREATE TABLE WORK(
Name VARCHAR(10) NOT NULL,
Team VARCHAR(12),
Salary INT,
SICKLEAVE INT,
ANNUALLEAVE INT
);

INSERT INTO WORK
VALUES
('ADAMS','RESEARCH',28000,34,14),
('WILKES','MARKETING',35000,40,10),
('STOKES','MARKETING',32000,22,27),
('MEZA','COLLECTIONS',43000,37,15),
('MERRICK','RESEARCH',47000,35,18),
('RICHARDSON','MARKETING',34500,21,26),
('FURY','COLLECTIONS',35000,27,22),
('PRECOURT','PR',41000,23,30);

/*1.Her bölümün ortalama maaşını (salary) hesaplayın. Sonuçları bölüm 
bilgisiyle beraber veriniz.
*/
SELECT Team,AVG(Salary)
FROM WORK
GROUP BY Team;

/*2. Ortalama maaşı 39000 in altında olan bölümleri bulunuz*/
SELECT Team,AVG(Salary)
FROM WORK
GROUP BY Team
HAVING AVG(Salary) < 39000;

/*3. Sağlık sorunlarından dolayı 25 günden daha az işinden ayrı kalanların 
maaşını bulunuz, sonuçları isme göre sıralayınız.*/
SELECT Salary, Name
FROM WORK
WHERE SICKLEAVE < 25
ORDER BY Name;

/*4. Her bir takımda sağlık sorunlarından dolayı 30 günden daha az işinden 
ayrı kalanların sayısını bulunuz*/
SELECT Team, COUNT(*)
FROM WORK
WHERE SICKLEAVE<30
GROUP BY Team;

/*5. Sağlık sorunlarından dolayı işinden ayrı kalma süresi yıllık izninden 
fazla olanların isimlerini bulunuz.*/
SELECT Name
FROM WORK
WHERE SICKLEAVE > ANNUALLEAVE;