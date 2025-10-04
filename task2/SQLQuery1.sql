---1.	Display the Department id, name and id and the name of its manager.

select Dnum,Dname,SSN,Fname+' '+Lname as EmployeeName
from Departments,Employee
where Departments.MGRSSN=Employee.SSN

----2.	Display the name of the departments and the name of the projects under its control.
select Dname ,Pname
from Departments,Project
where Departments.Dnum=Project.Dnum
---3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select Fname+' '+Lname as EmployeeName ,y.*
from Employee,Dependent y
where Employee.SSN=y.ESSN

---4.	Display the Id, name and location of the projects in Cairo or Alex city.

select Pnumber,Pname,Plocation
from Project
where City in ('Alex','Cairo')

---5.	Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project
where Pname like 'a%'

---6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select SSN,Fname+' '+Lname as EmployeeName,Salary,Sex,Bdate,Address
from Employee 
where Dno=30 and  Salary between 1000 and 2000

---7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
 
 select Fname+' '+Lname as EmployeeName 
 from Employee,Works_for,Project
 where   Employee.SSN=Works_for.ESSn
 and Project.Pnumber=Works_for.Pno
 and Employee.Dno=10 and Project.Pname='AL Rabwah' and  Works_for.Hours >= 10;

---8.	Find the names of the employees who directly supervised with Kamel Mohamed. ****

SELECT e.Fname + ' ' + e.Lname AS EmployeeName
FROM Employee e
JOIN Employee s ON e.Superssn = s.SSN
WHERE s.Fname = 'Kamel' AND s.Lname = 'Mohamed';


---9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.

select Fname+' '+Lname as employeeName,Pname
from Employee join Works_for
on Employee.SSN=Works_for.ESSn
join Project
on Project.Pnumber=Works_for.Pno
ORDER BY Pname;

---10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.

select Pnumber ,Dname, Lname ,Address ,Bdate
from Project , Departments , Employee
where Project.City='Cairo' and Project.Dnum=Departments.Dnum
and Employee.SSN=Departments.MGRSSN

---11.	Display All Data of the managers
select x.*
from Employee x , Departments y
where x.SSN= y.MGRSSN

---12.	Display All Employees data and the data of their dependents even if they have no dependents
select x.* , y.*
from Employee  X left join  Dependent y
on x.SSN = y.ESSN

---13.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.

insert into Employee (Dno,SSN,Superssn,Salary)
values(30,102672,112233,3000)

---14.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
insert into Employee (Dno,SSN)
values(30,102660)

---15.	Upgrade your salary by 20 % of its last value. 

update Employee 
set Salary=Salary*1.2
where SSN = 102660