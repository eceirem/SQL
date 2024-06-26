USE test;
CREATE TABLE STUDENTS(
Student_ID  INT NOT NULL,
Student_Name    VARCHAR(15),
GPA DECIMAL(10,2),
AGE INT
);

INSERT INTO STUDENTS
VALUES
(17,'Ali K.',3.56,21),
(11,'Mehmet S.',2.12,18),
(25,'Ayhan D.',1.78,17),
(27,'Fatma B.',2.45,17),
(68,'Fulya K.',2.67,19),
(62,'Ahmet T.',3.03,20),
(42,'Yasemin K.',3.48,22),
(45,'Nilüfer C.',3.12,18),
(28,'Mehmet R.',2.89,23),
(36,'Mustafa D',1.56,18);


/*1. Tüm öğrencilerin isimlerini ve yaşlarını bulunuz*/
SELECT Student_Name, AGE
FROM STUDENTS;

/*2. 3.00 ın üzerinde GPA e sahip öğrencilerin isimlerini ve id 
lerini bulunuz.*/
SELECT Student_Name, Student_ID
FROM STUDENTS
WHERE GPA>3.00;

/*3. 2.50 nin üzerinde GPA e sahip öğrencilerin GPA 
ortalamalarını bulunuz*/
SELECT AVG(GPA)
FROM STUDENTS
WHERE GPA>2.50;

/*4. Maksimum yaş ı bulunuz.*/
SELECT MAX(AGE)
FROM STUDENTS;

/*5. Yaşların ortalamasını ve GPA lerin ortalamasını bulunuz*/
SELECT AVG(AGE) AS AverageOfAges, AVG(GPA) AS AverageOfGPAs
FROM STUDENTS;

/*6. İsmi ‘M’ harfi ile başlayan öğrencilerin yaşlarının ortalamasını 
bulunuz.*/
SELECT AVG(AGE)
FROM STUDENTS
WHERE Student_Name LIKE 'M%';
/*7. Tablodaki tüm bilgileri yaşa göre azalan düzende olacak 
şekilde gösteriniz.*/
SELECT *
FROM STUDENTS
ORDER BY AGE DESC;