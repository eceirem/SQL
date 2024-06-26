USE test;

CREATE TABLE test.EMPLOYEE
(Fname   VARCHAR(15)     NOT NULL,
Minit   CHAR,
Lname   VARCHAR(45),
Ssn     CHAR(9)         NOT NULL,
Bdate   DATE,
Adresss VARCHAR(45),
Sex     CHAR,
Salary  DECIMAL(10,2),
Super_ssn CHAR(9),
Dno       INT           NOT NULL,
PRIMARY KEY (Ssn),
FOREIGN KEY(Super_ssn) REFERENCES test.EMPLOYEE(Ssn) 
);
INSERT INTO test.EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Adresss, Sex, Salary, Super_ssn, Dno) 
VALUES ('Cecilia', 'F', 'Kolonsky', '677678980', '1960-04-05', '6357 Windy Lane, Katy, TX', 'F', 28000, NULL , 4),
       ('John', 'B', 'Smith', '999887778', '1970-05-05', '6417 Windswept Lane, Katy, TX', 'M', 40000, NULL , 4);

SELECT * FROM test.EMPLOYEE;

DELETE FROM test.EMPLOYEE WHERE Ssn="677678989";
SELECT Fname,Ssn FROM test.EMPLOYEE;

UPDATE test.EMPLOYEE SET Ssn="677678989" WHERE Ssn="999887778";
SELECT * FROM test.EMPLOYEE;

INSERT INTO test.EMPLOYEE
VALUES ('Cecilia', 'F', 'Kolonsky', '677678980', '1960-04-05', '6357 Windy Lane, Katy, TX', 'F', 28000, NULL , 4),
       ('Franklin','T','Wong','333445555', '1955-12-08','638 Voss, Houstan, TX','M',40000,'677678989',5);
       
       
SELECT * FROM test.EMPLOYEE;
UPDATE test.EMPLOYEE SET Super_ssn="677678989" WHERE Ssn='677678980';
SELECT Fname,Lname FROM test.EMPLOYEE WHERE Bdate LIKE '195%';
SELECT * FROM test.EMPLOYEE WHERE (Salary BETWEEN 30000 AND 40000) AND Dno = 5;

SELECT * FROM EMPLOYEE E ORDER BY E.Lname;
SELECT Fname,Lname FROM test.EMPLOYEE WHERE Super_ssn IS NULL;

SELECT Fname, Lname 
FROM test.EMPLOYEE E
WHERE EXISTS (
    SELECT 1test.employee
    FROM test.EMPLOYEE
    WHERE Ssn= E.Ssn 
    AND 
    Super_ssn IS NULL   
);
SELECT * FROM EMPLOYEE E ORDER BY E.Fname;