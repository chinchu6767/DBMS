-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: 
-- USN: 
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- 'root@localhost', 'RVU-PC-013', '8.4.6', '2025-08-18 06:09:35'

-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:
create database BCAlab1;
use BCAlab1;
-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth
create table students
( studentID varchar(20) primary key,
  firstName varchar(30),
  lastName varchar(20),
  email varchar(20) UNIQUE,
  DOB   date 
  );
  desc students;

-- Write your SQL query below Codespace:

DESC STUDENTS; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
/*'studentID', 'varchar(20)', 'NO', 'PRI', NULL, ''
'firstName', 'varchar(30)', 'YES', '', NULL, ''
'lastName', 'varchar(20)', 'YES', '', NULL, ''
'email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DOB', 'date', 'YES', '', NULL, ''*/


-- Alter the table and 2 new columns
alter table students add (gender char(20),
                          age int);     
desc students;  
     
-- Modify a column data type
alter table students modify firstname varchar(35);
desc students;

-- Rename a column
alter table students rename column lastName to Surname; 
desc students;

-- Drop a column
alter table students drop column age; 
desc students;
-- Rename the table
alter table students rename to StudentsDetails;

desc StudentsDetails;

-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits
create table Courses ( CourseID varchar(20) primary key,
                       CourseName char(30),
                       credits int );
desc Courses;


-- Write your SQL query below codespace:

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- OUTPUT :
/*'CourseID', 'varchar(20)', 'NO', 'PRI', NULL, ''
'CourseName', 'char(30)', 'YES', '', NULL, ''
'credits', 'int', 'YES', '', NULL, ''*/

-- Alter the table and 2 new columns
alter table Courses add (lecture char(20),
						 marks int);  
 desc Courses;                        
-- Modify a column data type
alter table Courses modify CourseID varchar(25);
 desc Courses;
-- Rename a column
alter table Courses rename column CourseID to CourseCode;
desc Courses;
-- Drop a column
alter table Courses drop column CoursesCode;
desc Courses;
-- Rename the table
alter table Courses rename to courseDetails;
desc courseDetails;


-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - 
CREATE TABLE StudentsDetails (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE CourseDetails (
    CourseCode INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

-- Write your SQL query below Codespace:
CREATE TABLE Enrollment (
   EnrollmentID INT PRIMARY KEY,
   StudentID INT,
   CourseID INT,
   EnrollmentDate DATE,
   FOREIGN KEY (StudentID) REFERENCES StudentsDetails(StudentID),
   FOREIGN KEY (CourseID) REFERENCES courseDetails(CourseCode)
);
desc Enrollment;

DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT : 
/*'EnrollmentID', 'int', 'NO', 'PRI', NULL, ''
'StudentID', 'int', 'YES', 'MUL', NULL, ''
'CourseID', 'int', 'YES', 'MUL', NULL, ''
'EnrollmentDate', 'date', 'YES', '', NULL, ''*/


-- Alter the table and 2 new columns
alter table Enrollment add ( EnrollmentName varchar(20),
                             EnrollmentTime varchar(20)
							);
desc Enrollment;
-- Modify a column data type
alter table Enrollment modify EnrollmentName varchar(25);
desc Enrollment;
-- Rename a column
alter table Enrollment rename column CourseID to CourseCode;
desc Enrollment;

-- Drop a column
alter table Enrollment drop column EnrollmentDate;
desc Enrollment;
-- Rename the table
alter table Enrollment rename to EnrollmentDetails;
desc EnrollmentDetails;


-- Task 4: Alter the Students Table
-- Add a column 'PhoneNumber' to store student contact numbers.

-- Write your SQL query below Codespace:

DESC STUDENTS; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]

-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.
-- Write your SQL query below Codespace:

-- Task 6: Drop Tables

SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:

SHOW TABLES; -- After dropping the table Enrollement and Course

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01
