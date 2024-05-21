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

create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)
select * from DateTime

--konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

insert into DateTime 
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

update DateTime set c_datetimeoffset = '2024-04-02 09:34:09.1533333 +11:00'
where c_datetimeoffset = '2024-04-02 09:34:09.1533333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja päring
select SYSDATETIME(), 'SYSDATETIME' --veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' --UTC aeg

select ISDATE ('asd') --tagastab 0 kuna string ei ole date
select ISDATE(GETDATE()) --Tagastab ühe kuna on kuupäev
select ISDATE('2024-04-02 09:34:09.1533333') --tagastab 0 kuna max kolm komakohta võib olla
select ISDATE('2024-04-02 09:34:09.153') --tagastab 1
select DAY(GETDATE()) --annab tänase päeva numbri
select DAY('04/15/2024') --annab  stringis oleva kp ja järjestus peab olema õige
select MONTH(GETDATE()) --annab jooksva kuu numbri
select MONTH('04/15/2024') --annab stringis oleva kuu numbri
select YEAR(GETDATE()) --annab jooksva aasta numbri
select YEAR('04/15/2024') --annab stringis oleva aasta nr


select DATENAME(DAY, '2024-04-02 09:34:09.153') --annab stringis oleva päeva numbri
select DATENAME(weekday, '2024-04-02 09:34:09.153') --annab stringis oleva päeva s'nana
select DATENAME(MONTH, '2024-04-02 09:34:09.153') --annab stringis oleva kuu s'nana

create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)


insert into EmployeesWithDates (Id, Name, DateOfBirth)
values ('1', 'Sam', '1980-12-30 00:00:00.000'),
('2', 'Pam', '1982-09-01 12:02:36.260'),
('3', 'John', '1985-08-22 12:03:30.370'),
('4', 'Sara', '1979-11-29 12:59:30.670'),
('5', 'Todd', '1978-11-29 12:59:30.670')

select * from EmployeesWithDates

---kuidas võtta ühest veerust andmeid ja selle abil luua uued andmed
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vaatab DoB'd veerust päeva ja kuvab päeva nimetuse sõnana
		MONTH(DateOfBirth) as MonthNumber, --vt DoB veerust kp-d ja kuvab kuu nr
		DateName(MONTH, DateOfBirth) as [MonthName], --vt DoB veerust kuus ja kuvab sinna
		YEAR(DateOfBirth) as [Year] --võtab DoB veerust aasta
from EmployeesWithDates

select DATEPART(WEEKDAY, '1980-12-30 00:00:00.000') ---kuvab 3 kuna USA nädal algab pühapäevaga
select DATEPART(MONTH, '1980-12-30 00:00:00.000') --kuvab kuu nr
select DATEADD(DAY, 20, '1980-12-30 00:00:00.000') --liidab stringis olevale kp 20 päeva juurde
select DATEADD(DAY,-20, '1980-12-30 00:00:00.000') --lahutab stringis olevale kp 20 päeva juurde
select DATEDIFF(MONTH, '11/30/2023', '04/02/2024') --kuvab kahe stringi kuudevahelist aega nr-na
select DATEDIFF(YEAR, '11/30/2023', '04/02/2024') --kuvab kahe stringi aastavahelist aega nr-na

---
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB)
		= month(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(GETDATE()) then 1 else 0 end
		select @tempdate = DATEADD(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())
	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' +cast(@months as nvarchar(2)) + ' Months ' +cast(@days as nvarchar(2)) +
		' Days old'
	return @Age
end

--saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

--kui kasutame seda funktsiooni siis saame teada tänase päeva vahet stringis välja tooduga.
select dbo.fnComputeAge('11/30/2011')

--nr peale DoB muutujat näitab, et mismoodi kuvada DoB-d
select Id, Name, DateOfBirth,
CONVERT(nvarchar, DateOfBirth, 101) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' +cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(GETDATE() as date) --tänane kp
select CONVERT(date, getdate()) --tänane kp

--matemaatilised funktsioonid

select ABS(-101.5) --abs on absoluutne nr ja tulemuseks saame ilma - märgita tulemuse
select CEILING(15.2) --ümbardab ülesse täisarvu suunas
select CEILING(-15.2) --tagastab -15 ja suurendam suurema positiivse täisarvu suunas
select FLOOR(15.2) --ümardab negatiivsema numbri poole
select FLOOR(-15.2) --ümardab positiivsema numbri poole
select power(2, 4) --hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) --antud juhul 9 ruudus
select SQRT(81) --annab vastuse 9 ruutjuur

select rand() --annab suvalise nr
select FLOOR(RAND() *100) --täisarv

--iga kord näitab 10 suvalsi nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand() * 1000)
	set @counter =  @counter +1
end

select round(850.556, 2) --ümardab kaks kohta peale komat, tulemus on 850.560
select round(850.556, 2, 1) --ümardab allapoole, tulemuse 850.550
select round(850.556, 1) --ümardab ülespole ja võtab ainult esimest nr peale koma arvesse
select round(850.556, 1, 1) --ümardab allapoole
select round(850.556, -2) --ümardab täisnr ülesse
select round(850.556, -1) --ümardab täisnr alla

create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
	case
		when (MONTH(@DOB) > MONTH(GETDATE())) or
			 (MONTH(@DOB) > MONTH(GETDATE()) and  DAY(@DOB) > DAY(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

exec CalculateAge '10/08/2022'

-- arvutab välja, kui vana on isik ja võtab arvesse kuud ja päevad
-- antud juhul näitab kõike, kes on üle 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 42

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

update EmployeesWithDates set DepartmentID = 1 where Id = 1
update EmployeesWithDates set DepartmentID = 2 where Id = 2
update EmployeesWithDates set DepartmentID = 1 where Id = 3
update EmployeesWithDates set DepartmentID = 3 where Id = 4
update EmployeesWithDates set DepartmentID = 1 where Id = 5

update EmployeesWithDates set Gender = 'Male' where Id = 1
update EmployeesWithDates set Gender = 'Female' where Id = 2
update EmployeesWithDates set Gender = 'Male' where Id = 3
update EmployeesWithDates set Gender = 'Female' where Id = 4
update EmployeesWithDates set Gender = 'Male' where Id = 5

select * from EmployeesWithDates

s (4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values (5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values (2, 'Pam', 6000, 'Female', 'Sydney')

select * from EmployeeCity

--klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis
-- ja seda saab klastrite puhul olla ainult üks

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--annab veateate, et tabelis saab olla ainult üks klastris olev indeks
--kui soovid, uut indeksit luua, siis kustuta olemasolev

--saame luua ainult ühe klastris oleva indeksi tabeli peale
--klastris olev indeks on analoogne telefoni suunakoodile

select * from EmployeeCity
go
create clustered index IX_EmployeeCity_Gender_Salary
on EmployeeCity(Gender desc, salary asc)
go
select * from EmployeeCity
--kui teed select päringu sellele tabelile, siis peaksid nägema andmeid, mis on järjestatud selliselt:
--Esimeseks v'etakse aluseks Gender veerg kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

--erinevused kahe indeksi vahel
--1. ainult üks klastris olev indeks saab olla tabeli peale,
--Mitte-klastris olevaid indekseid saab olla mitu
---2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--juhul, kui selekteeritud veerg ei ole olemas indeksis
--3. Klastris olev indeks määratleb ära tabeli ridade salvestusjärjestuse
--ja ei nõua kettal lisa ruumi. Samas mitte klastris olevad indeksid on
--salvestatud tabelist eraldi ja nõuab lisa ruumi.

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC07F7C3D549
--kui k'ivitad [levalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit jõustamaks väärtuste unikaalsust ja primaarvõtit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga käsitsi saab

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- unikaalset indeksid kasutatakse kindlustamaks väärtuste unikaalsust (sh primaarvõtme oma)

create unique nonclustered index UIX_Employee_Firstname_Lastname
on EmployeeFirstName(FirstName, LastName)


--alguses annab veateate, et Mike Sandoz ei ole unikaalne
--ei saa lisada mitte-klastris olevat indeksit, kui ei ole unikaalseid andmeid
--kustutame tabeli sisu ja sisestame andmed uuesti
truncate table EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--lisame uue unikaalse piirangu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--ei luba tabelisse väärtusega uut Londonit kuna constraint on peal
insert into EmployeeFirstName values(3, 'John', 'Menco', 2500, 'Male', 'London')

--saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

--
--1. Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
--loob unikaalse mitte-klastris oleva indeksi
--2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel
--juba sisaldab väärtusi võtmeveerus
--3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud,
--kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada 10 rida andmeid,
--millest 5 sisaldavad korduvaid andmeid, siis kõik 10 lükatakse tagasi. Kui soovid ainult 5
--rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

--koodinäide

create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key


insert into EmployeeFirstName values(3, 'John', 'Menco', 5500, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 6500, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 7500, 'Male', 'London1')
--enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga 
--nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne

select * from EmployeeFirstName

--view

--view on salvestatud SQL-i päring. Saab käsitleda ka virtuaalse tabelina
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--teeme view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--view päringu esile kutsumine
select * from vEmployeesByDepartment

--view ei salvesta andmeid vaikimisi
--seda tasub võtta, kui salvestatud virtuaalse tabelina

--mileks vaja:
--saab kasutada abdmebaasi skeemi keerukuse lihtsustamiseks,
--mitte IT-inimesele
--piiratud ligipääs andmetele, ei näe kõiki veerge

--teeme view, kus näeb ainult IT töötajaid
--kasutada tabelit Employees ja Department
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
--ülevalpool olevat päringut saab liigitada reataseme turvalisuse alla
--tahan näidata ainult IT osakonna töötajaid.

select * from vITEmployeesInDepartment


--veeru taseme turvalisus
--peale selecti määratled veergude näitamise ära
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow


--saab kasutada esitlemaks koondandmeid ja üksikasjalikke andmeid
--view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

--kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
--muutmine
alter view vEmployeesCountByDepartment
--kustutamine
drop view vEmployeesCountByDepartment

--view uuendused
--kas läbi view saab uuendada andmeid 

--teeme andmete uuenduse, aga enne teeme view
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

update vEmployeesDataExceptSalary
set [FirstName] = 'Tom' where Id = 2

--kustutame ja sisestame andmeid läbi view
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam')

--indekseertiud vie
--MS SQL-s on indekseeritud view nime all
--Oracles on materjaliseeritud view

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values
(1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10)

create table ProductSales 
(
Id int,
QuantitySold int
)
insert into ProductSales values
(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

--loome view, mis annab meile veeru TotalSales ja TotalTransactions
create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

--kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
--1. view tuleb luua koos schemabinding-ga
--2. kui lisafunktsiooni select list viitab väljendile ja selle tulemuseks
--võib olla NULL, siis asendusväärtus peaks olema täpsustatud.
--Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
--3. kui GroupBy on täpsustatud, siis view select list peab
--sisaldama COUNT_BIG(*) väljendit
--4. Baastabelis peaksid view-d olema viidatud kaheosalise nimega
--antud juhult dbo.Product ja dbo.ProductSales.

select * from vTotalSalesByProduct

--view piirangud
create view vEmployeeDetails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--Viewsse ei saa kaasa panna parameetreid e antud juhul Gender

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetritega
select * from fnEmployeeDetails('male')

--order by kasutamine view-s
create view vEmployeeDetailsSorted
as
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id
--order by-d ei saa kasutada

--temp tabeli kasutamine
create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

insert into ##TestTempTable values
(101, 'Martin', 'Male'),
(102, 'Joe', 'Male'),
(103, 'Pam', 'Female'),
(104, 'James', 'Male')

create view vOnTempTable
as
select Id, FirstName, Gender
fromt ##TestTempTable
--temp tabelit ei saa kasutada view-s

--Triggerid

--DML trigger
--kokku on kolme tüüpi: DML, DDL ja LOGON

--trigger on stored procedure eriliik, mis automaatselt käivitub, kui mingi tegevus
--peaks andmebaasis aset leidma

--DML-data manipulation language
--DML-i põhilised käsklused: insert, update ja delete

--DML triggereid saab klassifitseerida kahte tüüpi:
--1. After trigger (kutsutakse ka FOR triggeriks)
--2. Instead of trigger(selmet trigger e selle asemel trigger)

--after trigger käivitub peale sündmust, kui kuskil on tehtud insert, update ja delete


--loome uue tabeli
create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale iga töötaja sisestamist tahame teada saada töötaja Id'd, päeva ning aega
--(millal sisestati). Kõik andmed lähevad EmployeeAudit tabelisee

create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with id = ' + cast(@Id as nvarchar(5)) + ' is added at '
+ cast(getdate() as nvarchar(20)))
end

insert into Employees values (11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bob.com')

select * from EmployeeAudit

--delete trigger
create trigger trEmployeeForDelete
on Employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	insert into EmployeeAudit
	values ('An existing employee with Id = ' + cast(@Id as nvarchar(5)) +
	' is deleted at ' + cast(GETDATE() as nvarchar(20)))
end

delete from Employees where Id = 11

select * from EmployeeAudit

--update trigger

create trigger trEmployeeForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(20), @NewEmail nvarchar(50)

	--muutuja, kuhu läheb lõpptekst
	declare @AuditString nvarchar(1000)
	
	--laeb kõik uuendatud andmed temp tabeli alla
	select * into #TempTable
	from inserted

	--käib läbi kõik andmed temp tabelis
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimese rea andmed temp tabelist
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId, 
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		--võtab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi dünaamiliselt
		set @AuditString = 'Employee With Id = ' + CAST(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + CAST(@OldSalary as nvarchar(20)) + ' to ' +
			CAST(@NewSalary as nvarchar(20))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + CAST(@OldDepartmentId as nvarchar(20)) + ' to ' +
			CAST(@NewDepartmentId as nvarchar(20))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + CAST(@OldManagerId as nvarchar(20)) + ' to ' +
			CAST(@NewManagerId as nvarchar(20))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' FirstName from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' MiddleName from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' LastName from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--kustutab temp tabel-ist rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employees set 
FirstName = 'test124433',
Salary = 4004, 
MiddleName = 'test454346',
Email = 'test@test.com'
where Id = 2

select * from Employees
select * from EmployeeAudit

--instead of trigger

create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

create table Departments
(
Id int primary key,
DepartmentName nvarchar(20),

)

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

insert into Departments values
(1, 'IT'),
(2, 'Payroll'),
(3, 'HR'),
(4, 'Other Department')

---
create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Departments
on Employee.DepartmentId = Departments.Id

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
--tuleb veateade
--nüüd vaatame, et kuidas saab instead of triggeriga seda probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert 
as begin
	declare @DeptId int

	select @DeptId = dbo.Departments.Id
	from Departments
	join inserted
	on inserted.DepartmentName = Departments.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement terminated', 16, 1)
		return
	end

	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

-- raiserror funktsioon
--selle eesmärk on tuua välja veateade, kui DepartmentName veerus ei ole väärtust
--ja ei klapi uue sisestatud väärtusega
--Esimene on parameeter veateate sisust. Teine on veataseme nr (nr 16 tähendab üldiseid vigu),
--kolmas on olek

update vEmployeeDetails
set Name = 'Johnny', DepartmentName = 'IT'
where Id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest mõjutatud

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1

select * from vEmployeeDetails

create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin
	
	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare @DeptID int
		select @DeptID = Departments.Id
		from Departments
		join inserted
		on inserted.DepartmentName = Departments.DepartmentName

		if(@DeptId is null)
		begin
			raiserror('Id cannot be changed', 16, 1)
			return
		end

		update Employee set DepartmentId = @DeptID
		from inserted
		join Employee
		on Employee.Id = inserted.id

	end

	if(update(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end

update Employee set Name = 'John123', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails
--nüüd muudab ainult Employees tabelis olevaid andmeid.

---delete trigger
create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Departments
on Employee.DepartmentId = Departments.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

--näitab ära osakonnad, kus on töötajaid 2tk või rohkem
select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select DepartmentName, DepartmentId, Count(*) as TotalEmployees
into #TempEmployeeCount
from Employee
join Departments
on Employee.DepartmentId = Departments.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

alter view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Departments
on Employee.DepartmentId = Departments.Id

delete from vEmployeeDetails where Id = 2

create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
delete Employee
from Employee
join deleted
on Employee.Id = deleted.Id
end

--?üüd käivitate selle koodi uuesti
delete from vEmployeeDetails where Id = 2

--Päritud tabelid ja CTE
--CTE tähendab common table expression

select * from Employee

truncate table Employee

insert into Employee values
(1, 'John', 'Male', 3),
(2, 'Mike', 'Male', 2)

-- CTE näide
with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 1

--päritud tabel
select DepartmentName, TotalEmployees
from
(
select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId
)
as EmployeeCount
where TotalEmployees >= 2

--mitu CTE-d järjest
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	where DepartmentName in ('Payroll', 'IT')
	group by DepartmentName
),
--peale kolma panemist saad uue CTE juurde kirjutada
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
)
--kui on kaks CTE-d, siis union abil ühendab päringu
select * from EmployeeCountBy_Payroll_IT_Dept
union
select * from EmployeeCountBy_HR_Admin_Dept

--
with EmployeeCount(DepartmentId, TotalEmployees)
as
	(
	select DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	group by DepartmentId
	)
-- peale CTE-d peab kohe tulema käsklus SELECT, INSERT, UPDATE või DELETE
--kui proovid midagi muud, siis tuleb veateade

--uuendamine CTE-s

with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)
select * from Employees_Name_Gender

--uuendamine läbi CTE
with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employee
)
update Employees_Name_Gender set Gender = 'Female' where Id = 1

select * from Employee

--kasutame joini CTE tegemisel
with EmployeeByDepartment
as
(
select Employee.Id, Name Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeeByDepartment

--kasutame joini ja muudame ühes tabelis andmeid
with EmployeeByDepartmentUpdate
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeeByDepartmentUpdate set Gender = 'Male' where Id = 1

select * from Employee

--kasutame joini ja muudame mõlemas tabelis andmeid

with EmployeeByDepartmentUpdateBothTables
as
(
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeeByDepartmentUpdateBothTables set 
Gender = 'Male123', DepartmentName = 'IT'
where Id = 1
--ei luba mitmes tabelis korraga muuta

--kokkuvõte CTE-st
--1. kui CTE baseerub ühel tabelil siis uuendus töötab.
--2. kui CTE baseerub mitmel tabelil, siis tuleb veateade.
--3. kui CTE baseerub mitmel tabelil ja tahame muuta ainult ühte tabelit, siis uuendus saab tehtud.

--korduv CTE
--CTE, mis iseendale viitab, kutsutakse korduvaks CTE-ks
--kui tahad andmeid näidata hierarhiliselt

truncate table Employee

insert into Employee values (1, 'Tom', 2)
insert into Employee values (2, 'Josh', null)
insert into Employee values (3, 'Mike', 2)
insert into Employee values (4, 'John', 3)
insert into Employee values (5, 'Pam', 1)
insert into Employee values (6, 'Mary', 3)
insert into Employee values (7, 'James', 1)
insert into Employee values (8, 'Sam', 5)
insert into Employee values (9, 'Simon', 1)

--- self joiniga saab sama tulemuse, mis CTE-ga
---ja kuvada NULL veeru asemel Super Boss
select Emp.Name as [Employee Name],
ISNULL(Manager.Name, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.DepartmentId = Manager.Id

--teeme samatulemusliku päringu
with EmployeesCTE(Id, Name, DepartmentId, [Level])
as
(
	select Employee.Id, Name, DepartmentId, 1
	from Employee
	where DepartmentId is null

	union all

	select Employee.Id, Employee.Name,
	Employee.DepartmentId, EmployeesCTE.[Level] + 1
	from Employee
	join EmployeesCTE
	on Employee.DepartmentId  =EmployeesCTE.Id
)
select EmpCTE.Name as Employee, isnull(MgrCTE.Name, 'SuperBoss') as Manager,
EmpCTE.[Level]
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.DepartmentId = MgrCTE.Id


create table ProductSales
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSales values ('Tom', 'UK', 200)
insert into ProductSales values ('John', 'US', 180)
insert into ProductSales values ('John', 'UK', 260)
insert into ProductSales values ('David', 'India', 450)
insert into ProductSales values ('Tom', 'India', 350)
insert into ProductSales values ('David', 'US', 200)
insert into ProductSales values ('Tom', 'US', 130)
insert into ProductSales values ('John', 'India', 540)
insert into ProductSales values ('John', 'UK', 120)
insert into ProductSales values ('David', 'UK', 220)
insert into ProductSales values ('John', 'UK', 420)
insert into ProductSales values ('David', 'US', 320)
insert into ProductSales values ('Tom', 'US', 340)
insert into ProductSales values ('Tom', 'UK', 660)
insert into ProductSales values ('John', 'India', 430)
insert into ProductSales values ('David', 'India', 230)
insert into ProductSales values ('David', 'India', 280)
insert into ProductSales values ('Tom', 'UK', 480)
insert into ProductSales values ('John', 'US', 360)
insert into ProductSales values ('David', 'UK', 140)


select SalesCountry, SalesAgent, SUM(SalesAmount) as Total
from ProductSales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent


--pivot näide
select SalesAgent, India, US, UK
from ProductSales
pivot
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

--päring muudab unikaalsete veergude väärtust(India, US ja UK) SalesCountry veerus
--omaette veergudeks koos veergude SalesAmount liitmisega

create table ProductSalesWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSalesWithId values (1, 'Tom', 'UK', 200)
insert into ProductSalesWithId values (2, 'John', 'US', 180)
insert into ProductSalesWithId values (3, 'John', 'UK', 260)
insert into ProductSalesWithId values (4, 'David', 'India', 450)
insert into ProductSalesWithId values (5,'Tom', 'India', 350)
insert into ProductSalesWithId values (6, 'David', 'US', 200)
insert into ProductSalesWithId values (7, 'Tom', 'US', 130)
insert into ProductSalesWithId values (8, 'John', 'India', 540)
insert into ProductSalesWithId values (9, 'John', 'UK', 120)
insert into ProductSalesWithId values (10, 'David', 'UK', 220)
insert into ProductSalesWithId values (11, 'John', 'UK', 420)
insert into ProductSalesWithId values (12, 'David', 'US', 320)
insert into ProductSalesWithId values (13, 'Tom', 'US', 340)
insert into ProductSalesWithId values (14, 'Tom', 'UK', 660)
insert into ProductSalesWithId values (15, 'John', 'India', 430)
insert into ProductSalesWithId values (16, 'David', 'India', 230)
insert into ProductSalesWithId values (17, 'David', 'India', 280)
insert into ProductSalesWithId values (18, 'Tom', 'UK', 480)
insert into ProductSalesWithId values (19, 'John', 'US', 360)
insert into ProductSalesWithId values (20, 'David', 'UK', 140)

select SalesAgent, India, US, UK
from ProductSalesWithId
pivot
(
	sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

-- põhjuseks on Id veeru olemasolu ProductSalesWithId tabelis, mida võetakse
--arvesse pööramise ja grupeerimise järgi

select SalesAgent, India, US, UK
from
(
	select SalesAgent, SalesCountry, SalesAmount from ProductSalesWithId
)
as SourceTable
pivot
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

--teha üks UNPIVOT tabeliga ProductSalesWithId

select Id, FromAgentOrCountry, CountryOrAgent
from
(
	select Id, SalesAgent, SalesCountry, SalesAmount
	from ProductSalesWithId
) as SourceTable
unpivot
(
	CountryOrAgent for FromAgentOrCountry in (SalesAgent, SalesCountry)
)
as PivotTable

---transactions

---transaction jälgib järgmisi samme:
--1. selle algus
--2. käivita DB käske
--3. konrollib vigu. Kui on viga, siis taastab algse oleku

create table MailingAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(50),
	StreetAddress nvarchar(50),
	City nvarchar(10),
	PostalCode nvarchar(20)
)

insert into MailingAddress
values(1, 101, '#10', 'King Street', 'London', 'CR27DW')

create table PhysicalAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(50),
	StreetAddress nvarchar(50),
	City nvarchar(10),
	PostalCode nvarchar(20)
)

insert into PhysicalAddress
values(1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

--muuda alteriga, kui yks feilib siis teine ka, nvarchar väiksem, ei lase vigu läbi
--
alter proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON 12'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

--käivitame sp
spUpdateAddress

select * from MailingAddress
select * from PhysicalAddress

--kui teine uuendus ei lähe läbi, siis esimene ei lähe ka läbi
--kõik uuendused peavad läbi minema

--transaction ACID test
--edukas transaction peab läbima ACID testi:
--A - atmoic e aatomlikus
--C - consistent e järjepidevus
--I - isolated e isoleeritus
--D - durable e vastupidav

---Atomic - kõik tehingud transactionis on kas edukalt täidetud või need
--lükatakse tagasi. Nt, mõlemad käsud peaksid alati õnnestuma. Andmebaas
--teeb sellisel juhul: võtab esimese update tagasi ja veeretab selle algasendisse
-- e taastab algsed andmed

---Consistent - kõik transactioni puudutavad andmed jäetakse loogiliselt
--järjepidavusse olekusse. Nt, kui laos saadaval olevaid esemete hulka 
--vähendatakse, siis tabelis peab olema vastav kanne. Inventuur ei saa lihtsalt kaduda.

--- Isolated - transaction peab andmeid mõjutama, sekkumata teistesse
-- samaaegsetesse transactionitesse. See takistab andmete muutmist, mis
-- põhinevad sidumata tabelitel. Nt, muudatused kirjas, mis hiljem tagasi
-- muudetakse. Enamik DB-d kasutab tehingute isoleerimise säilitamiseks
-- lukustamist.

--- Durable - kui muudatus on tehtud, siis see on püsiv. Kui süsteemiviga või
-- voolukatkestus ilmneb enne käskude komplekti valmimist, siis tühistatakse need
-- käsud ja andmed taastatakse algsesse olekusse. Taastamine toimub peale
-- süsteemi taaskäivitamist.

---subqueries
create table Product
(
	Id int identity primary key,
	Name nvarchar(50),
	Description nvarchar(250)
)

create table ProductSales
(
	Id int primary key identity,
	ProductId int foreign key references Product(Id),
	UnitPrice int,
	QuantitySold int
)

insert into Product values
('TV', '52 inch black color OLED TV'),
('Laptop', 'Very thin black color laptop'),
('Desktop', 'HP high performance desktop')

insert into ProductSales values
(3, 450, 5),
(2, 250, 7),
(3, 450, 4),
(3, 450, 9)

select * from Product
select * from ProductSales

--kirjutame päringu, mis annab infot müümata toodetest
select Id, Name, Description
from Product
where Id not in (select distinct ProductId from ProductSales)

--enamus juhtudel saab subquerit asendada JOIN-ga
--teeme sama päringu JOIN-ga
select Product.Id, Name, Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null

--teeme subquerie, kus asutame select-i. Kirjutame päringu, kus
--saame teada NAME ja TotalQuantity veeru andmed
select Name,
(select sum(QuantitySold) from ProductSales Where ProductId = Product.Id) as
[Total Quantity]
from Product
order by Name

--sama tulemus JOIN-ga
select Name, sum(QuantitySold) as TotalQuantity
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
group by Name
order by Name

--subqueryt saab subquery sisse panna
--subquerid on alati sulgudes ja neid nimetatakse sisemisteks päringuteks

--rohkete andemetega testimise tabel

truncate table ProductSales
truncate table Product

--sisestame näidisandmed Product tabelisse:
declare @Id int
set @Id = 1
while(@Id <= 30000)
begin
	insert into Product values('Product - ' + cast(@Id as nvarchar(20)),
	'Product - ' + cast(@Id as nvarchar(20)) + ' Description')

	print @Id
	set @Id = @Id + 1
end

declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int
-- ProductId
declare @LowerLimitForProductId int
declare @UpperLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000000
--UnitPrice
declare @LowerLimitForUnitPrice int
declare @UpperLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 200
--QuantitySold
declare @LowerLimitForQuantitySold int
declare @UpperLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 100

declare @Counter int
set @Counter = 1

while(@Counter <= 450000)
begin
	select @RandomProductId = round(((@UpperLimitForProductId - 
	@LowerLimitForProductId) * Rand() + @LowerLimitForProductId), 0)

	select @RandomUnitPrice = round(((@UpperLimitForUnitPrice - 
	@LowerLimitForUnitPrice) * Rand() + @LowerLimitForUnitPrice), 0)

	select @RandomQuantitySold = round(((@UpperLimitForQuantitySold - 
	@LowerLimitForQuantitySold) * Rand() + @LowerLimitForQuantitySold), 0)

	insert into ProductSales
	values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	print @Counter
	set @Counter = @Counter + 1
end

select * from Product
select * from ProductSales

select count(*) from Product
select count(*) from ProductSales

--võrdleme subquerit ja JOIN-i
select Id, Name, Description
from Product
where Id in
(
select Product.Id from ProductSales
)

---8,669,614 rida 39 sekundit

--teeme cache puhtaks, et uut päringut ei oleks kuskile vahemällu salvestatud
checkpoint;
go
dbcc DROPCLEANBUFFERS; --puhastab päringu cache-i
go
dbcc FREEPROCCACHE; --puhastab täitva planeeritud cache-i
go

-- teeme sama tabeli peale inner join päringu
select distinct Product.Id, Name, Description
from Product
inner join ProductSales
on Product.Id = ProductSales.ProductId

--päring tehti alla 1 sekundiga ära
--teeme jälle cache puhtaks

select Id, Name, Description
from Product
where not exists(select * from ProductSales where ProductId = Product.Id)

--sain 8,658,537 rida ja tehti ära 38 sekundiga
--teeme vahemälu puhtaks


--kasutame left joini
select Product.Id, Name, Description
from Product
left join ProductSales
on Product.Id = ProductSales.ProductId
where ProductSales.ProductId is null
-- tegi 8,658,537 rida 43 sekundiga


--CURSOR
--Relatsiooniliste DB-de haldussüsteemid saavad väga hästi hakkama
--SETS-ga. SETS lubab mitu päringut kombineerida üheks tulemuseks.
--Sinna alla käivad UNION, INTERSECT ja EXCEPT.

update ProductSales set UnitPrice = 50 where ProductSales.ProductId = 163338

--kui vaja rea kaupa andmeid töödelda, siis kõige parem oleks kasutada
--Cursoreid. Samas on need jõudlusele halvad ja võimalusel vältida.
--Soovitatav oleks kasutada JOIN-i.

--Cursorid jagunevad omakorda neljaks:
--1. Forward-Only e edasi-ainult
--2. Static e staatilised
--3. Keyset e võtmele seadistatud
--4. Dynamic e dünaamiline

--cursori näide:
if the ProductName = 'Product - 55', set UnitPrice to 55

declare @ProductId int
--deklareerime cursori
declare ProductIdCursor cursor for
select ProductId from ProductSales
--open avaldusega täidab select avaldusega
--ja sisestab tulemuse
open ProductIdCursor

fetch next from ProductIdCursor into @ProductId
--kui tulemuses on veel ridu, siis @FETCH_STATUS on 0
while(@@FETCH_STATUS = 0)
begin
	declare @ProductName nvarchar(50)
	select @ProductName = Name from Product where Id = @ProductId

	if(@ProductName = 'Product - 55')
	begin
		update ProductSales set UnitPrice = 55 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 65')
	begin
		update ProductSales set UnitPrice = 65 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 1000')
	begin
		update ProductSales set UnitPrice = 1000 where ProductId = @ProductId
	end

	fetch next from ProductIdCursor into @ProductId
end
--vabastab rea seadistuse e sulgeb cursori
close ProductIdCursor
--vabastab ressursid, mis on seotud cursoriga
deallocate ProductIdCursor

--vaatame, kas read on uuendatud
select Name, UnitPrice
from Product join
ProductSales on Product.Id = ProductSales.ProductId
where(Name = 'Product - 55' or Name = 'Product - 65' or Name = 'Product - 1000')

--asendame cursori JOIN-ga 
update ProductSales
set UnitPrice = 
	case
		when Name = 'Product - 1' then 1553443
		when Name = 'Product - 2' then 1653434
		when Name like 'Product - 3' then 1034344001
	end
from ProductSales
join Product
on Product.Id = ProductSales.ProductId
where Name = 'Product - 1' or Name = 'Product - 2' or Name like 'Product - 3'

select * from ProductSales
select * from Product

--tabelite info

--nimekiri tabelitest
select * from SYSOBJECTS where xtype = 'S'

select * from sys.tables
--nimekiri tabelitest ja view-st
select * from INFORMATION_SCHEMA.TABLES


--kui soovid erinevaid objektitüüpe ´vaadata, siis kasuta XTYPE süntaksit
select distinct XTYPE from sysobjects

--IT - Internal table
--P - stored procedure
--PK - primary key constraint
--S - system table
--SQ - service queue
--U - user table
-- V - view

--annab teada, kas selle nimega tabel on juba olemas
if not exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Employee')
begin
	create table Employee
	(
		Id int primary key,
		Name nvarchar(30),
		DepartmentId int
	)

	print 'Table created'
end
	else
begin
	print 'Table already exists'
end

--saab kasutada sissehitatud funktsiooni: OBJECT_ID()
if OBJECT_ID('Employee') is null
begin
	print 'Where is no such table'
end
else
begin
	print 'Table already exists'
end

--tahame sama nimega tabeli ära kustutad ja siis uuesti luua
if OBJECT_ID('Employee') is not null
begin
	drop table Employee
end
create table Employee
(
Id int primary key,
Name nvarchar(30),
ManagerId int
)

alter table Employee
add Email nvarchar(50)

--kui uuesti käivitatakse veeru kontrollimist ja loomist
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where
COLUMN_NAME = 'Asd' and TABLE_NAME = 'Employee' and TABLE_SCHEMA = 'dbo')
begin
	alter table Employee
	add Asd nvarchar(50)
end
else
begin
	print 'Column already exists'
end

--kontrollime, kas mingi nimega veerg on olemas
if COL_LENGTH('Employee', 'Email') is not null
begin
	print 'Column already exists'
end
else
begin
	print 'Column does not exists'
end

--MERGE
--tutvustati aastal 2008, mis lubad teha sisestamist, uuendamist ja kustutamist
--ei pea kasutama mitut käsku

--merge puhul peab alati olema vähemalt kaks tabelit:
--1. algallika tabel e source table
--2. sihtmärk tabel e target table

--Ühendab sihttabeli lähtetabeliga ja kasutab mõlemis tabelis ühist veergu
--koodinäide: ps kondikava
merge [TARGET] as T
using [SOURCE] as S
	on[JOIN CONDITIONS]
when matched then
	[UPDATE_STATEMENT]
when not matched by target then
	[INSERT_STATEMENT]
when not matched by source then
	[DELETE_STATEMENT]

--

create table StudentSource
(
Id int primary key,
Name nvarchar(20)
)
go
insert into StudentSource values
(1, 'Mike'),
(2, 'Sara')
go
create table StudentTarget
(
Id int primary key,
Name nvarchar(20)
)
insert into StudentTarget values
(1, 'Mike M'),
(3, 'John')
go

--1. kui leitakse klappiv rida, siis StudentTarget tabel on uuendatud
--2. kui read on StudentSource tabelis olemas, aga neid ei ole StudentTarget-s,
--siis puuduolevad read sisestatakse
--3. kui read on olemas StudentTarget-s, aga mitte StudentSource-s,
--siis StudentTarget tabelis read kustutatakse ära
merge StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.Name = S.Name
when not matched by target then
	insert (Id, Name) values(S.Id, S.Name)
when not matched by source then
	delete;
go
select * from StudentTarget
select * from StudentSource

--tabelid sisust tühjaks
truncate table StudentTarget
truncate table StudentSource

insert into StudentSource values
(1, 'Mike'),
(2, 'Sara')

insert into StudentTarget values
(1, 'Mike M'),
(3, 'John')

merge StudentTarget as T
using StudentSource as S
on T.Id = S.Id
when matched then
	update set T.Name = S.Name
when not matched by target then
	insert (Id, Name) values(S.Id, S.Name);
go
select * from StudentTarget
select * from StudentSource

--transaction-d

--mis see on?
--on rühm käske, mis muudavad DB-s salvestatud andmeid.
--Tehingut käsitletakse ühe tööüksusena. Kas kõik käsud
--õnnestuvad või mitte. Kui õks tehing sellest ebaõnnestub
--siis kõik juba muudetud andmed muudetakse tagasi ja tehingut ei viida läbi.

create table Account
(
Id int primary key,
AccountName nvarchar(25),
Balance int
)

insert into Account values
(1, 'Mark', 1000),
(2, 'Mary', 1000)

begin try
	begin transaction
		update Account set Balance = Balance - 100 where Id = 1
		update Account set Balance = Balance +100 where Id = 2
	commit transaction
	print 'Transaction Commited'
end try
begin catch
	rollback tran
	print 'Transaction rolled back'
end catch
go
select * from Account

--mõned levinumad probleemid:

--1. Dirty read e must lugemine
--2. Lost Updates e kadunud uuendused
--3. Nonrepeatable reads e kordumatud lugemised
--4. Phantom read e fantoom lugemine

--kõik eelnevad probleemid lahendaks ära, kui lubaksite igal ajal
--korraga ühel kasutajal ühe tehingu teha. Selle tulemusel kõik tehingud
--satuvad järjekorda ja neil võib tekkida vajadus kaua oodata, enne
--kui võimalus tehingut teha saabub.

--kui lubada samaaegselt kõik tehingud ära teha, siis see omakorda
--tekitab probleeme. Probleemi lahendamiseks pakub MSSQL Server
--erinevaid tehinguisolatsiooni tasemeid, et tasakaalustada
--samaaegsete andmete CRUD(create, read, update ja delete) probleeme:

--1. read uncommited e lugemine ei ole teostatud
--2. read commited e lugemine tehtud
--3. repeated e korduv lugemine
--4. snapshot e kuvatõmmis
--5. serializable e serialiseerimine

--igale juhtumile tuleb läheneda juhtumipõhiselt ja
--mida vähem valet lugemist tuleb, seda aeglasem

-- dirty read näide
create table Inventory
(
Id int identity primary key,
Product nvarchar(100),
ItemsInStock int
)
go 
insert into Inventory values('iPhone', 10)
select * from Inventory

-- 1 käsklus
-- 1 transaction
begin tran
update Inventory set ItemsInStock = 9 where Id = 1
-- kliendile tuleb arve
waitfor delay '00:00:15'
-- ebapiisav saldojääk, teeb rollback
rollback tran

-- 2 käsklus
-- samal ajal tegin uue päringuga
-- akna, kus kohe peale esimest
-- käivitan teise
-- 2 transaction
set tran isolation level read uncommitted
select * from Inventory where Id = 1 

-- 3 käsklus
-- käivita, kui 1 käsklus on möödas
-- nüüd panen selle käskluse tööle
select * from Inventory (nolock)
where Id = 1

-- muutsin esimese käsuga 9 iPhone
--ikka on 10 tk.

-- lost update probleem
select * from Inventory

set tran isolation level repeatable read

-- tran 1
begin tran
declare @ItemsInStock int

select @ItemsInStock = ItemsInStock
from Inventory where Id = 1

waitfor delay '00:00:10'
set @ItemsInStock = @ItemsInStock - 1

update Inventory
set ItemsInStock = @ItemsInStock where Id = 1

print @ItemsInStock
commit tran

select * from Inventory

-- samal ajal panen teise transactioni
-- tööle teisest päringust

set tran isolation level repeatable read
begin tran
declare @ItemsInStock int

select @ItemsInStock = ItemsInStock
from Inventory where Id = 1
waitfor delay '00:00:01'
set @ItemsInStock = @ItemsInStock - 2

update Inventory
set ItemsInStock = @ItemsInStock where Id = 1

print @ItemsInStock
commit tran

-- non repeatable read näide

--see juhtub kui üks transaction loeb samu 
--andmeid kaks korda ja teine transaction uuendab 
--neid andmeid esimese ning teise käsu vahel 
--esimese transactioni jooksutamise ajal

-- esimene transaction
set tran isolation level repeatable read
begin tran
select ItemsInStock from Inventory where Id = 1

waitfor delay '00:00:10'

select ItemsInStock from Inventory
where Id = 1
commit tran

-- nüüd käivitan teise transactioni
-- teises editoris
update Inventory set ItemsInStock = 10 
where Id = 1

--- phantom read
create table Employee
(
Id int primary key,
Name nvarchar(25)
)

insert into Employee values
(1, 'Mark'),
(3, 'Sara'),
(100, 'Mary')

--transaction 1
set tran isolation level serializable

begin tran
select * from Employee where Id between 1 and 3

waitfor delay '00:00:10'
select * from Employee where Id between 1 and 3
commit tran

--panen kohe teise trani tööle
insert into Employee
values(2, 'Marcus') 

--vastuseks tuleb Mark ja Sara.
--Marcust ei näita, aga peaks

-- erinevus korduslugemisega ja serialiseerimisega
-- korduv lugemine hoiab ära kordumatud lugemised ja 
-- phantom read probleemid
-- isolatsioonitase tagab, et ühe tehingu loetud andmed ei
-- takistaks muid transactioneid

-- DEADLOCK
-- kui andmebaasis tekib ummikseis
create table TableA
(
Id int identity primary key,
Name nvarchar(50)
)

Insert into TableA values('Mark')
go
create table TableB
(
Id int identity primary key,
Name nvarchar(50)
)

insert into TableB values('Mary')

--transaction 1

-- samm nr 1
begin tran
update TableA set Name = 'Mark Transaction 1' where Id = 1

-- samm nr 3
update TableB set Name = 'Mary Transaction 1' where Id = 1
commit tran

-- teine server
-- samm nr 2
begin tran
update TableA set Name = 'Mark Transaction 2' where Id = 1

-- samm nr 4
update TableB set Name = 'Mary Transaction 2' where Id = 1
commit tran
truncate table TableB

select * from TableA
select * from TableB

--Kuidas SQL server tuvastab deadlocki?
--Lukustatakse serveri lõim, mis töötab vaikimisi iga 5 sek järel
-- et, tuvastada ummikuid. Kui leiab deadlocki, siis langeb
--deadlocki intervall 5 sek-lt 100 millisekundidni.

--mis juhtub deadlocki tuvastamisel
--Tuvastamisel lõpetab DB-mootor deadlocki ja valib ühe lõime
--ohvriks. Seejärel keeratakse deadlockiohvri tehing tagasi ja
--tagastatakse rakendusele viga 1205. Ohvri Tehingu tagasitõmbamine
--vabastab kõik selle transactioni valduses olevad lukud.
--see võimaldab teistel transactionitel blokeeringud tühistada ja 
--edasi liikuda

--mis on DEADLOCK_PRIORITY
--vaikimisi valib SQL server deadblockiohvri tehingu, mille
--tagasivõtmine on kõige odavam (võtab vähem ressurssi). Seanside
--prioriteeti saab muuta SET DEADLOCK_PRIORITY

--DEADLOCK_PRIORITY
---1. vaikimisi on see Normali peal
---2. saab seadistada LOW, NORMAL ja HIGH peale
---3. Saab seadistada ka nr väärtusena -10st kuni 10-ni

--Ohvri valimise kriteeriumid
--1. Kui prioriteedid on erinevad, siis kõige madalama
--tähtsusega valitakse ohvriks
--2. kui mõlemal sessioonil on sama prioriteet, siis valitakse
--ohvriks transaction, mille tagasiviimine on kõige vähem ressurssi nõudev.
--3. Kui mõlemal sessioonil on sama prioriteet ja sama 
--ressursi kulutamine, siis ohver valitakse juhuslikuse alusel.

truncate table TableA
truncate table TableB

insert into TableA values
('Mark'),
('Ben'),
('Todd'),
('Pam'),
('Sara')

insert into TableB values
('Mary')

--1 tran
--1 samm
begin tran
update TableA set Name = Name +
' Transaction 1' where Id in (1, 2, 3, 4, 5)

--3 samm
update TableB set Name = Name +
' Transaction 1' where Id = 1

--5 samm
commit tran

--teine server
--2 samm
set deadlock_priority high
go
begin tran
update TableB set Name = 
Name + ' Transaction 1' where Id = 1

--4 samm
update TableA set Name = 
Name + ' Transaction 1' where Id in (1, 2, 3, 4, 5)

-- 6 samm
commit tran


truncate table TableA
truncate table TableB

--
insert into TableA values('Mark')
insert into TableB values ('Mary')

create proc spTransaction1
as begin
	begin tran
	update TableA set Name = 'Mark Transaction 1' where Id = 1
	waitfor delay '00:00:05'
	update TableB set Name = 'Mary Transaction 1' where Id = 1
	commit tran
end

create proc spTransaction2
as begin
	begin tran
	update TableB set Name = 'Mark Transaction 2' where Id = 1
	waitfor delay '00:00:05'
	update TableA set Name = 'Mary Transaction 2' where Id = 1
	commit tran
end

exec spTransaction1
exec spTransaction2

--errorlogi kuvamine
execute sp_readerrorlog

select OBJECT_NAME([object_id])
from sys.partitions
where hobt_id = 72057594047430656

select * from sys.partitions

select OBJECT_NAME([object_id])
from sys.partitions
where hobt_id = 524288


--deadlocki vea käsitlemine try ja catchiga
alter proc spTransaction1
as begin
	begin tran
	begin try
		update TableA set Name = 'Mark Transaction 1' where Id = 1
		waitfor delay '00:00:05'
		update TableB set Name = 'Mary Transaction 1' where Id = 1

		commit tran
		select 'Transaction Successful'
	end try
	begin catch
		--vaatab, kas error on deadlocki oma
		if(ERROR_NUMBER() = 1205)
		begin
			select 'Deadlock. Transaction failed. Please retry'
		end

		rollback
	end catch
end

--nüüd käivitad esimeses aknas
spTransaction1

alter proc spTransaction2
as begin
	begin tran
	begin try
		update TableB set Name = 'Mark Transaction 2' where Id = 1
		waitfor delay '00:00:05'
		update TableA set Name = 'Mary Transaction 2' where Id = 1

		commit tran
		select 'Transaction Successful'
	end try
	begin catch
		--vaatab, kas error on deadlocki oma
		if(ERROR_NUMBER() = 1205)
		begin
			select 'Deadlock. Transaction failed. Please retry'
		end

		rollback
	end catch
end

--teises serveris käivitad selle koodi
spTransaction2

execute sp_readerrorlog

--blokeerivate päringute leidmine

begin tran
update TableA set Name = 'Mark Transaction 1'
where Id = 1

teise serverisse kirjutame 

select count(*) from TableA
delete from TableA where Id = 1
truncate table TableA
drop table TableA

SELECT
    [s_tst].[session_id],
    [s_es].[login_name] AS [Login Name],
    DB_NAME (s_tdt.database_id) AS [Database],
    [s_tdt].[database_transaction_begin_time] AS [Begin Time],
    [s_tdt].[database_transaction_log_bytes_used] AS [Log Bytes],
    [s_tdt].[database_transaction_log_bytes_reserved] AS [Log Rsvd],
    [s_est].text AS [Last T-SQL Text],
    [s_eqp].[query_plan] AS [Last Plan]
FROM
    sys.dm_tran_database_transactions [s_tdt]
JOIN
    sys.dm_tran_session_transactions [s_tst]
ON
    [s_tst].[transaction_id] = [s_tdt].[transaction_id]
JOIN
    sys.[dm_exec_sessions] [s_es]
ON
    [s_es].[session_id] = [s_tst].[session_id]
JOIN
    sys.dm_exec_connections [s_ec]
ON
    [s_ec].[session_id] = [s_tst].[session_id]
LEFT OUTER JOIN
    sys.dm_exec_requests [s_er]
ON
    [s_er].[session_id] = [s_tst].[session_id]
CROSS APPLY
    sys.dm_exec_sql_text ([s_ec].[most_recent_sql_handle]) AS [s_est]
OUTER APPLY
    sys.dm_exec_query_plan ([s_er].[plan_handle]) AS [s_eqp]
ORDER BY
    [Begin Time] ASC;
GO