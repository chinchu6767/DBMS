create database hospitalmanagmentsystem;
use hospitalmanagmentsystem;

create table patient
( patients_id int primary key ,
patients_name varchar(30),
gender varchar(20),
age varchar(10),
phone_no varchar(20)
);

create table doctors
( doctor_id int primary key,
doctor_name varchar(30),
specialization varchar(50),
phone_no varchar(20));

create table appointments
(appio_id int primary key,
doctor_id int,
patients_id int,
foreign key (doctor_id) references doctors(doctor_id),
foreign key (patients_id) references patient(patients_id),
appoi_date date,
diagnosis varchar(60));

INSERT INTO patient (patients_id,patients_name,gender,age,phone_no)VALUES
(101, 'Ravi', 'M', 25, '9898765432'),
(102, 'Annakka', 'F',30, '9887654321'),
(103, 'Kempanna','M',59, '9876123456'),
(104, 'saramma','F',80,'9867890123');
select * from patient;

INSERT INTO Doctors VALUES
(1, 'Dr. durgappa', 'Cardiology', '9876543210'),
(2, 'Dr. kariyappa', 'Neurology', '9823456712'),
(3, 'Dr. narsamma', 'Dermatology', '9812345678');

select * from doctors;

INSERT INTO appointments VALUES
(1001, 1, 101, '2025-10-20', 'Chest Pain'),
(1002, 1, 102, '2025-10-21', 'Follow-up Check'),
(1003, 2, 103, '2025-10-22', 'Migraine'),
(1004, 3, 104, '2025-10-23', 'Skin Allergy'),
(1005, 1, 103, '2025-10-25', 'Heart Checkup');

select * from appointments;

select a. appio_id,
d.doctor_name,
p.patients_name,
a.appoi_date,
a.diagnosis,
d.specialization
from appointments a
INNER JOIN doctors d on a.doctor_id = d.doctor_id
INNER JOIN patient p on a.patients_id = p.patients_id;


select 
a.appio_id,
p.patients_name,
d.doctor_name,
a.appoi_date,
a.diagnosis
from appointments a
left join doctors d on a.doctor_id = d.doctor_id
left join patient p on a.patients_id = p.patients_id;


select
    a.appio_id,
    d.doctor_name,
    p.patients_name,
    a.appoi_date,
    a.diagnosis
FROM appointment a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id
RIGHT JOIN patient p ON a.patients_id = p.patients_id;



select p.patient , d.doctors , a.appoi_date,a.diagnosis
 from appointment a join patient p on a.patients_id = p.patients_id
 where a.doctor_id = 1;


SELECT 
    D.doctor_name,
    COUNT(A.Patients_ID) AS TotalPatients
FROM Appointment A
JOIN Doctors D ON A.doctor_id = D.doctor_id
GROUP BY D.doctor_name;

DELIMITER $$
create procedure insertappointment (
in app_id int,
in doc_id int,
in pat_id int,
in app_date date,
in diog varchar(20))

BEGIN
    insert into appointment VALUES(app_id,doc_id,pat_id,app_date,diog);
    END $$

    DELIMITER ;
    
    CALL insappointment(1006, 2, 104, '2025-09-24','vomit');

DELIMITER $$

CREATE PROCEDURE UpdateAppointmentDate(
    IN app_id INT,
    IN new_date DATE
)

BEGIN
UPDATE appiontment
set app_date = new_date
where app_id = app_id;
END $$

DELIMITER ;

SELECT * FROM appiontments;













