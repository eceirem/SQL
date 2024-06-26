use test;
INSERT INTO PROJECT
VALUES
('ProductA',3,'Bellaire',6);
 Insert into WORKS_ON
 values
 ( '677678989',40,'40.0');
 
 
DELETE FROM PROJECT WHERE Pname = 'ProductY';
 
DELETE FROM department WHERE Dnumber = 5;

update  project set Pnumber=20 where Pnumber=3 ;

/*a. Ortalama çalışan maaşı (salary) $30000 den büyük olan her bir bölüm 
(department) için, bölüm ismi ve bu bölümde yer alan çalışanların 
(employee) sayısını bulunuz.*/
select Dname as department_name,count(*) as no_of_emp
from department as d, employee as e
where d.Dnumber = e.Dno
group by e.dno
having avg(e.salary)>30000;


/*b. Tüm çalışanlar içinde en fazla maaşı olan çalışanın yer aldığı bölümdeki tüm 
çalışanların isimlerini bulunuz.*/
select fname
from employee
where Dno = (select Dno from employee where salary = (select max(salary) from employee));


/*c. Her bir proje için proje numarası, proje ismi ve bu projede yer alan 
çalışanların sayısını bulunuz*/
select Pname,Pnumber,Count(*) as no_of_emp
from project as p, works_on as w
where w.Pno = p.Pnumber
group by Pname;


/*d. En az kazanan çalışandan, en az $10000 fazla kazanan tüm çalışanların 
isimlerini bulunuz.*/
select fname
from employee
where Dno in (select Dno 
            from employee 
            group by dno
            having salary >= (select min(salary) from employee)+10000);
            
            
    SELECT Dno 
    FROM employee 
    GROUP BY Dno 
    HAVING MIN(salary) + 10000 <= ANY(SELECT salary FROM employee);
/*a-) Yöneticilerinden (manager) fazla kazanan çalışanların (employee) isimlerini 
bulunuz.
*/
SELECT e.fname
FROM employee AS e
INNER JOIN department AS d ON d.Mgr_ssn = e.Ssn
WHERE e.salary > (SELECT salary FROM employee WHERE Ssn = d.Mgr_ssn);

/*b-) Yöneticileri ile aynı şehir ve aynı sokakta oturan çalışanların isimlerini bulunuz.*/
SELECT e.fname
FROM employee e
INNER JOIN department d ON e.Dno = d.Dnumber /*employee'deki dno'ların yanına department'daki Dnumber'lar gelmiş*/
INNER JOIN employee m ON d.Mgr_ssn = m.Ssn /*mgr_ssn ler ile employeedeki ssn ler eşleşmiş*/
WHERE e.Address = m.Address;

