---1.	Display (Using Union Function)
      ---a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
      ---b.	 And the male dependence that depends on Male Employee.

	  select  Dependent_name,Dependent.Bdate
	  from Dependent,Employee
	  WHERE SSN= ESSN and Employee.Sex ='F' and Dependent.Sex='F'

	  union 

	   select  Dependent_name,Dependent.Bdate
	  from Dependent,Employee
	  WHERE SSN= ESSN and Employee.Sex ='M' and Dependent.Sex='M';



---2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.

   select Pname,Sum(Hours)
   from Project , Works_for,Employee
   where Employee.SSN=Works_for.ESSn and
   Project.Pnumber=Works_for.Pno
   group by Pname
      
---3.	Display the data of the department which has the smallest employee ID over all employees' ID.

    select y.Dnum ,y.Dname
	from Employee inner join  Departments y
	on Employee.Dno=y.Dnum
	 where SSN in (select min (ssn) from Employee)

---4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

select d.Dname,max(e.salary) as maximum ,min(e.salary) AS minmum ,AVG(Salary) as avarage
from Departments d , Employee e
where d.Dnum=e.Dno
Group by  d.Dname


---5.	List the full name of all managers who have no dependents.****
  
  select Fname+' '+ Lname as FullName 
  from Employee
  where  not in ( select ESSN from Dependent,Employee where ESSN=SSN  ) 

--6.	For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.

select  Dnum, Dname ,count (SSN) AS Employees
from Employee,Departments
where Employee.Dno=Departments.Dnum 
group by  Dnum, Dname
having AVG(salary)<(select AVG(salary)
from Employee )

---7.	Retrieve a list of employee’s names and the projects names they are working on ordered by department number and within each department, ordered alphabetically by last name, first name.
 
 select Fname+' '+Lname as fullname ,Pname
 from Employee ,Project ,Works_for
 where SSN=Works_for.ESSn AND 
 Project.Pnumber= Works_for.Pno
 order by Project.Dnum ,Lname,Fname


----8.	Try to get the max 2 salaries using sub query i

select max(salary)
from Employee 
union 
select max(salary)
from Employee
where salary<(select max(salary) from Employee)

---9.	Get the full name of employees that is similar to any dependent name
select Fname+' '+Lname as Fullname
from Employee,Dependent
where Fname+' '+Lname like Dependent_name


---10.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.

select  Fname+' '+Lname as Fullname
from Employee
where exists( 
select 1
from Dependent
where ESSN= SSN
)


---11.	In the department table insert new department called "DEPT IT”, with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'

insert into Departments (Dname,Dnum,MGRSSN,[MGRStart Date])values ('DEPT IT',100,112233,'1-11-2006')

---12.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

   ---a.	First try to update her record in the department table
   update  Departments 
   set MGRSSN=968574
   where Dnum=100
   ---b.	Update your record to be department 20 manager.
    update  Departments 
   set MGRSSN=102672
   where Dnum=20
   ---c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
      update  Employee 
   set Superssn=102672
   where SSN=102660

---13.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
---Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).
delete from Dependent
where ESSN=223344

update Departments
set MGRSSN=968574
where MGRSSN=223344

update Employee
set Superssn=968574
where Superssn=223344

delete Works_for
where ESSn=223344

delete from Employee
where SSN=223344


---14.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%

update Employee
set Salary+=Salary*1.3
from Employee,Works_for,Project
where  Employee.SSN=Works_for.ESSn
and Project.Pnumber=Works_for.Pno
AND Project.Pname='Al Rabwah'








	
