--1.	 Create a view that displays student full name, course name if the student has a grade more than 50. 
ALTER SCHEMA dbo TRANSFER acess.Student;
ALTER SCHEMA dbo TRANSFER acess.Course;

create view studentpass
as 
select dbo.Student.St_Fname+' '+Student.St_Lname as Fullname,Course.Crs_Name
from Student inner join Stud_Course
on Student.St_id=Stud_Course.St_Id 
inner join Course on Course.Crs_Id=Stud_Course.Crs_Id
WHERE Stud_Course.Grade > 50;

---2.	 Create an Encrypted view that displays manager names and the topics they teach. 

create view topictrachbymanager
WITH ENCRYPTION
as 
select Instructor.Ins_Name,Topic.Top_Name
from Instructor inner join Department
on Instructor.Ins_Id=Department.Dept_Manager
join Ins_Course on Instructor.Ins_Id=Ins_Course.Ins_Id
join Course on Course.Crs_Id=Ins_Course.Crs_Id
join Topic on Course.Top_Id=Topic.Top_Id

--3.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 

create view InstructorinSDorJave
as 
select Instructor.Ins_Name,Department.Dept_Name
from Instructor,Department
where Instructor.Dept_Id=Department.Dept_Id and  Department.Dept_Name IN ('SD', 'Java')
with check option 

--4.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;

create view v1 
as
select * 
from Student 
where Student.St_Address='Cairo' or Student.St_Address='Alex'
with check option 

--5.	Create a view that will display the project name and the number of employees work on it. “Use Company DB”
use Company_SD
create view NumberOfEmployee
AS
select 
    Project.Pname,
    COUNT(Works_for.ESSn) AS NumOfEmployees
from Project
inner join Works_for
    on Project.Pnumber = Works_for.Pno
group by Project.Pname;

--6.	Create the following schema and transfer the following tables to it 
----a.	Company Schema 
------i.	Department table (Programmatically)
------ii.	Project table (by wizard)
----b.	Human Resource Schema
------i.	  Employee table (Programmatically)

create schema Company 
ALTER SCHEMA Company TRANSFER dbo.Departments;

create schema HumanResource

ALTER SCHEMA Company TRANSFER dbo.Employee;

--7.	Create index on column (manager_Hiredate) that allow u to cluster the data in table Department. What will happen?  - Use ITI DB
use ITI

create  clustered index IX_Department_ManagerHireDate
ON Department(Manager_hiredate);

--8.	Create index that allow u to enter unique ages in student table. What will happen?  - Use ITI DB

create unique index IX_uniqueage
on Student(St_Age)

---9.	Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB

use Company_SD

declare c1 cursor
for select salary from Company.Employee
for update --Modify
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal<3000
			update Company.Employee
				set Salary=@sal*1.10
			where current of c1
		else if @sal>=3000
			update Company.Employee
				set Salary=@sal*1.20
			where current of c1
		else
			delete from Company.Employee
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1


--10.	Display Department name with its manager name using cursor. Use ITI DB

USE ITI;

declare c1 cursor
for 
    select D.Dept_Name, i.Ins_Name
    from Department D
    INNER JOIN Instructor i
        on D.Dept_Manager = i.Ins_Id;

declare @Dname varchar(50), @ManagerName varchar(50);

open c1;

fetch next from c1 into @Dname, @ManagerName;

while @@FETCH_STATUS = 0
begin
    print 'Department: ' + @Dname + ' | Manager: ' + @ManagerName;

    fetch next from c1 into @Dname, @ManagerName;
end;

close c1;
deallocate c1;

--11.	Try to display all instructor names in one cell separated by comma. Using Cursor . Use ITI DB

declare c1 cursor
for select  Ins_Name from Instructor where Ins_Name is not null
for read only
declare @name varchar(20),@all_names varchar(300)=''
open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		set @all_names=concat(@all_names,',',@name)
		fetch c1 into @name
	end
select @all_names
close c1
deallocate c1

---12.	Try to generate script from DB ITI that describes all tables and views in this DB

USE ITI;

select table_schema, table_name, table_type
from INFORMATION_SCHEMA.TABLES 
ORDER BY  table_type,  table_name;

SELECT table_schema, table_name
FROM INFORMATION_SCHEMA.VIEWS
ORDER BY table_name;

