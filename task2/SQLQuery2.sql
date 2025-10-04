create table instractor(
ID  int primary key,
salary int  check (salary between 1000 and 5000) default 3000,
overtime int unique ,
BD varchar(20),
Fname varchar(50),
Lname varchar(50),
hiredate Date DEFAULT GETDATE(),
Address varchar(50) check (Address in ('Cairo','Alex')),
NetSalary AS (Salary + Overtime), 
 Age AS (YEAR(GETDATE()) - YEAR(BD))
);
create table Course (
CID int primary key,
Cname varchar(50),
Duration int unique 
);
create table Teach(
inst_id int ,
CID INT ,
primary key (inst_id,CID),
 FOREIGN KEY (inst_id) REFERENCES instractor(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (CID) REFERENCES Course(CID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE Lab (
    Lab INT,
    Location VARCHAR(50),
    Capacity INT check (Capacity<20),
    CID INT,
    PRIMARY KEY (Lab, CID),           
    FOREIGN KEY (CID) REFERENCES Course(CID)
	 ON DELETE CASCADE
     ON UPDATE CASCADE,
);

