CREATE DATABASE EmployeeDB;
USE EmployeeDB;
CREATE TABLE DEPT (DEPTNO INT PRIMARY KEY,DNAME VARCHAR(30),DLOC VARCHAR(30));
CREATE TABLE EMPLOYEE (EMPNO INT PRIMARY KEY,ENAME VARCHAR(30),MGR_NO INT,
HIREDATE DATE,SAL DECIMAL(10,2),DEPTNO INT,FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO));
CREATE TABLE PROJECT (PNO INT PRIMARY KEY,
PLOC VARCHAR(30),PNAME VARCHAR(40));
CREATE TABLE ASSIGNED_TO (EMPNO INT,PNO INT,JOB_ROLE VARCHAR(30),
PRIMARY KEY (EMPNO, PNO),FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO),
FOREIGN KEY (PNO) REFERENCES PROJECT(PNO));
CREATE TABLE INCENTIVES (EMPNO INT,INCENTIVE_DATE DATE,
INCENTIVE_AMOUNT DECIMAL(10,2),FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE(EMPNO));
INSERT INTO DEPT VALUES
(10, 'HR', 'Bengaluru'),
(20, 'Finance', 'Hyderabad'),
(30, 'IT', 'Mysuru'),
(40, 'Admin', 'Chennai'),
(50, 'Marketing', 'Delhi'),
(60, 'Support', 'Pune');

INSERT INTO EMPLOYEE VALUES

(101, 'Pragathi', NULL, '2022-06-10', 45000, 10),
(102, 'Kiran', 101, '2021-07-12', 50000, 20),
(103, 'Ravi', 101, '2023-01-20', 48000, 30),
(104, 'Sneha', 102, '2022-03-15', 47000, 40),
(105, 'Anjali', 102, '2021-12-10', 52000, 50),
(106, 'Rohit', 103, '2022-09-22', 46000, 10),
(107, 'Tejas', 104, '2023-04-18', 44000, 60);

INSERT INTO PROJECT VALUES
(201, 'Bengaluru', 'Payroll System'),
(202, 'Hyderabad', 'ERP Upgrade'),
(203, 'Mysuru', 'AI Tool'),
(204, 'Delhi', 'Marketing Automation'),
(205, 'Chennai', 'Database Migration'),
(206, 'Pune', 'Support Portal');

INSERT INTO ASSIGNED_TO VALUES
(101, 201, 'Manager'),
(102, 202, 'Analyst'),
(103, 203, 'Developer'),
(104, 205, 'HR Executive'),
(105, 204, 'Lead'),
(106, 201, 'Support'),
(107, 206, 'Technician'),
(103, 202, 'Consultant');

INSERT INTO INCENTIVES VALUES
(101, '2024-12-01', 5000),
(102, '2024-11-15', 3000),
(105, '2024-10-20', 2500),
(107, '2024-09-12', 4000),
(101, '2025-01-10', 2000),
(102, '2025-02-14', 2500);
SELECT e.ename as manager_name from employee e where e.empno in (select mgr_no 
from employee where mgr_no is not null GROUP BY mgr_no having count(*)>=all
(select count(*) from employee where mgr_no is not null group by mgr_no));
select m.ename as manager_name from employee m where m.empno in (select e.mgr_no from employee e where
e.mgr_no is not null) and m.sal >(select avg(e2.sal) from employee e2 where  e2.mgr_no = m.empno);
select d.dname,e.ename as second_top_manager from employee e join dept d on e.deptno=d.deptno
where e.mgr_no is not null and e.mgr_no in (select empno from employee where mgr_no is null);
select e.empno,e.ename,e.sal,i.incentive_amount,i.incentive_date from employee e join incentives i on e.empno=i.empno
where i.incentive_date between '2019-01-01' and '2019-01-31' and i.incentive_amount=(select max(incentive_amount) from incentives where incentive_date between '2019-01-01'and '2019-01-31' ); 
select e.empno,e.ename,e.deptno,d.dloc,m.empno as manager_name from employee e join employee m on e.mgr_no=m.empno join dept d on e.deptno=d.deptno where e.deptno=m.deptno;