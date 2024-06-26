USE test;
CREATE TABLE CHECKS(
CHECK_ID INT NOT NULL ,
PAYEE VARCHAR(20),
AMOUNT DECIMAL(10,2), 
REMARKS VARCHAR(30)
);
INSERT INTO CHECKS
VALUES
(1,'Migros',270.12,'Groceries'),
(2,'Petrol Ofisi',105.00,'Gas (For Car)'),
(3,'TCDD',25.00,'Train To Konya'),
(4,'Turkcell',528.00,'Cellular Phone'),
(5,'Baskent Elektrik',113.78,'Electricity Bill'),
(6,'Flo',175.00,'Shoes'),
(7,'Migros',315.90,'Groceries'),
(8,'Allianz Sigorta',365.43,'Car Insurance');

/*1. PAYEE leri M veya P ile başlayan bütün çeklerin CHECK_ID, PAYEE ve AMOUNT 
bilgilerini getiren sorguyu yazınız*/
SELECT CHECK_ID,PAYEE, AMOUNT
FROM CHECKS
WHERE PAYEE LIKE 'M%' OR PAYEE LIKE 'P%';



/*2. Car harcamaları ile ilgili tüm çeklerin CHECK_ID, PAYEE ve AMOUNT bilgilerini 
getiren sorguyu yazınız*/
SELECT CHECK_ID,PAYEE, AMOUNT
FROM CHECKS
WHERE REMARKS LIKE '%Car%';

/*3. Çek AMOUNT değeri 200.00 TL nin üzerinde olan bütün PAYEE leri getiren 
sorguyu yazınız. Tekrarlanan cevabın sadece bir kopyası gösterilecektir*/
SELECT DISTINCT PAYEE
FROM CHECKS
WHERE AMOUNT >200.00;

/*4. Tüm çeklerin tüm bilgilerini çek AMOUNT değerine göre azalan sıralı olacak 
şekilde getiren sorguyu yazınız*/
SELECT *
FROM CHECKS
ORDER BY AMOUNT DESC;

/*5. Shoes veya Groceries harcamaları ile ilgili tüm çeklerin CHECK_ID, PAYEE ve 
AMOUNT bilgilerini getiren sorguyu yazınız*/
SELECT CHECK_ID, PAYEE, AMOUNT
FROM CHECKS
WHERE REMARKS LIKE '%Shoes%' OR REMARKS LIKE '%Groceries%';