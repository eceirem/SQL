USE test;
SELECT * FROM EMPLOYEE  WHERE Dno = 5; /*departmanın numarasının 5 olduğunu bilemeyebilirim*/
SELECT * FROM EMPLOYEE, DEPARTMENT WHERE Dname='Research' AND Dnumber = Dno; /*burada birbirine bağlamazsam 
foreign key ile ulaşıp dno su 5 olanı alıp dnumberı 5 olanla eşleştirip göremem*/
SELECT Pnumber,Dnum,Lname,Address,Bdate 
FROM PROJECT,DEPARTMENT,EMPLOYEE
WHERE Plocation = 'Stafford' AND Dnum = Dnumber AND Mgr_ssn = Ssn;
SELECT * FROM EMPLOYEE, Department; /*cross product şeklinde yapar ve her kişi 3 departmanda da var gibi çalışır*/

SELECT Fname,Salary FROM EMPLOYEE;
SELECT DISTINCT Salary FROM EMPLOYEE;
/*soyadı smith olan bir kişinin hem yönetici hem de çalışan olarak dahil olduğu tüm projeleri göstersin*/
(SELECT  DISTINCT Pnumber 
FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE Dnum=Dnumber AND Mgr_ssn = Ssn AND Lname = 'Smith')
UNION
(SELECT  DISTINCT Pnumber 
FROM PROJECT, WORKS_ON, EMPLOYEE
WHERE Pnumber=Pno AND Essn = Ssn AND Lname = 'Smith');

/*Retrieve all employees whose address is in Houston,TX*/
SELECT Fname,Lname
FROM EMPLOYEE
WHERE Address LIKE '%Houston,TX%';

/*1960 larda doğanları bul*/

SELECT Fname
FROM EMPLOYEE
WHERE Bdate LIKE '__6_______';
/*projectx de çalışanların maaşlarına %10 artış*/
SELECT E.Fname, E.Lname, 1.1*E.Salary AS Increased_Salary
FROM EMPLOYEE AS E, PROJECT AS P, WORKS_ON AS W
WHERE P.Pname = 'ProductX' AND P.Pnumber = W.Pno AND W.Essn = E.Ssn;

/*departman 5'te olup 30-40k maaş alanları bastır*/
SELECT Fname
FROM EMPLOYEE
WHERE Dno=5 AND (Salary BETWEEN 30000 AND 40000);
/*departmanları ve çalıştıkları oroje adları yazacak ve önce departmana 
sonra soyada ve en son isme göre sıralanacak şekilde kişiler bastırılsın*/
SELECT D.Dname, E.Lname, E.Fname, P.Pname
FROM EMPLOYEE AS E, DEPARTMENT AS D, WORKS_ON AS W, PROJECT AS P
WHERE P.PNUMBER = W.Pno AND W.Essn = E.Ssn AND E.Dno = D.Dnumber 
ORDER BY D.Dname, E.Lname, E.Fname;


USE test;
SELECT Hours
FROM WORKS_ON 
WHERE (Pno, Hours) IN (SELECT Pno, Hours
                       FROM WORKS_ON
                        WHERE Essn = '123456789');
            

UPDATE EMPLOYEE
SET Salary = 30000
WHERE Fname = 'James';

SELECT Fname,Lname,Salary
FROM EMPLOYEE
WHERE Super_ssn IS NOT NULL;

/*en yüksek 2. maaşa sahip kişileri göster
Çözüm 1*/
SELECT Fname, Lname, Salary AS second_max_salary
FROM EMPLOYEE
WHERE SALARY < (SELECT MAX(Salary)
                FROM EMPLOYEE)
ORDER BY Salary DESC 
LIMIT 1;

/*Çözüm 2*/
SELECT Lname, Fname, Salary
FROM EMPLOYEE
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EMPLOYEE
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EMPLOYEE
    )
);

/*bağımlılığı olmayan kişileri göster*/
SELECT Fname, Lname
FROM EMPLOYEE AS E
WHERE NOT EXISTS (SELECT *
                FROM DEPENDENT AS D
                WHERE E.Ssn = D.Essn);
                
/*En az bir bağımlılığı olan managerları göster*/

SELECT Fname, Lname
FROM EMPLOYEE AS E
WHERE EXISTS (SELECT *
                FROM DEPENDENT AS D
                WHERE E.Ssn = D.Essn)
        AND 
        EXISTS  (SELECT *
                FROM DEPARTMENT AS D
                WHERE E.Ssn = D.Mgr_ssn);
    
/*proje 1 2 ve 3'te çalışan kişilerin ssnlerini göster*/
SELECT DISTINCT Ssn
FROM EMPLOYEE AS E, WORKS_ON AS W
WHERE E.Ssn = W.Essn AND (W.Pno=1 OR W.Pno=2 OR W.Pno=3);
/*2. yol*/
SELECT DISTINCT Essn
FROM WORKS_ON
WHERE Pno IN (1,2,3);

USE test;


SELECT *
FROM EMPLOYEE JOIN DEPARTMENT ON Ssn=Mgr_ssn;



SELECT *
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D
ON E.Ssn = D.Mgr_ssn;


SELECT *
FROM   (EMPLOYEE AS E RIGHT OUTER JOIN EMPLOYEE AS S ON E.Super_ssn = S.Ssn);

SELECT E.Lname AS Employee_name,
       S.Lname AS Supervisor_name
FROM   (EMPLOYEE AS E LEFT OUTER JOIN EMPLOYEE AS S ON E.Super_ssn = S.Ssn);


SELECT Pnumber,Dnum,Fname,Lname,Address
FROM ((PROJECT AS P JOIN DEPARTMENT AS D ON P.Dnum = D.Dnumber)
         JOIN EMPLOYEE AS E ON D.Dnumber = E.Dno)
WHERE Plocation ='Stafford';


/*research departmanında çalışan kişilerin maaşlarının toplamını, max ve min i bul*/
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE AS E, DEPARTMENT AS D
WHERE D.Dnumber = E.Dno AND  D.Dname = 'Research';

/*alternatif çözüm*/
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber
WHERE Dname = 'Research';

/*research departmanında çalışanların sayısını bul*/
SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber
WHERE Dname = 'Research' ;

select count(distinct Salary)
from employee;

SELECT COUNT(*) AS ProjectNUmberOfDepartment , Dnum
FROM PROJECT
GROUP BY Dnum;

/*PROJE İSMİ NOSU ve çalışan sayısını göstersin*/
SELECT Pname AS Project_Name, COUNT(*) AS NumberOfEmployee
FROM PROJECT INNER JOIN WORKS_ON ON Pnumber=Pno
GROUP BY Pnumber;
/*projede 2 den fazla çalışanı olanları göstersin*/
SELECT Pnumber, Pname AS Project_Name, COUNT(*) AS NumberOfEmployee
FROM PROJECT INNER JOIN WORKS_ON ON Pnumber=Pno
GROUP BY Pnumber
HAVING COUNT(*)>2;

