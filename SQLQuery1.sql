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

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderID) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderID-d 
--alla väärtust, siis see automaatselt sisestab sellele reale väärtuse 3 e unknown
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

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
--kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'

--näitab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 19
select * from Person where Age in (120, 50, 19)

--näitab teatud vanusevahemikus inimesi
--ka 22 ja 31.a
select * from Person where Age between 22 and 31

--wildcard e näitab kõik n-tähega algavad linnad
select * from Person where City like 'n%'
--kõik emailis kus @-märk sees
select * from Person where Email like '%@%'

--näitab Emaile, kus ei ole @-märki sees
select * from Person where not Email like '%@%'

--näitab, kellel on e-mailis ees ja peale @ märki ainult üks täht
select * from Person where Email like '_@_.com'

update Person
set Email = 'bat@bat.com'
where Id = 3

--kõik, kellel nimes ei ole esimene täht W, A, C
select * from Person where name like '[^WAC]%'
select * from Person

--kes elavad Gothamis ja New Yorgis
select * from Person where ( City = 'Gotham' or City = 'New York')

--kes elavad välja toodud linnades ja on vanemad kui 29
select * from Person where ( City = 'Gotham' or City = 'New York')
and Age >= 30

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
--kuvab vastupidises järjestuses
select * from Person order by Name desc


--võtab 3 esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on Age ja siis name
select * from Person
select top 3 Age, Name from Person

--näita esimesed 50% tabeli sisust
select top 50 percent * from Person

--järjestab vanuse järgi isikud
select * from Person order by cast(Age as int)

--05.03.2024
--kõikide isikute koondvanus
select sum(cast(Age as int)) from Person

--kuvab kõige nooremat isikut
select min(cast(Age as int)) from Person

--kuvab kõige vanemat isikut
select max(cast(Age as int)) from Person

--näeme konkreetsetes linnades olevate isikut koondvanust
select City, sum(cast(Age as int)) as TotalAge from Person 
group by City

--kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column Age int

--kuvab esimeses reas välja toodud järjestuses ja muudab Age-i TotalAge-ks
--järjestab Citys olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

insert into Person values
(13, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--näitab ridade arvu tabelis
select count(*) from Person
select * from Person

--näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja kui palju neid igas linnas elab
--eristab inimese soo ära
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

--arvutab kõikide palgad kokku
select sum(cast(Salary as int)) from Employees
--min palga saaja
select min(cast(Salary as int)) from Employees
--ühe kuu palga saaja linnade lõikes
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

--näitab erinevust palgafondi osas nii linnade kui soo osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender

--sama päring nagu eelmine, aga linnad on tähestikulises järjestuses
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
--order teeb tähestikulises
order by City

--loeb ära ridade arvu Employees tabelis
select count(*) from Employees


--mitu töötajat on soo ja linna kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--kuvab ainult kõik naised linnade kaupa
select Gender, City,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by Gender, City

--kuvab ainult kõik mehed linnade kaupa
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
--kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join
--kuidas saada kõik andmed Employeest kätte
select Name, Gender, Salary, DepartmentName
from Employees --see vasak ja alumine parem
left join Department --võib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--right join
--kuidas saada DepartmentName alla uus nimetus
select Name, Gender, Salary, DepartmentName
from Employees
right join Department --võib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

select * from Department

--kuidas saada kõikide tabelite väärtused ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--cross join võtab kaks allpool olevat tabelit kokku
--ja korrutab need omavahel läbi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--päringu sisu
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
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
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

--kasutame Employees tabeli asemel lühendit E ja
--Department puhul D
select E.Name as EmpName, D.DepartmentName as DeptName
from Employees E
left join Department D
on E.DepartmentId = D.Id

--inner join
--kuvab ainult isikuid, 
--kellel on DepartmendID veerus väärtus
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

--kui Expression on õige siis paneb väärtuse, 
--mida soovid või mõne teise väärtuse
--case when Expression Then '' else '' end

--
alter table Employees
add ManagerId int

--neil, kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme päringu, kus kasutame case-i
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
set FirstName = NULL --või '' sisse nimi etc või , middlename =, lastname =
where Id = 10

--igats reast võtab esimene täidetud lahtri ja kuvab ainutl seda
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

--kasutame union all, mis näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas sorteerida nime järgi
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d
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

--kui nüüd allolevat käsklust käima panna, siis nõuab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--õige variant
spGetEmployeesByGenderAndDepartment 'male', 1

--niimoodi saab parameetrite järjestusest mõõda minna
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates sp on store procedure
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja võti peale panna,
--et keegi teine peale teie ei saaks muuta. Kui tahad ära võtta kommenteeri lihtsalt with encryption välja
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

--annab tulemuse, kus loendab ära nõuetele vastavad read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Male', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount
go--tee ülevalpool päring ära ja siis mine edasi
select * from Employees

--näitab ära mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
print @TotalCount

--sp sisu vaatamine??
sp_help spGetEmployeeCountByGender

--tabeli info??
sp_help Employees
--või muu tabel
sp_help Person

--kui soovid näha store procedure teksti siis kasutad helptexti
sp_helptext spGetEmployeeCountByGender

--vaatame, millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabeli sõltuvust (näeb store procedures)
sp_depends Employees

--sp tegemine (kui vaja muuta siis create asemel alter)
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

--nüüd selle kasutamine(tulemust ei näe vaid saab pigem koodis vms kasutada)
execute spGetNameById 1, 'Tom'

--sp annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--nüüd saame teada, et mitu rida on andmeid on tabelis
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

---mis id all on keegi nime järgi
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

--kutsuda läbi declarei abi välja sp nimega spGetNameById2
--ja öelda miks see ei tööta
declare @EmployeeName nvarchar(20)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

--sisseehitatud string funktsioonid

--See konventeerib ASCII tähe väärtuse numbriks
select ASCII('a')
--kuvab A-tähte
select char(65)


--prindime välja kogu tähestiku (Kui al 65 siis suured ka)
declare @Start int
set @Start = 97
while(@Start <= 122)
begin
	select CHAR (@Start)
	set @Start = @Start + 1
end

--eemaldame tühjad kohad sulgudes
select LTRIM('                    Hello')

--tühikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

---paremalt poolt tühjad stringid lõikab ära
select RTRIM('     Hello   ')
select RTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

---keerab kooloni sees olevad andmed vastupidiseks
---vastavat upper ja lower-ga saan muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, LOWER(LastName),
RTRIM(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

---näeb, mitu tähte on sõnal ja loeb tühikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
---näeb, mitu tähte on s'nal ja ei ole tühikuid (ps firstname ette või ka trim
select FirstName, len(trim(FirstName)) as [Total Characters] from Employees

---left, right, substring
---vasakult poolt neli esimest tähte siis paremalt
select left('ABCDEF', 4)
select right('ABCDEF', 4)

--kuvab @-tähemärgi asetust
select CHARINDEX ('@', 'sara@aaa.com')

---esimene nr peale komakohta näitab, et 
--mitmendast alustab ja siis mitu nr kaasaarvatult kuvab
select SUBSTRING('pam@bbb.com', 5, 2)


---@-märgist kuvab kolm tähemärki. Viimase nr saab määrata pikkust(11-4 on 7)
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

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + ---peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email) + 1) as Email
from Employees

--kolm korda näitab midagi
select REPLICATE('asd', 3)

---kuidas sisestada tühikut kahe nime vahele
select SPACE(5)

---tühikute arv kahe nime vahel
select FirstName + SPACE(25) + LastName as FullName
from Employees

---PATINDEX
---sama, mis CHARINDEX, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@hotmail.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@hotmail.com', Email) > 0

---kõik  .com-d asendatakse .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimes märki kolm tähte viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees