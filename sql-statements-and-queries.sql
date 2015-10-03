
/* Names: Huyen Nguyen (hbnguyen) & Long Vu (txvu) */
/* Delete all existing tables before starting */
Drop Table Employee cascade constraints;
Drop Table EquipmentType cascade constraints;
Drop Table Equipment cascade constraints;
Drop Table Room cascade constraints;
Drop Table RoomService cascade constraints;
Drop Table RoomAccess cascade constraints;
Drop Table Patient cascade constraints;
Drop Table Doctor cascade constraints;
Drop Table Admission cascade constraints;
Drop Table Examine cascade constraints;
Drop Table StayIn cascade constraints;
/* Drop all existing views */
Drop View CriticalCases;
Drop View DoctorsLoad;
/* Now create the tables */
Create table Employee 
( employeeID char(20) primary key,
fName varchar2(20),
lName varchar2(20),
salary real,
jobTitle varchar2(20),
officeNum int,
empRank varchar2(20),
supervisorID char(20),
constraint fk_employee_sid foreign key (supervisorID) references Employee(employeeID)
);
create table EquipmentType
(typeID char(20) primary key,
description varchar2(50),
model varchar2(20),
instructions varchar2(60)
);
create table Equipment
(serialNum varchar2(20) primary key,
typeID char(20),
purchaseYear int,
lastInspection date,
roomNum int,
constraint fk_equipment_tid foreign key (typeID) references EquipmentType(typeID)
);
create table Room
(roomNum int primary key,
occupiedFlag varchar2(1)
);
alter table Equipment
add constraint fk_equipment_rn foreign key (roomNum) references Room(roomNum);
create table RoomService
(roomNum int,
roomService varchar2(30),
constraint pk_roomservice primary key (roomNum, roomService),
constraint fk_roomservice foreign key (roomNum) references Room(roomNum)
);
create table RoomAccess
(roomNum int,
employeeID char(20),
constraint pk_roomaccess primary key (roomNum, employeeID),
constraint fk_roomaccess_rn foreign key (roomNum) references Room(roomNum),
constraint fk_roomaccess_eid foreign key (employeeID) references Employee(employeeID)
);
create table Patient
(SSN int primary key,
fName varchar2(20),
lName varchar2(20),
address varchar2(50),
telNum int
);
create table Doctor
(doctorID char(20) primary key,
gender varchar2(6),
specialty varchar2(50),
lName varchar2(20),
fName varchar2(20)
);
create table Admission
(admissionNum int primary key,
admissionDate date,
leaveDate date,
totalPayment real,
insurancePayment real,
patientSSN int,
futureVisit date,
constraint fk_admission_pssn foreign key (patientSSN) references Patient(SSN)
);
create table Examine
(doctorID char(20),
admissionNum int,
doctorComment varchar2(50),
constraint pk_examine primary key (doctorID, admissionNum),
constraint fk_examine_did foreign key (doctorID) references Doctor(doctorID),
constraint fk_examine_an foreign key (admissionNum) references Admission(admissionNum)
);
create table StayIn
(admissionNum int,
roomNum int,
startDate date,
endDate date,
constraint pk_stayin primary key (admissionNum, roomNum, startDate),
constraint fk_stayin_an foreign key (admissionNum) references Admission(admissionNum),
constraint fk_stayin_rn foreign key (roomNum) references Room(roomNum)
);
/* Insert 10 patients */
Insert into Patient values (111223333, 'John', 'Smith', 'MA', 111);
Insert into Patient values (101227333, 'Kelly', 'Jones', 'WA', 112); 
Insert into Patient values (101327353, 'Nicholas', 'Baker', 'CA', 113); 
Insert into Patient values (101222333, 'Natalie', 'White', 'AZ', 114); 
Insert into Patient values (301227333, 'Mike', 'Walker', 'MI', 115); 
Insert into Patient values (901227333, 'Albert', 'Nelson', 'NY', 116); 
Insert into Patient values (401227333, 'Clark', 'Hernandez', 'IL', 117); 
Insert into Patient values (701257333, 'John', 'Parker', 'CA', 118); 
Insert into Patient values (121227333, 'Hannah', 'Wright', 'TX', 119); 
Insert into Patient values (171227333, 'Kim', 'Stewart', 'OR', 120); 
/* Insert 10 doctors */
insert into doctor values (12345678912345678900, 'Female', 'Anesthesia', 'Campbell', 'Celia');
insert into doctor values (98765432198765432100, 'Male', 'Dermatology', 'Adam', 'Gonzalez'); 
insert into doctor values (12345678912345678800, 'Female', 'Allergy', 'Lisa', 'Turner');
insert into doctor values (14587365214789545515, 'Male', 'Neonatology', 'Jonathan', 'Scott');
insert into doctor values (78954125746855636851, 'Female', 'Neurology', 'Lydia', 'Hill');
insert into doctor values (27765446348764354154, 'Male', 'Pathology', 'Mitch', 'Thompson');
insert into doctor values (54657886766541354546, 'Female', 'Pediatrics', 'Alecia', 'King');
insert into doctor values (54878465415467465465, 'Male', 'Psychiatry', 'Mark', 'Parker');
insert into doctor values (78977453415346545344, 'Female', 'Radiology', 'Clare', 'Danes');
insert into doctor values (52679787543514341654, 'Male', 'Neurology', 'Connor', 'Wilson');
/* Insert 10 rooms */
insert into room values (1000, 'n');
insert into room values (1001, 'y');
insert into room values (1002, 'n');
insert into room values (1003, 'y');
insert into room values (1004, 'n');
insert into room values (1005, 'y');
insert into room values (1006, 'n');
insert into room values (1007, 'n');
insert into room values (1008, 'n');
insert into room values (1009, 'n');
/* Insert RoomService (14 entries) */
insert into roomservice values (1000, 'Dining');
insert into roomservice values (1000, 'Intensive care');
insert into roomservice values (1001, 'Maternity');
insert into roomservice values (1001, 'Intensive care');
insert into roomservice values (1002, 'Nursing');
insert into roomservice values (1002, 'Surgery');
insert into roomservice values (1001, 'Surgery');
insert into roomservice values (1003, 'Pharmacy');
insert into roomservice values (1004, 'Pediatric services');
insert into roomservice values (1005, 'Physical therapy');
insert into roomservice values (1006, 'Nursing');
insert into roomservice values (1007, 'Surgery');
insert into roomservice values (1008, 'Intensive care');
insert into roomservice values (1009, 'Dining');
/* Insert 3 equipment types */
insert into equipmenttype values (12345678912345678900, 'STethosopes', 'A01-02X', 'Hear sounds from movement within the body');
insert into equipmenttype values (54657687435447674676, 'Bedpan', 'A01-02X', 'For patients who are unconscious or too weak');
insert into equipmenttype values (45453445456465434578, 'Gas cylinder', '3232', 'Sypply of oxygen, carbon dioxide, etc.');
insert into equipmenttype values (45454353535657869871, 'MRI', '35543', 'Scan');
/* Insert 3 equipment units for each type */
insert into equipment values ('A01-02X', 12345678912345678900, 2000, '01-Jan-2000', 1000);
insert into equipment values ('112', 12345678912345678900, 2010, '08-May-2011', 1004);
insert into equipment values ('113', 12345678912345678900, 2011, '09-Jun-2012', 1001);
insert into equipment values ('114', 12345678912345678900, 2011, '09-Jun-2012', 1007);
insert into equipment values ('115', 54657687435447674676, 2010, '13-Aug-2014', 1006);
insert into equipment values ('116', 54657687435447674676, 2011, '23-Feb-2013', 1005);
insert into equipment values ('117', 54657687435447674676, 2014, '01-Jan-2015', 1008);
insert into equipment values ('118', 45453445456465434578, 2013, '02-Feb-2015', 1009);
insert into equipment values ('119', 45453445456465434578, 2011, '08-Nov-2014', 1003);
insert into equipment values ('120', 45453445456465434578, 2010,'07-Dec-2012', 1002);
insert into equipment values ('121', 45454353535657869871, 2003, '08-May-2011', 1004);
/* Insert Admission */
insert into admission values (1, '01-Jan-2010', '05-Jan-2010', 1000, 700, 101327353, '07-Jul-2010');
insert into admission values (2, '03-Mar-2010', '10-Mar-2010', 2000, 1500, 101327353, '08-Aug-2010');
insert into admission values (3, '05-May-2008', '10-May-2008', 500, 300, 111223333, NULL);
insert into admission values (4, '07-Aug-2009', '15-Aug-2009', 1700, 1400, 111223333, '08-Nov-2009');
insert into admission values (5, '03-Aug-2012', '10-Aug-2012', 2000, 1500, 101227333, '10-Nov-2012');
insert into admission values (6, '12-Jun-2013', '20-Jun-2103', 3000, 0, 101227333, '15-Nov-2013');
insert into admission values (8, '15-Apr-2013', '30-Apr-2013', 5000, 4500, 101222333, '10-Nov-2013');
insert into admission values (7, '01-Jan-2012', '10-Jan-2012', 3000, 300, 101222333, '01-Feb-2012');
insert into admission values (10, '03-Apr-2008', '10-Apr-2008', 7000, 6000, 301227333, '10-Aug-2008');
insert into admission values (9, '05-May-2007', '20-May-2007', 4000, 3000, 301227333, '05-Nov-2007');
insert into admission values (11, '07-Jul-2014', '25-Aug-2014', 10000, 0, 901227333, NULL);
insert into admission values (12, '07-Jul-2005', '25-Aug-2005', 10000, 0, 401227333, NULL);
insert into admission values (13, '05-Oct-2010', '15-Oct-2010', 1700, 1400, 111223333, '05-Dec-2010');
/* Insert 2 general managers */
insert into employee values (100, 'Bacon', 'Francis', 1000, 'Unit manager', '2', 'General manager', NULL);
insert into employee values (200, 'Bach', 'Richard', 1000, 'Unit manager', '2', 'General manager', NULL);
/* Insert 4 division managers */
insert into employee values (10, 'Ba', 'Jin', 200, 'Employee Manager', '1', 'Division manager', 100);
insert into employee values (20, 'Baba', 'Meher', 200, 'Employee Manager', '1', 'Division manager', 200);
insert into employee values (30, 'Bacon', 'Francis', 200, 'Employee Manager', '1', 'Division manager', 200);
insert into employee values (40, 'Bach', 'Richard', 200, 'Employee Manager', '1', 'Division manager', 100);
insert into employee values (50, 'Will', 'Smith', 200, 'Employee Manager', '1', 'Division manager', 100);
/* Insert 10 Regular employees */
insert into employee values (1, 'Aaron', 'Hank', 100, 'PR employee', '0', 'Regular employee', 10);
insert into employee values (2, 'Abbey', 'Edward', 100, 'PR employee', '0', 'Regular employee', 10);
insert into employee values (3, 'Abel', 'Reuben', 100, 'PR employee', 0, 'Regular employee', 20);
insert into employee values (4, 'Abelson', 'Hal', 100, 'Product employee', '0', 'Regular employee', 30);
insert into employee values (5, 'Ace', 'Jane', 100, 'Product employee', '0', 'Regular employee', 40);
insert into employee values (6, 'Adams', 'Abigail', 100, 'Product employee', '0', 'Regular employee', 10);
insert into employee values (7, 'Adams', 'John', 100, 'Marketing employee', '0', 'Regular employee', 20);
insert into employee values (8, 'Adler', 'Alfred', 100, 'Marketing employee', '0', 'Regular employee', 30);
insert into employee values (9, 'Aaron', 'Hank', 100, 'Marketing employee', '0', 'Regular employee', 30);
insert into employee values (11, 'Addison', 'Joseph', 100, 'Toilet cleaner', '0', 'Regular employee', 20);
/* Insert RoomAccess data */
insert into roomaccess values (1000, 1);
insert into roomaccess values (1001, 1);
insert into roomaccess values (1002, 1);
insert into roomaccess values (1003, 1);
insert into roomaccess values (1001, 2);
insert into roomaccess values (1000, 2);
insert into roomaccess values (1002, 2);
insert into roomaccess values (1003, 2);
insert into roomaccess values (1008, 3);
/* Insert Examine data */
insert into examine values (12345678912345678900, 4, 'So sick');
insert into examine values (98765432198765432100, 4, 'So sick');
insert into examine values (12345678912345678800, 4, 'Normal');
insert into examine values (12345678912345678800, 3, 'Normal');
insert into examine values (12345678912345678800, 2, 'Normal');
insert into examine values (52679787543514341654, 2, 'Normal');
insert into examine values (12345678912345678800, 5, 'Normal');
insert into examine values (12345678912345678800, 6, 'Normal');
insert into examine values (12345678912345678800, 7, 'Normal');
insert into examine values (12345678912345678800, 8, 'Normal');
insert into examine values (12345678912345678800, 9, 'Normal');
insert into examine values (12345678912345678800, 10, 'Normal');
insert into examine values (12345678912345678800, 11, 'Normal');
insert into examine values (12345678912345678800, 12, 'Normal');
insert into examine values (12345678912345678900, 12, 'Surgery required');
insert into examine values (12345678912345678800, 13, 'Normal');
/* Insert StayIn */
insert into stayin values (1, 1000, '01-Jan-2010', '05-Jan-2010');
insert into stayin values (2, 1000, '03-Mar-2010', '04-Mar-2010');
insert into stayin values (2, 1001, '04-Mar-2010', '05-Mar-2010');   
insert into stayin values (2, 1008, '05-Mar-2010', '06-Mar-2010');
insert into stayin values (2, 1001, '06-Mar-2010', '07-Mar-2010');
insert into stayin values (2, 1001, '07-Mar-2010', '10-Mar-2010');            
/* q1: report the rooms (the room number) that are currently occupied. */
select roomNum
from Room
where occupiedFlag = 'Y' 
Or occupiedFlag = 'y';
/* q2: For a given division manager (say, ID = 10), report all Regular employees that are supervised by this manager. Display the employees ID, names, and salary. */
select employeeID, fName, lName, salary
from Employee
where supervisorID = 10;
/* q3: For each patient, report the sum of amounts paid by the insurance company for that patient, i.e., report the patients SSN, and the sum of insurance payments over all visits */
select patientSSN, sum(insurancePayment) AS insuranceSum
from Admission
group by patientSSN;
/* q4: Report the number of visits done for each patient, i.e., for each patient, report the patient SSN, first and last names, and the count of visits done by this patient. */
select P.SSN, P.fName, P.lName, count(admissionNum) as visitCount
from Patient P, Admission A
where P.SSN = A.patientSSN
group by P.SSN, P.fName, P.lName;
/* q5: Report the room number that has an equipment unit with serial number 'A01-02X'. */
select roomNum
from Equipment
where serialNum = 'A01-02X';
/* q6: Report the employee who has access to the largest number of rooms. We need the employee ID, and the number of rooms (s)he can access. */
select employeeID, count(roomNum) AS roomNumCount
from RoomAccess
group by employeeID
having count(roomNum) = (select max(roomCount) from (select count(roomNum) AS roomCount from RoomAccess group by employeeID) C
);
/* q7: Report the number of Regular employees, division managers, and general
managers in the hospital. */
select empRank AS Type, count(*) AS Count
from Employee
group by empRank;
/* Q8: For patients who have a scheduled future visit (which is part of their most recent visit), report that patient (SSN, and first and last names) and the visit date. */
select SSN, fName, lName, futureVisit 
from Patient P, Admission A, (select patientSSN, max(admissionNum) as mostRecent from Admission group by patientSSN) M
where P.SSN = A.patientSSN
AND A.patientSSN = M.patientSSN
AND A.admissionNum = M.mostRecent
AND A.futureVisit IS NOT NULL;
/* q9: For each equipment type that has more than 3 units, report the equipment type ID, model, and the number of units this type has. */
select T.typeID, T.model, UC.unitCount
from EquipmentType T, (select typeID, count(*) as unitCount from Equipment group by typeID having count(*) > 3) UC
where T.typeID = UC.typeID;
/* q10: Report the date of the coming future visit for patient with SSN = 111-22-3333. */
select A.futureVisit
from Admission A, (select max(admissionNum) AS adNumMax from Admission where patientSSN = 111223333) M
where A.admissionNum = M.adNumMax;
/* q11: For patient with SSN = 111-22-3333, report the doctors (only ID) who have examined this patient more than 2 times. */
select doctorID
from Admission A, Examine E
where A.patientSSN = '111223333'
AND A.admissionNum = E.admissionNum
group by doctorID
having count(E.admissionNum) > 2;
/* q12: Report the equipment types (only the ID) for which the hospital has purchased equipments (units) in both 2010 and 2011. Do not report duplication. */
(select Distinct typeID
from Equipment
where purchaseYear = 2010)
intersect
(select Distinct typeID
from Equipment
where purchaseYear = 2011);
/* PHASE 3 */
/* Part 1 */
/* Create CriticalCases view */
/* If a patient is admitted to the Intensive care twice in the same admission, it still counts */
create view CriticalCases as
select P.SSN as patientSSN, P.fName, P.lName, count(*) as numberOfAdmissionsToICU
from Admission A, Patient P, 
	(select admissionNum
	from StayIn S, 
		(select roomNum 
		from RoomService 
		where roomService = 'Intensive care') RS
	where S.roomNum = RS.roomNum) AD
where A.patientSSN = P.SSN 
AND A.admissionNum = AD.admissionNum
group by P.SSN, P.fName, P.lName
having count(*) >= 2;
/* Create DoctorsLoad view */
create view DoctorsLoad as
(select D.doctorID, D.gender, 'Overloaded' as load
from Doctor D, 
	(select doctorID
	from Examine
	group by doctorID
	having count(*) > 10) DA
where D.doctorID = DA.doctorID)
union
(select doctorID, gender, 'Underloaded' as load
from Doctor D
where D.doctorID not in (select doctorID
from Examine
group by doctorID
having count(*) > 10));
/* Report critical-cases patients with number of admissions to ICU greater than 4 */
select *
from CriticalCases
Where numberOfAdmissionsToICU > 4;
/* Report female overloaded doctors */
select doctorID, fName, lName
from Doctor D
where D.doctorID in 
(select doctorID 
from DoctorsLoad 
where gender = 'Female' 
AND load = 'Overloaded');
/* Report comments inserted by underloaded doctors when examining critical-cases patients */
select E.doctorID, A.patientSSN, E.doctorComment
from Examine E, Admission A
where E.admissionNum = A.admissionNum 
AND E.doctorID in 
(select doctorID 
from DoctorsLoad 
where load = 'Underloaded') 
and A.patientSSN in 
(select patientSSN 
from CriticalCases);
/* Part 2*/
/* Any room in the hospital cannot offer more than 3 services */
create or replace trigger MaxServices
before insert or update of roomNum on RoomService
for each row
declare
	numOfService int;
begin
	select count(*) into numOfService 
	from RoomService 
	where roomNum = :new.roomNum;
	if numOfService > 2 then
		RAISE_APPLICATION_ERROR(-20004, 'Cannot insert record.');
end if;
end;
/
/* Insurance payment is calculated automatically as 70% of the total payment */
create or replace trigger InsurancePayment
before insert or update of totalPayment on Admission
for each row
begin
	:new.insurancePayment := :new.totalPayment * 0.7;
end;
/
/* Ensure that regular employees (with rank 0) must have their 
supervisors as division managers (with rank 1). Also each regular 
employee must have a supervisor at all times.
Sinmilarly for division manager */
create or replace trigger SupervisorCheck
before insert or update on Employee
for each row
declare
	supervisorRank int;
begin
	if :new.empRank = 0 then
		if (:new.supervisorID is null) then
			RAISE_APPLICATION_ERROR(-20004, 'Must enter ID of supervisor');
		else
			select empRank into supervisorRank 
			from Employee 
			where employeeID = :new.supervisorID;
			if (supervisorRank <> 1) then
				RAISE_APPLICATION_ERROR(-20004, 'Incorrect input of supervisor ID');
			end if;
		end if;
	end if;
	if :new.empRank = 1 then
		if (:new.supervisorID is null) then
			RAISE_APPLICATION_ERROR(-20004, 'Must enter ID of supervisor');
		else
			select empRank into supervisorRank 
			from Employee 
			where employeeID = :new.supervisorID;
			if (supervisorRank <> 2) then
				RAISE_APPLICATION_ERROR(-20004, 'Incorrect input of supervisor ID');
			end if;
		end if;
	end if;
end;
/
/* When a patient is admitted to ICU room on date D, set the
future visit date to be 3 months after D */
create or replace trigger ICUFutureVisit
before insert on StayIn
for each row
declare 
	roomNumber int;
begin
	select roomNum into roomNumber
	from RoomService
	where roomService = 'Intensive care';
	if :new.roomNum = roomNumber then
		update Admission 
		set futureVisit = add_months(admissionDate, 3) 
		where admissionNum = :new.admissionNum;
	end if;
end;
/
/* If an equipment is of type MRI, then the purchase year is not null
and after 2005 */
create or replace trigger MRIdate
before insert or update on Equipment
for each row
declare 
	equipmentID int;
begin
	select typeID into equipmentID 
	from EquipmentType
	where description = 'MRI';
	if :new.typeID = equipmentID then
		if (:new.purchaseYear <= 2005 or :new.purchaseyear = null) then
			raise_application_error(-2003, 'Incorrect purchase year');
		end if;
	end if;
end;
/
/*
create or replace trigger MRIEquipment
before insert or update on Equipment
for each row
where new.typeID = ‘MRI’
begin
	if (:new.purchaseYear is null or :new.purchaseYear < 2005) then
		RAISE_APPLICATION_ERROR(-20004, ‘Incorrect purchase year’);
	end if;
end;
/
*/
create or replace trigger newAdmission
before insert on Admission
for each row
declare
	firstName varchar2(20);
	lastName varchar2(20);
	cursor c1(newSSN int) is 
	select doctorID 
	from Examine 
	where admissionNum in 
		(select admissionNum 
		from Admission 
		where patientSSN = newSSN);
begin
	for rec in c1(:new.patientSSN) loop
		select fName, lName into firstName, lastName 
		from Doctor 
		where doctorID = rec.doctorID;
		dbms_output.put_line('Doctor name: ' || firstName || ' ' || lastName);
	end loop;
	EXCEPTION
		when others then
			raise_application_error(-200002, 'Cannot find data');
end;
/






























