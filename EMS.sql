--Create database called EMS
create DATABASE EMS

go

--Create Department table
create table Department (
    ID int identity primary key,
    Name char(30) not null,
    Location char(30) not null
);

go

--Create Employee table
create table Employee (
    ID int identity(1000, 1) primary key,
    FirstName char(20) not null,
    LastName char(20) not null,
    SSN int not null,
    DeptID int not null,
    Constraint FK_Dept_ID foreign key (DeptID) references Department(ID),
    foreign key (DeptID) references Department(ID)
);

go

--Create EmpDetails table
create table EmpDetails (
    ID int identity primary key,
    EmployeeID int not null,
    Salary decimal not null,
    Address1 char(30) not null,
    Address2 char(30),
    City char(20) not null,
    State char(20) not null,
    Country char(20) not null,
    Constraint FK_Employee_ID foreign key (EmployeeID) references Employee(ID),
    foreign key (EmployeeID) references Employee(ID)
);

go

/*Add 3 values into each table*/
insert into[Department](Name, Location)
    values ('Research and Development', 'Arlington'),
           ('Production', 'Houston'),
           ('Purchasing', 'Dallas');


insert into[Employee](FirstName, LastName, SSN, DeptID)
    values ('Daniel', 'Coombs', 123456789, 1),
           ('Jennifer', 'Smith', 111222333, 2),
           ('Mark', 'Livingston', 121212121, 3);
 

insert into[EmpDetails](EmployeeID, Salary, Address1, Address2, City, State, Country)
    values(1000, 45000.00, '123 Main St', NULL, 'Arlington', 'Texas', 'USA'),
          (1001, 53000.00, '456 Center Ln', 'Apt 17', 'Houston', 'Texas', 'USA'),
          (1002, 50000.00, '789 Harvard Cir', NULL, 'Dallas', 'Texas', 'USA');

go

--insert new type of Department called Marketing
insert into[Department](Name, Location)
    values ('Marketing', 'Austin');

go 

--insert new employee of Employee called Tina Smith
insert into[Employee](FirstName, LastName, SSN, DeptID)
    values ('Tina', 'Smith', 112211221, 4);

--insert details for Tinal Smith in EmpDetails
insert into[EmpDetails](EmployeeID, Salary, Address1, Address2, City, State, Country)
    values(1003, 75000.00, '120 North Lantern Blvd', NULL, 'Austin', 'Texas', 'USA');

go 

--list all employees in Marketing

select * from Department where ID = 4;

go

--report total salary of employees from Marketing

select sum(Salary) from EmpDetails ed FULL OUTER JOIN Employee e 
on ed.EmployeeID = e.ID where e.DeptID = 4;

go 

--report total employees by Department
--would need to loop? I need to practice more on this, including while conditions

declare @counter int = 1;

while (@counter< 5)
BEGIN
    select count(ID) from Employee where DeptID = @counter;
    set @counter = @counter + 1;
END

go 

--Increase salary of Tina Smith to 90000.00

UPDATE EmpDetails
set Salary = 90000.00
where ID = 4;