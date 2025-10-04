---1.	Create a stored procedure without parameters to show the number of students per department name.[use ITI DB] 
use ITI
create proc getstudensnumber 
as
select count(Student.St_Id) as numberofStudent ,Department.Dept_Name
from Student join Department
on Student.Dept_Id=Department.Dept_Id
group by Department.Dept_Name

getstudensnumber

---2.	Create a stored procedure that will check for the # of employees in the project p1 if they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'” if they are less display a message to the user “'The following employees work for the project p1'” in addition to the first name and last name of each one. [Company DB] 
use Company_SD

create proc employeeproject
as
declare @count int 
select  @count=count(Company.Employee.SSN)
from Company.Employee join Works_for
on Employee.SSN=Works_for.ESSn
join Company.Project ON Works_for.Pno=Project.Pnumber and Project.Pnumber=100
if  @count>3
  select'The number of employees in the project p1 is 3 or more'
else
begin
  select 'The employees work for the project p1'
  select  Company.Employee.Fname+' '+Company.Employee.Lname
from Company.Employee join Works_for
on Employee.SSN=Works_for.ESSn
join Company.Project ON Works_for.Pno=Project.Pnumber and Project.Pnumber=100
end

employeeproject


-------3.	Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) and it will be used to update works_on table. [Company DB]

create proc leftEmployee
@oldEmp int,
@newEmp int,
@projectnumber int 
as 
update Works_for
set Works_for.ESSN=@newEmp 
where Works_for.ESSN=@oldEmp and  Works_for.Pno=@projectnumber
if @@ROWCOUNT>0
select 'employee update suceessfly'
else
select 'employee not updated'

leftEmployee 10,20,200

---4.	add column budget in project table and insert any draft values in it then 
---then Create an Audit table with the following structure 

create table Audit (
pronum int ,
username varchar(50),
ModifyDate date default getdate(),
Budget_Old int ,
Budget_New  int 
);

alter table Company.project
add budget  int 

create trigger t1 
on Company.project
after update 
as
if  update(budget)
insert into Audit (ProNum, UserName, ModifyDate, Budget_Old, Budget_New)
select d.Pnumber,SUSER_SNAME(),GETDATE(),d.budget,i.budget
from deleted d join inserted i 
ON d.Pnumber = i.Pnumber;

---5.	Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
use ITI
create trigger t2
on Department
instead of insert
as
select 'Print a message for user to tell him that he can’t insert a new record in that table' 

---6.	 Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
use Company_SD

create trigger t3
on Company.Employee
instead of insert 
as
if FORMAT(getdate(),'MMMM')='March'
select 'not allowed'
else
insert into Company.Employee
select * from inserted

--7.	Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note) where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”

use ITI
create table AuditStusent (

servername varchar(50),
inserteddate date default getdate(),
note varchar(50)
);

create trigger t4
on Student
after insert 
as
insert into AuditStusent (Servername, Inserteddate, Note)
select  @@SERVERNAME,getdate(), SUSER_SNAME() + ' Insert New Row with Key=' 
        + CAST(i.St_Id as varchar(10)) 
        + ' in table Student'
from inserted i


--8.	 Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note) where note will be“ try to delete Row with Key=[Key Value]”

create trigger t5
on Student
instead of  delete 
as
insert into AuditStusent (Servername, Inserteddate, Note)
select  @@SERVERNAME,getdate(), SUSER_SNAME() + ' try to delete Row with Key' 
        + CAST(i.St_Id as varchar(10)) 
        + ' in table Student'
from deleted i

--------------------------------------------------




