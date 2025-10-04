/////////////////q1////////////////////////

select * from Employee


///////////////////q2///////////////////////

select Fname,Lname,Salary,Dno
from Employee

////////////////////q3///////////////////////////

select Pname,Plocation,Dnum
from Project

////////////////////q4/////////////////////

select Fname + ' '+Lname , (Salary * 12 * 0.10)  as ANNUALCOMM 
from Employee 

///////////////////q5/////////////////////////

select SSN as Id , Fname+' '+Lname as name 
from Employee 
where Salary>1000

/////////////////q6//////////////////////////
select SSN as Id , Fname+' '+Lname as name 
from Employee 
where (Salary*12)>1000

///////////////q7//////////////////////////////

select Fname+' '+Lname as name ,Salary
from Employee
where Sex= 'Female';

/////////////////q8/////////////////////////////

select Dnum,Dname
from Departments
where MGRSSN=968574

//////////////q9/////////////////////////

select Pnumber,Pname,Plocation
from Project
where Dnum=10

