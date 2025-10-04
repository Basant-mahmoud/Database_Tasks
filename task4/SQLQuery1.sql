use ITI
--1.	Retrieve number of students who have a value in their age. 

select count(*) as totalNumberOfStudent
from student
where St_Age is not null ;

---2.	Get all instructors Names without repetition

select distinct Ins_Name
from  instructor


--3.	Display student with the following Format (use isNull function)

select St_id as StudentID ,isNull(St_Fname+' '+St_Lname,'unknown') as FullName ,isNull(Department.Dept_Name,'unknown') as DepatmentName
from Student ,Department
where Student.Dept_Id=Department.Dept_Id


--4.	Display instructor Name and Department Name 

select Ins_Name ,Dept_Name
from Instructor left join  Department
on Instructor.Dept_Id=Department.Dept_Id

---5.	Display student full name and the name of the course he is taking
--For only courses which have a grade  

select St_Fname+' '+St_Lname as FullName , Course.Crs_Name
from  Student,Course,Stud_Course
where Stud_Course.St_Id=Student.St_Id and Stud_Course.Crs_Id=Course.Crs_Id and Stud_Course.Grade is not null

--6.	Display number of courses for each topic name 
 select COUNT(Course.Crs_Id)
 from Course,Topic
 where Course.Top_Id=Topic.Top_Id
 GROUP BY Topic.Top_Id

 --7.	Display max and min salary for instructors

 select max(salary) as maxSalary , min(salary) as minsalary
 from Instructor

 --8.	Display instructors who have salaries less than the average salary of all instructors.

 select Instructor.Ins_Name
 from Instructor
 where Instructor.Salary<(select AVG(salary) from Instructor)

 --9.	Display the Department name that contains the instructor who receives the minimum salary.

select Department.Dept_Name
from Instructor join Department
on Instructor.Dept_Id=Department.Dept_Id
where Instructor.Salary=(select min(salary) from Instructor)

---10.	 Select max two salaries in instructor table. 

select top(2) salary
from Instructor 
order by salary desc

---11 Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function”

select Instructor.Ins_Name  , coalesce(CAST(Salary AS VARCHAR), 'Bonus') as SalaryOrBonus
from Instructor

--12.	Select Average Salary for instructors 

select AVG(salary)
from Instructor

--13.	Select Student first name and the data of his supervisor 

select s.St_Fname ,y.*
from Student s, Student y
where y.St_super=s.St_Id

--14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”

SELECT 
    I.Ins_Name,
    I.Salary,
    D.Dept_Name
FROM (
    SELECT 
        Ins_Id,
        Ins_Name,
        Salary,
        Dept_Id,
        ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY Salary DESC) AS RowNum
    FROM Instructor
    WHERE Salary IS NOT NULL
) I
JOIN Department D ON I.Dept_Id = D.Dept_Id
WHERE I.RowNum <= 2;
--15.	 Write a query to select a random student from each department.  “using one of Ranking Functions”

SELECT St_Id, St_Fname, Dept_Name
FROM (
    SELECT 
        S.St_Id,
        S.St_Fname,
        S.Dept_Id,
        ROW_NUMBER() OVER (PARTITION BY S.Dept_Id ORDER BY NEWID()) AS RowNum
    FROM Student S
    JOIN Department D ON S.Dept_Id = D.Dept_Id
) AS X
JOIN Department D ON X.Dept_Id = D.Dept_Id
WHERE X.RowNum = 1;
-------------