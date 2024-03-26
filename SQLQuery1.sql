--loome db ps aktiveeri f5ga
create database TARge23SQL

--db valimine
use TARge23SQL

--db kustutamine
drop database TARge23SQL

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female'),
(3, 'Unknown')

--vaatame tabeli sisu
select * from Gender

--loome uue tabeli
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)
--andmete sisestamine
insert into Person (Id, Name, Email, GenderId) values
(1, 'Superman', 's@s.com', 1),
(2, 'Wonderwoman', 'w@w.com', 2),
(3, 'Batman', 'b@b.com', 1),
(4, 'Aquaman', 'a@a.com', 1),
(5, 'Catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 1),
(7, NULL, NULL, 3)

--vaadake Person tabeli andmeid
select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderID) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderID-d 
--alla v��rtust, siis see automaatselt sisestab sellele reale v��rtuse 3 e unknown
alter table Person
add constraint DF_persons_GenderId
default 3 for GenderId


--sisestame andmed
insert into Person (Id, Name, Email)
values (10, 'Ironman','i@i.com')

select * from Person

--lisame uue veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--sisestame uue rea andmed
insert into Person (Id, Name, Email, GenderId, Age)
values (11, 'kalevipoeg','k@k.com', 1, 30)

--muudame koodiga andmeid
update Person
set Age = 35
where Id = 9

select * from Person

--sisestame muutuja City nvarchar(150)
alter table Person
add City nvarchar(150)

--sisestame City veeru andmeid
update Person
set City = 'Kaljuvald'
where Id = 11

select * from Person

--k�ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k�ik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
--k�ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'

--n�itab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 19
select * from Person where Age in (120, 50, 19)

--n�itab teatud vanusevahemikus inimesi
--ka 22 ja 31.a
select * from Person where Age between 22 and 31

--wildcard e n�itab k�ik n-t�hega algavad linnad
select * from Person where City like 'n%'
--k�ik emailis kus @-m�rk sees
select * from Person where Email like '%@%'

--n�itab Emaile, kus ei ole @-m�rki sees
select * from Person where not Email like '%@%'

--n�itab, kellel on e-mailis ees ja peale @ m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

update Person
set Email = 'bat@bat.com'
where Id = 3

--k�ik, kellel nimes ei ole esimene t�ht W, A, C
select * from Person where name like '[^WAC]%'
select * from Person

--kes elavad Gothamis ja New Yorgis
select * from Person where ( City = 'Gotham' or City = 'New York')

--kes elavad v�lja toodud linnades ja on vanemad kui 29
select * from Person where ( City = 'Gotham' or City = 'New York')
and Age >= 30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
--kuvab vastupidises j�rjestuses
select * from Person order by Name desc


--v�tab 3 esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis name
select * from Person
select top 3 Age, Name from Person

--n�ita esimesed 50% tabeli sisust
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
select * from Person order by cast(Age as int)

--05.03.2024
--k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

--kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person

--kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

--n�eme konkreetsetes linnades olevate isikut koondvanust
select City, sum(cast(Age as int)) as TotalAge from Person 
group by City

--kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Age int

--kuvab esimeses reas v�lja toodud j�rjestuses ja muudab Age-i TotalAge-ks
--j�rjestab Citys olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

insert into Person values
(13, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust, et mitu inimest on GenderId v��rtusega 2 konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--n�itab �ra inimeste koondvanuse, mis on �le 41 a ja kui palju neid igas linnas elab
--eristab inimese soo �ra
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja department
create table Department
(
Id int not null primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)
create table Employees
(
Id int not null primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

--sisestame andmed
insert into Employees (Id, Name, Gender, Salary, DepartmentId) values
(1, 'Tom', 'Male', '4000', 1),
(2, 'Pam', 'Female', '3000', 3),
(3, 'John', 'Male', '3500', 1),
(4, 'Sam', 'Male', '4500', 2),
(5, 'Todd', 'Male', '2800', 2),
(6, 'Ben', 'Male', '7000', 1),
(7, 'Sara', 'Female', '4800', 3),
(8, 'Valarie', 'Female', '5500', 1),
(9, 'James', 'Male', '6500', NULL),
(10, 'Russell', 'Male', '8800', NULL)

go
insert into Department(Id, DepartmentName, Location, DepartmentHead) values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

--left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k�ikide palgad kokku
select sum(cast(Salary as int)) from Employees
--min palga saaja
select min(cast(Salary as int)) from Employees
--�he kuu palga saaja linnade l�ikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

-- tee mitu korda erinevate nimede ja ID'dega
select * from Employees
update Employees
set City = 'New York'
where Id = 10

--n�itab erinevust palgafondi osas nii linnade kui soo osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender

--sama p�ring nagu eelmine, aga linnad on t�hestikulises j�rjestuses
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
--order teeb t�hestikulises
order by City

--loeb �ra ridade arvu Employees tabelis
select count(*) from Employees


--mitu t��tajat on soo ja linna kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--kuvab ainult k�ik naised linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by Gender, City

--kuvab ainult k�ik mehed linnade kaupa
--ja kasutame having
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Male'

select * from Employees where sum(cast(Salary as int)) < 4000

select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id)
as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

Insert into Test1 values('X')
select * from Test1

alter table Employees
drop column City

--inner join
--kuvab neid, kellel on DepartmentName all olemas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join
--kuidas saada k�ik andmed Employeest k�tte
select Name, Gender, Salary, DepartmentName
from Employees --see vasak ja alumine parem
left join Department --v�ib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--right join
--kuidas saada DepartmentName alla uus nimetus
select Name, Gender, Salary, DepartmentName
from Employees
right join Department --v�ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

select * from Department

--kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--cross join v�tab kaks allpool olevat tabelit kokku
--ja korrutab need omavahel l�bi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--p�ringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

--kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--full join
--m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--kuidas muuta tabeli nime, 
--alguses vana tabeli nimi ja siis uue nimi
sp_rename 'Department1', 'Department'

--kasutame Employees tabeli asemel l�hendit E ja
--Department puhul D
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
left join Department D
on E.DepartmentId = D.Id

--inner join
--kuvab ainult isikuid, 
--kellel on DepartmendID veerus v��rtus
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
inner join Department D
on E.DepartmentId = D.Id

--cross join
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
cross join Department D

--
select isnull('Ingvar', 'No Manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--kui Expression on �ige siis paneb v��rtuse, 
--mida soovid v�i m�ne teise v��rtuse
--case when Expression Then '' else '' end

--
alter table Employees
add ManagerId int

--neil, kellel ei ole �lemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p�ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerude
alter table Employees
add MiddleName nvarchar(30),
LastNname nvarchar(30)

--muudame veeru nime
sp_rename 'Employees.Name', 'FirstName'

select * from Employees

update Employees
set FirstName = NULL --v�i '' sisse nimi etc v�i , middlename =, lastname =
where Id = 10

--igats reast v�tab esimene t�idetud lahtri ja kuvab ainutl seda
select Id, Coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees

--loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, mis n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas sorteerida nime j�rgi
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--n��d saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

---
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kui n��d allolevat k�sklust k�ima panna, siis n�uab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--�ige variant
spGetEmployeesByGenderAndDepartment 'male', 1

--niimoodi saab parameetrite j�rjestusest m��da minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates sp on store procedure
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja v�ti peale panna,
--et keegi teine peale teie ei saaks muuta. Kui tahad �ra v�tta kommenteeri lihtsalt with encryption v�lja
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId Int
--with encryption
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab �ra n�uetele vastavad read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount
go--tee �levalpool p�ring �ra ja siis mine edasi
select * from Employees

--n�itab �ra mitu rida vastab n�uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
print @TotalCount

--sp sisu vaatamine??
sp_help spGetEmployeeCountByGender

--tabeli info??
sp_help Employees
--v�i muu tabel
sp_help Person

--kui soovid n�ha store procedure teksti siis kasutad helptexti
sp_helptext spGetEmployeeCountByGender

--vaatame, millest s�ltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabeli s�ltuvust (n�eb store procedures)
sp_depends Employees

--sp tegemine (kui vaja muuta siis create asemel alter)
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

--n��d selle kasutamine(tulemust ei n�e vaid saab pigem koodis vms kasutada)
execute spGetNameById 1, 'Tom'

--sp annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--n��d saame teada, et mitu rida on andmeid on tabelis
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

---mis id all on keegi nime j�rgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end
--annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(50)
execute spGetNameById1 1, @Firstname output
print 'Name of the employee = ' + @FirstName

--
declare
@FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

sp_help spGetNameById

--
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

--kutsuda l�bi declarei abi v�lja sp nimega spGetNameById2
--ja �elda miks see ei t��ta
declare @EmployeeName nvarchar(20)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

--sisseehitatud string funktsioonid

--See konventeerib ASCII t�he v��rtuse numbriks
select ASCII('a')
--kuvab A-t�hte
select char(65)


--prindime v�lja kogu t�hestiku (Kui al 65 siis suured ka)
declare @Start int
set @Start = 97
while(@Start <= 122)
begin
	select CHAR (@Start)
	set @Start = @Start + 1
end

--eemaldame t�hjad kohad sulgudes
select LTRIM('                    Hello')

--t�hikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

---paremalt poolt t�hjad stringid l�ikab �ra
select RTRIM('     Hello   ')
select RTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

---keerab kooloni sees olevad andmed vastupidiseks
---vastavat upper ja lower-ga saan muuta m�rkide suurust
--reverse funktsioon p��rab k�ik �mber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, LOWER(LastName),
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

---n�eb, mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
---n�eb, mitu t�hte on s'nal ja ei ole t�hikuid (ps firstname ette v�i ka trim
select FirstName, len(trim(FirstName)) as [Total Characters] from Employees

---left, right, substring
---vasakult poolt neli esimest t�hte siis paremalt
select left('ABCDEF', 4)
select right('ABCDEF', 4)

--kuvab @-t�hem�rgi asetust
select CHARINDEX ('@', 'sara@aaa.com')

---esimene nr peale komakohta n�itab, et 
--mitmendast alustab ja siis mitu nr kaasaarvatult kuvab
select SUBSTRING('pam@bbb.com', 5, 2)


---@-m�rgist kuvab kolm t�hem�rki. Viimase nr saab m��rata pikkust(11-4 on 7)
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))


---saame domeeninimed emailides
select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Employees

--lisame emaili
alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set email = 'ben@gmail.com' where Id = 6

select * from Employees

--lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + ---peale teist t�hem�rki paneb viis t�rni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email) + 1) as Email
from Employees

--kolm korda n�itab midagi
select REPLICATE('asd', 3)

---kuidas sisestada t�hikut kahe nime vahele
select SPACE(5)

---t�hikute arv kahe nime vahel
select FirstName + SPACE(25) + LastName as FullName
from Employees

---PATINDEX
---sama, mis CHARINDEX, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@hotmail.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@hotmail.com', Email) > 0

---k�ik  .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimes m�rki kolm t�hte viie t�rniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees