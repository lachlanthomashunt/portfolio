-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lachlan
-- -----------------------------------------------------
-- CREATE DATABASE lachlandb;
-- -----------------------------------------------------
-- Schema lachlan
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS lachlandb;
CREATE SCHEMA IF NOT EXISTS lachlandb DEFAULT CHARACTER SET utf8 ;
USE lachlandb ;

-- -----------------------------------------------------
-- Table School
-- -----------------------------------------------------
DROP TABLE IF EXISTS School;
CREATE TABLE IF NOT EXISTS School (
  `SchoolName` INT NOT NULL,
  `SchoolContactNo` VARCHAR(45) NULL,
  `SchoolEmail` VARCHAR(45) NULL,
  `SchoolAddress` VARCHAR(45) NULL,
  PRIMARY KEY (`SchoolName`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table Student
-- -----------------------------------------------------
DROP TABLE IF EXISTS Student;
CREATE TABLE IF NOT EXISTS Student (
  `StudentID` INT NOT NULL,
  `StudentContactNum` VARCHAR(10) NULL,
  `StudentDateofBirth` DATE NOT NULL,
  `StudentDateofCampusEnrolment` DATE NULL,
  `StudentEmail` VARCHAR(45) NULL,
  `StudentFirstName` VARCHAR(45) NOT NULL,
  `StudentLastName` VARCHAR(45) NOT NULL,
  `StudentGender` ENUM('M', 'F') NOT NULL,
  `StudentNationality` VARCHAR(45) NOT NULL,
  `SchoolName` INT NOT NULL,
  PRIMARY KEY (`StudentID`),
  INDEX `fk_Student_School1_idx` (`SchoolName` ASC) VISIBLE,
  CONSTRAINT `fk_Student_School1`
    FOREIGN KEY (`SchoolName`)
    REFERENCES lachlandb. School (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Teacher
-- -----------------------------------------------------
DROP TABLE IF EXISTS Teacher;
CREATE TABLE IF NOT EXISTS Teacher (
  `TeacherID` INT NOT NULL,
  `TeacherFirstName` VARCHAR(45) NOT NULL,
  `TeacherLastName` VARCHAR(45) NOT NULL,
  `TeacherEmail` VARCHAR(45) NULL,
  `TeacherPhone` VARCHAR(10) NULL,
  `SchoolName` INT NOT NULL,
  PRIMARY KEY (`TeacherID`),
  INDEX `fk_Teacher_School1_idx` (`SchoolName` ASC) VISIBLE,
  CONSTRAINT `fk_Teacher_School1`
    FOREIGN KEY (`SchoolName`)
    REFERENCES lachlandb.School (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Subject
-- -----------------------------------------------------
DROP TABLE IF EXISTS Subject;
CREATE TABLE IF NOT EXISTS Subject (
  `SubjectName` VARCHAR(4) NOT NULL,
  `SubjectCost` DECIMAL(5,2) NULL,
  `SubjectDurationinHours` INT NULL,
  `SubjectCoordinator` VARCHAR(45) NULL,
  `SubjectDescription` VARCHAR(45) NULL,
  `QuantityofAssessmentItems` INT NULL,
  `TeacherID` INT NOT NULL,
  PRIMARY KEY (`SubjectName`),
  INDEX `fk_Subject_Teacher1_idx` (`TeacherID` ASC) VISIBLE,
  CONSTRAINT `fk_Subject_Teacher1`
    FOREIGN KEY (`TeacherID`)
    REFERENCES lachlandb.Teacher (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Enrolment
-- -----------------------------------------------------
DROP TABLE IF EXISTS Enrolment;
CREATE TABLE IF NOT EXISTS Enrolment (
  `StudentID` INT NOT NULL,
  `SubjectName` VARCHAR(4) NOT NULL,
  `Grade` ENUM('PASS', 'FAIL', 'DIST', 'CRED', 'WTDR') NULL,
  `StudentResult` INT(3) NULL,
  `DateGradeResult` DATE NULL,
  `StudentDateofSubjectEnrolment` DATE NULL,
  PRIMARY KEY (`StudentID`, `SubjectName`),
  INDEX `fk_Enrolment_Subject1_idx` (`SubjectName` ASC) VISIBLE,
  CONSTRAINT `fk_Enrolment_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES lachlandb.Student (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Enrolment_Subject1`
    FOREIGN KEY (`SubjectName`)
    REFERENCES lachlandb.Subject (`SubjectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Populate School with data
-- -----------------------------------------------------

INSERT INTO School (SchoolName, SchoolContactNo, SchoolEmail, SchoolAddress)
VALUES (4004,82626442,'school@tafe.edu.au','1 School street');

SELECT * FROM School;

-- -----------------------------------------------------
-- Populate Student with data
-- -----------------------------------------------------

INSERT INTO Student (StudentID, StudentContactNum, StudentDateofBirth, StudentDateofCampusEnrolment, StudentEmail, StudentFirstName, StudentLastName, StudentGender, StudentNationality, SchoolName)
VALUES (100884664,0400000001,'1992-05-29','2019-02-19','lachlan.hunt@tafesa.edu.au','Lachlan','Hunt','M','Australian', 4004);

INSERT INTO Student (StudentID, StudentContactNum, StudentDateofBirth, StudentDateofCampusEnrolment, StudentEmail, StudentFirstName, StudentLastName, StudentGender, StudentNationality, SchoolName)
VALUES (100000001,0400000002,'1991-09-11','2019-02-19','joe.bloggs@tafesa.edu.au','Joe','Bloggs','M','Australian', 4004);

INSERT INTO Student (StudentID, StudentContactNum, StudentDateofBirth, StudentDateofCampusEnrolment, StudentEmail, StudentFirstName, StudentLastName, StudentGender, StudentNationality, SchoolName)
VALUES (100000002,0400000003,'1990-11-08','2019-02-19','jessica.smith@tafesa.edu.au','Jessica','Smith','F','Australian', 4004);

INSERT INTO Student (StudentID, StudentContactNum, StudentDateofBirth, StudentDateofCampusEnrolment, StudentEmail, StudentFirstName, StudentLastName, StudentGender, StudentNationality, SchoolName)
VALUES (100000003,0400000004,'1989-05-07','2019-02-19','john.smith@tafesa.edu.au','John','Smith','M','Australian', 4004);

INSERT INTO Student (StudentID, StudentContactNum, StudentDateofBirth, StudentDateofCampusEnrolment, StudentEmail, StudentFirstName, StudentLastName, StudentGender, StudentNationality, SchoolName)
VALUES (100000004,0400000005,'1970-08-16','2019-02-19','rose.white@tafesa.edu.au','Rose','White','F','Australian', 4004);

SELECT * FROM Student;

-- -----------------------------------------------------
-- Populate Teacher with data
-- -----------------------------------------------------

INSERT INTO Teacher (TeacherID, TeacherFirstName, TeacherLastName, TeacherEmail, TeacherPhone, SchoolName)
VALUES (2000,'Tim','Brown','tim.brown@tafesa.edu.au','0400000006', 4004);

INSERT INTO Teacher (TeacherID, TeacherFirstName, TeacherLastName, TeacherEmail, TeacherPhone, SchoolName)
VALUES (2001,'James','White','james.white@tafesa.edu.au','0400000007', 4004);

INSERT INTO Teacher (TeacherID, TeacherFirstName, TeacherLastName, TeacherEmail, TeacherPhone, SchoolName)
VALUES (2002,'Mary','Smith', 'mary.smith@tafesa.edu.au','0400000008',4004);

SELECT * FROM Teacher;

-- -----------------------------------------------------
-- Populate Subject with data
-- -----------------------------------------------------

INSERT INTO Subject (SubjectName, SubjectCost, SubjectDurationinHours, SubjectCoordinator, SubjectDescription, QuantityofAssessmentItems, TeacherID)
VALUES ('4DBB',350.00,20,2000,'Apply structured query language to data',6,2000);

INSERT INTO Subject (SubjectName, SubjectCost, SubjectDurationinHours, SubjectCoordinator, SubjectDescription, QuantityofAssessmentItems, TeacherID)
VALUES ('4PHP',340.00,22,2000,'Produce server-side script for web pages',8,2000);

INSERT INTO Subject (SubjectName, SubjectCost, SubjectDurationinHours, SubjectCoordinator, SubjectDescription, QuantityofAssessmentItems, TeacherID)
VALUES ('4SEO',180.00,22,2001,'Analyse information and assign meta tags',5,2001);

INSERT INTO Subject (SubjectName, SubjectCost, SubjectDurationinHours, SubjectCoordinator, SubjectDescription, QuantityofAssessmentItems, TeacherID)
VALUES ('4JSB',320.00,20,2001,'Automate processes',4,2001);

INSERT INTO Subject (SubjectName, SubjectCost, SubjectDurationinHours, SubjectCoordinator, SubjectDescription, QuantityofAssessmentItems, TeacherID)
VALUES ('4CEP',120.00,16,2002,'Contribute to copyright ethics and privacy',4,2002);

SELECT * FROM Subject;

-- -----------------------------------------------------
-- Populate Enrolment with data
-- -----------------------------------------------------

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100884664,'4PHP','DIST', 99, '2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100884664,'4SEO','PASS', 60, '2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100884664,'4DBB','CRED', 70, '2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000001,'4CEP','WTDR', 0, '2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000001,'4JSB','FAIL', 0,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000001,'4PHP','PASS', 60,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000002,'4SEO','DIST', 99,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000002,'4DBB','WTDR', 0,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000002,'4CEP','CRED', 70,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000003,'4JSB','FAIL', 0,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000003,'4PHP','WTDR', 0,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000003,'4SEO','CRED', 70,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000004,'4DBB','CRED', 75,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000004,'4CEP','PASS', 60,'2019-11-29', '2019-02-20');

INSERT INTO Enrolment (StudentID, SubjectName, Grade, StudentResult, DateGradeResult, StudentDateofSubjectEnrolment)
VALUES (100000004,'4JSB','DIST', 89,'2019-11-29', '2019-02-20');

SELECT * FROM Enrolment;

-- -----------------------------------------------------
-- Results of a Student
-- -----------------------------------------------------

SELECT Student.StudentID, CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', Subject.SubjectName, Subject.SubjectDescription, Enrolment.StudentResult, Enrolment.Grade  
FROM Student 
INNER JOIN Enrolment 
ON Student.StudentID = Enrolment.StudentID 
INNER JOIN Subject 
ON Subject.SubjectName = Enrolment.SubjectName
WHERE Student.StudentID = 100884664 -- To change this query to select data for another student, the value after the WHERE clause should be changed to the StudentID of another student from the Student table.
ORDER BY Student.StudentID;

-- -----------------------------------------------------
-- Grades in a Subject
-- -----------------------------------------------------

SELECT Subject.SubjectName, CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', Enrolment.StudentResult, Enrolment.Grade
FROM Student 
INNER JOIN Enrolment 
ON Student.StudentID = Enrolment.StudentID 
INNER JOIN Subject 
ON Subject.SubjectName = Enrolment.SubjectName
WHERE Subject.SubjectName = '4DBB' -- To change this query to select data for another subject, the value after the WHERE clause should be changed to the SubjectName of another subject from the Subject table.
ORDER BY Enrolment.StudentResult DESC;

-- -----------------------------------------------------
-- Age of Student
-- -----------------------------------------------------

-- The following script was developed through researching Date Calculations for MySQL.

-- Identify query development source
-- Site visited : <https://dev.mysql.com/doc/refman/8.0/en/date-calculations.html> 

-- Query Demonstration
-- MySQL.com provides a formula using the TIMESTAMPDIFF function to calculate the difference between 2 time stamps.
-- For context, the query first Selects the Student's Name from the student table using a contatonation of the StudentFirstName and StudentLastName columns.
-- The TIMESTAMPDIFF function is then called. It first requires the date_format relevant to the difference calculation (in this case years).
-- The function then requires 2 variables to calculate their difference. The Student's birthday from the student table and the current year (from the CURDATE() function) is provided, which provides the current time acording to the user's machine in years.
-- The function calculates the difference between these 2 variables as a day by day fraction of a year. This means the function can avoid the trap of simply outputting the student's age after their next birthday as a CURRENT YEAR - BIRTH YEAR calculation would.
-- The function finally outputs an integer (which is the age of the student) under the alias 'Student Age'.

SELECT CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', TIMESTAMPDIFF(YEAR,Student.StudentDateofBirth,CURDATE()) AS 'Student Age'
FROM Student
WHERE Student.StudentID = '100884664';

-- Query Sample Data of Age near Submission Date
-- In the above query, the birthday of the student with the StudentID '100884664' is one the day of submission for this assignment.
-- The query outputs 27 years as their age which is accurate, not 28, even though (2020 - 1992) = 28.

-- Test Confirmation
-- Testing of this query involved running script that would calculate the ages of all the students in the course and testing for errors.
-- The script was as follows :

-- SELECT CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', TIMESTAMPDIFF(YEAR,Student.StudentDateofBirth,CURDATE()) AS 'Student Age'
-- FROM Student;

-- All ages returned a correct result.

-- Explanation of how to change for a different student
-- To change this query to select data for another student, the value after the WHERE clause should be changed to the StudentID of another student from the Student table.

-- -----------------------------------------------------
-- Highest Result
-- -----------------------------------------------------

SELECT MAX(Enrolment.StudentResult) AS 'Highest Result'
FROM Enrolment;

-- Expected Result
-- '99' is the highest result that has been added to the database under the 'StudentResult' column in the 'Enrolement' table.
-- The script returned the expected result.

-- Test Confirmation
-- When the above script was run, the script returned a '99' from the database.
-- This result was confirmed as the maximum value added to the database in the 'StudentResult' column in the 'Enrolement' table.

-- -----------------------------------------------------
-- Lowest Result
-- -----------------------------------------------------

SELECT MIN(Enrolment.StudentResult) AS 'Lowest Result'
FROM Enrolment;

-- Expected Result
-- '0' is the lowest result that has been added to the database under the 'StudentResult' column in the 'Enrolement' table.
-- The script returned the expected result.

-- Test Confirmation
-- When the above script was run, the script returned a '0' from the database.
-- This result was confirmed as the minimum value added to the database in the 'StudentResult' column in the 'Enrolement'.

-- -----------------------------------------------------
-- Understanding how to update and delete the database and records
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Alter the table structure for Student's Language Spoken at Home
-- -----------------------------------------------------
-- The following script should be run first in order to ensure that 'unsafe' updates can be made in the remaining script.
SET SQL_safe_updates = 0;

ALTER TABLE Student ADD COLUMN SpokenLanguageatHome VARCHAR(45) AFTER SchoolName; -- A column is added to the Student table to hold the following update data.
UPDATE Student
	SET SpokenLanguageatHome = 'English'; -- English is set as the SpokenLanguageatHome for all rows in the Student table.

-- -----------------------------------------------------
-- Change a Subject Coordinator
-- -----------------------------------------------------

-- Running the following script before the table alteration has occurred will return the current subject coordinators for each subject.

-- SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name', Subject.SubjectName
-- FROM Teacher
-- INNER JOIN Subject ON Teacher.TeacherID = Subject.TeacherID;

ALTER TABLE Teacher;
UPDATE Subject
	SET TeacherID = '2001'
    WHERE SubjectName = '4CEP' AND TeacherID = '2002';

-- Running the following script again will now identify the new subject coordinator for the subject '4CEP'.
-- As above, each teacher is identified by their TeacherID from the teachers table and this is associated with each SubjectName.

-- SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name', Subject.SubjectName
-- FROM Teacher
-- INNER JOIN Subject ON Teacher.TeacherID = Subject.TeacherID;
    
-- -----------------------------------------------------
-- Delete a Teacher
-- -----------------------------------------------------

-- To be certain the script is deleting the right teacher, the following script will return the teacher's names and IDs from the Teacher table.

SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name'
FROM Teacher;

-- The script from the last segment has already confirmed that the TeacherID '2002' is no longer associated with any subjet, so it can be safely deleted from the Teacher Table.

DELETE FROM Teacher WHERE TeacherID = '2002';

-- The following script will return all data from the Teacher Table to confirm the teacher with the ID '2002' has been successfully deleted.

SELECT *
FROM Teacher;

-- -----------------------------------------------------
-- Assessment Challenge
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Results of a Student
-- -----------------------------------------------------

CREATE PROCEDURE sp_result(ID int) -- The procedure is created with the relevant preameters declared.

SELECT Student.StudentID, CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', Subject.SubjectName, Subject.SubjectDescription, Enrolment.StudentResult, Enrolment.Grade  
FROM Student 
INNER JOIN Enrolment 
ON Student.StudentID = Enrolment.StudentID 
INNER JOIN Subject 
ON Subject.SubjectName = Enrolment.SubjectName
WHERE Student.StudentID = ID 
ORDER BY Student.StudentID;

CALL sp_result('100884664'); -- To change this query to select data for another student, the value stated in the CALL command should be changed to the StudentID of another student from the Student table.

-- -----------------------------------------------------
-- Grades in a Subject
-- -----------------------------------------------------

CREATE PROCEDURE sp_grades(Sname VARCHAR(4)) -- The procedure is created with the relevant preameters declared.

SELECT Subject.SubjectName, CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', Enrolment.StudentResult, Enrolment.Grade
FROM Student 
INNER JOIN Enrolment 
ON Student.StudentID = Enrolment.StudentID 
INNER JOIN Subject 
ON Subject.SubjectName = Enrolment.SubjectName
WHERE Subject.SubjectName = Sname
ORDER BY Enrolment.StudentResult DESC;

CALL sp_grades('4DBB'); -- To change this query to select data for another subject, the value declared in the CALL command should be changed to the SubjectName of another subject from the Subject table.

-- -----------------------------------------------------
-- Age of Student
-- -----------------------------------------------------

-- The following script was developed through researching Date Calculations for MySQL.

-- Identify query development source
-- Site visited : <https://dev.mysql.com/doc/refman/8.0/en/date-calculations.html> 

-- Query Demonstration
-- MySQL.com provides a formula using the TIMESTAMPDIFF function to calculate the difference between 2 time stamps.
-- For context, the query first Selects the Student's Name from the student table using a contatonation of the StudentFirstName and StudentLastName columns.
-- The TIMESTAMPDIFF function is then called. It first requires the date_format relevant to the difference calculation (in this case years).
-- The function then requires 2 variables to calculate their difference. The Student's birthday from the student table and the current year (from the CURDATE() function) is provided, which provides the current time acording to the user's machine in years.
-- The function calculates the difference between these 2 variables as a day by day fraction of a year. This means the function can avoid the trap of simply outputting the student's age after their next birthday as a CURRENT YEAR - BIRTH YEAR calculation would.
-- The function finally outputs an integer (which is the age of the student) under the alias 'Student Age'.

CREATE PROCEDURE sp_age (ID int) -- The procedure is created with the relevant preameters declared.

SELECT CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', TIMESTAMPDIFF(YEAR,Student.StudentDateofBirth,CURDATE()) AS 'Student Age'
FROM Student
WHERE Student.StudentID = ID;

CALL sp_age ('100884664'); -- The procedure is then called with the relevant preameter declared

-- Query Sample Data of Age near Submission Date
-- In the above query, the birthday of the student with the StudentID '100884664' is one the day of submission for this assignment.
-- The query outputs 27 years as their age which is accurate, not 28, even though (2020 - 1992) = 28.

-- Test Confirmation
-- Testing of this query involved running script that would calculate the ages of all the students in the course and testing for errors.
-- The script was as follows :

-- SELECT CONCAT(Student.StudentFirstName,' ',Student.StudentLastName) AS 'Student Name', TIMESTAMPDIFF(YEAR,Student.StudentDateofBirth,CURDATE()) AS 'Student Age'
-- FROM Student;

-- All ages returned a correct result.

-- Explanation of how to change for a different student
-- To change this query to select data for another student, the value after the WHERE clause should be changed to the StudentID of another student from the Student table.

-- -----------------------------------------------------
-- Highest Result
-- -----------------------------------------------------

CREATE PROCEDURE sp_max() -- The procedure is created.

SELECT MAX(Enrolment.StudentResult) AS 'Highest Result'
FROM Enrolment;

CALL sp_max(); -- The procedure is then called.

-- Expected Result
-- '99' is the highest result that has been added to the database under the 'StudentResult' column in the 'Enrolement' table.
-- The script returned the expected result.

-- Test Confirmation
-- When the above script was run, the script returned a '99' from the database.
-- This result was confirmed as the maximum value added to the database in the 'StudentResult' column in the 'Enrolement' table.

-- -----------------------------------------------------
-- Lowest Result
-- -----------------------------------------------------

CREATE PROCEDURE sp_min() -- The procedure is created.

SELECT MIN(Enrolment.StudentResult) AS 'Lowest Result'
FROM Enrolment;

CALL sp_min(); -- The procedure is then called.

-- Expected Result
-- '0' is the lowest result that has been added to the database under the 'StudentResult' column in the 'Enrolement' table.
-- The script returned the expected result.

-- Test Confirmation
-- When the above script was run, the script returned a '0' from the database.
-- This result was confirmed as the minimum value added to the database in the 'StudentResult' column in the 'Enrolement'.

-- -----------------------------------------------------
-- Understanding how to update and delete the database and records
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Alter the table structure for Student's Language Spoken at Home
-- -----------------------------------------------------

-- Firstly, script must be run in order to make 'unsafe' updates possible
-- SET SQL_safe_updates = 0;

-- CREATE PROCEDURE sp_updatelang() -- The procedure must be created

-- ALTER TABLE Student ADD COLUMN SpokenLanguageatHome VARCHAR(45) AFTER SchoolName;
-- UPDATE Student -- A column is added to house the language spoken at home information after the SchoolName column
-- SET SpokenLanguageatHome = 'English'; -- English is added to all rows in the spoken language column

-- CALL sp_updatelang(); -- The procedure is called

-- -----------------------------------------------------
-- Change a Subject Coordinator
-- -----------------------------------------------------

-- Running the following script before the table alteration has occurred will return the current subject coordinators for each subject.

-- SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name', Subject.SubjectName
-- FROM Teacher
-- INNER JOIN Subject ON Teacher.TeacherID = Subject.TeacherID;

-- CREATE PROCEDURE sp_updateteacher() -- The procedure is created.

-- ALTER TABLE Teacher;
-- UPDATE Subject
-- SET TeacherID = '2001'
-- WHERE SubjectName = '4CEP' AND TeacherID = '2002';

-- CALL sp_updateteacher(); -- The procedure is the called.

-- Running the following script again will now identify the new subject coordinator for the subject '4CEP'.
-- As above, each teacher is identified by their TeacherID from the teachers table and this is associated with each SubjectName.

-- SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name', Subject.SubjectName
-- FROM Teacher
-- INNER JOIN Subject ON Teacher.TeacherID = Subject.TeacherID;
    
-- -----------------------------------------------------
-- Delete a Teacher
-- -----------------------------------------------------

-- To be certain the script is deleting the right teacher, the following script will return the teacher's names and IDs from the Teacher table.

-- CREATE PROCEDURE sp_deleteteacher() -- The procedure is created.

-- SELECT Teacher.TeacherID, CONCAT(Teacher.TeacherFirstName,' ',TeacherLastName) AS 'Teacher Name'
-- FROM Teacher;

-- The script from the last segment has already confirmed that the TeacherID '2002' is no longer associated with any subjet, so it can be safely deleted from the Teacher Table.

-- DELETE FROM Teacher WHERE TeacherID = '2002';

-- CALL sp_deleteteacher(); -- The procedure is then called.

-- The following script will return all data from the Teacher Table to confirm the teacher with the ID '2002' has been successfully deleted.

-- SELECT *
-- FROM Teacher;

