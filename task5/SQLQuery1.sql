use ITI
---1.	 Create a scalar function that takes date and returns Month name of that date.
create function getMonthName(@val date)
returns varchar(30)
   begin 
    declare @MonthName varchar(30)
   set  @MonthName=DATENAME(month,@val)
   return @MonthName
   end;

 select dbo.getMonthName('2025-09-29') AS MonthName;

--- 2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
create function getrange (@val1 int ,@val2 int )
returns @t table(
value int 
)as
begin
    declare @i int = @val1+1;

    while @i < @val2
    begin
        insert into @t (value)
        values (@i);

        SET @i = @i + 1;
    end;
	return 
	end;
	

DROP FUNCTION getrange;
select * from dbo.getrange(10,20);

--3.	 Create inline function that takes Student No and returns Department Name with Student full name.
create function getDeptName(@st_id int)
returns  table
as return(
select s.St_Fname + ' ' + s.St_Lname AS FullName,
        d.Dept_Name AS DepartmentName
		from student s join Department d
		on s.Dept_Id=d.Dept_Id
		where s.St_Id=@st_id
);

select * from dbo.getDeptName(20)

--4.	Create a scalar function that takes Student ID and returns a message to user 
--a.	If first name and Last name are null then display 'First name & last name are null'
--b.	If First name is null then display 'first name is null'
--c.	If Last name is null then display 'last name is null'
--d.	Else display 'First name & last name are not null'
create function getmessage(@st_id int)
returns varchar(100)
as
begin 
 declare @msg varchar(100);
 select @msg=
case
   when St_Fname is null and St_Lname is null
    then 'First name & last name are null'
	when St_Fname is null
	then 'first name is null'
	when St_lname is null
	then 'last name is null'
	else
	 'First name & last name are not null'
	 end
	from Student
	where Student.St_Id=@st_id
	return @msg
end

select dbo.getmessage(10)

---5.	Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date 
join **
create function managerinfo(@mid int)
returns table as return (
select Department.Dept_Name,Department.Dept_Manager,Department.Manager_hiredate
from Department,Instructor
where Instructor.Dept_Id=Department.Dept_Id and Instructor.Ins_Id=@mid
and Department.Dept_Manager=Instructor.Ins_Id
)
drop function managerinfo
select * from dbo.managerinfo(20)

---6.	Create multi-statements table-valued function that takes a string
--If string='first name' returns student first name
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
--Note: Use “ISNULL” function
create function getStudentInfo (@choice varchar(50))
returns @Result table
(
    StudentId int,
    Value varchar(200)
)
as
begin
    if @choice = 'first name'
    begin
        insert into @Result (StudentId, Value)
        select St_Id, ISNULL(St_Fname, 'N/A')
        from Student;
    end

    else if @choice = 'last name'
    begin
        insert into @Result (StudentId, Value)
        select St_Id, ISNULL(St_Lname, 'N/A')
        from Student;
    end

    else if @choice = 'full name'
    begin
        insert into @Result (StudentId, Value)
        select St_Id, 
               ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '')
        from Student;
    end

    return;
end;
--7.	Write a query that returns the Student No and Student first name without the last char
select 
Student.St_Id as studentno,
left(Student.St_Fname,len(Student.St_Fname)-1)as fristNamewithoutlastchar
from Student

--8.	Wirte query to delete all grades for the students Located in SD Department 

update Stud_Course
set grade = null
from Stud_Course inner join Student
on Student.St_Id=Stud_Course.St_Id
inner join
Department on Student.Dept_Id=Department.Dept_Id 
where Department.Dept_Name='SD'

--9.	Using Merge statement between the following two tables [User ID, Transaction Amount]
 
 create table dailytransaction (
 userid int primary key,
 Amount int 

 );

 insert into dailytransaction values(1,500)
  insert into dailytransaction values(2,900)
  insert into dailytransaction values(3,100)
    insert into dailytransaction values(4,100)

   create table lasttransaction (
 userid int primary key,
 Amount int 

 );
 insert into lasttransaction values(1,10)
  insert into lasttransaction values(4,20)
  insert into lasttransaction values(2,30)


  merge lasttransaction as target
  using dailytransaction as source
  on target.userid= source.userid
  when matched then 
  update set target.Amount=source.Amount

  when not matched by target then
  insert(userid,Amount)
  values(source.userid,source.Amount)

  when not matched by source then 
  delete;

  select * from dbo.lasttransaction

  --------------------------
  create schema acess

  alter schema acess transfer dbo.Student
  alter schema acess transfer  dbo.Course

