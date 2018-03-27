-- Constraint that can not be enforced : --
-- 1. There must be one or more student in a class --
-- 2. There must be at least 2 choices for every MC question --
-- Constraint that could have been enforced, but not --
-- Only a student in the class that was assigned a quiz can answer questions on that quiz --
-- Reason : To do so, we have to add cid to the response table, which could lead to a lot of redundancy --


drop schema if exists quizschema cascade;

create schema quizschema;
set search_path to quizschema;

CREATE TABLE Student(
   sid VARCHAR(11) PRIMARY KEY,
   firstName VARCHAR(50),
   lastName VARCHAR(50)
);

CREATE TABLE Room(
   rid INT PRIMARY KEY ,
   teacher VARCHAR(50)
);

CREATE TABLE Class(
   cid VARCHAR(11) PRIMARY KEY,
   grade INT,
   rid INT
);

CREATE TABLE Enrollment(
   cid VARCHAR(11) REFERENCES Class (cid),
   sid VARCHAR(11) REFERENCES Student (sid),
   PRIMARY KEY (cid, sid)
);

CREATE TABLE QuestionBank(
   QuesID INT PRIMARY KEY,
   Type VARCHAR(50),
   QuesText VARCHAR(200)
);

CREATE TABLE NumQuesFalse(
   QuesID INT REFERENCES QuestionBank (QuesID), 
   lower_bound INT,
   upper_bound INT,
   HINT VARCHAR(100),
   PRIMARY KEY (QuesID, lower_bound, upper_bound)
);

CREATE TABLE MCQuesFalse(
   QuesID INT REFERENCES QuestionBank (QuesID), 
   Choice VARCHAR(100),
   --HINT VARCHAR(100),
   PRIMARY KEY (QuesID, Choice)
);

CREATE TABLE MCHINT(
   QuesID INT REFERENCES QuestionBank (QuesID),
   Choice VARCHAR(100),
   HINT VARCHAR(100),
   PRIMARY KEY (QuesID, Choice)

);

CREATE TABLE NumQuesTrue(
   QuesID INT REFERENCES QuestionBank (QuesID),
   CorrectAns INT,
   PRIMARY KEY (QuesID)
);

CREATE TABLE MCQuesTrue(
   QuesID INT REFERENCES QuestionBank (QuesID), 
   Choice VARCHAR(100),
   PRIMARY KEY (QuesID)
);

CREATE TABLE TFQuesTrue(
   QuesID INT REFERENCES QuestionBank (QuesID), 
   CorrectAns VARCHAR(20),
   PRIMARY KEY (QuesID)
);

CREATE TABLE Quiz(
   QuizID VARCHAR(50) PRIMARY KEY, 
   title VARCHAR(50),
   duedate DATE NOT NULL,
   duetime TIME NOT NULL,
   HINT VARCHAR(50)   
);

CREATE TABLE QuizAndQues(
   QuizID VARCHAR(50) REFERENCES Quiz (QuizID), 
   QuesID INT REFERENCES QuestionBank (QuesID), 
   weight INT,
   PRIMARY KEY (QuizID, QuesID)
);

CREATE TABLE QuizAndClass(
   QuizID VARCHAR(50) REFERENCES Quiz (QuizID),
   cid VARCHAR(11) REFERENCES Class (cid),
   PRIMARY KEY (QuizID, cid)
);

CREATE TABLE StudentResponseMC(
   sid VARCHAR(11),
   QuizID VARCHAR(50) ,
   QuesID INT ,
   response VARCHAR(100),
   
   FOREIGN KEY (QuizID, QuesID) REFERENCES QuizAndQues(QuizID, QuesID)
);

CREATE TABLE StudentResponseNum(
   sid VARCHAR(11),
   QuizID VARCHAR(50) ,
   QuesID INT ,
   response INT,
   
   FOREIGN KEY (QuizID, QuesID) REFERENCES QuizAndQues(QuizID, QuesID)
);

CREATE TABLE StudentResponseTF(
   sid VARCHAR(11),
   QuizID VARCHAR(50) ,
   QuesID INT ,
   response VARCHAR(100),
   
   FOREIGN KEY (QuizID, QuesID) REFERENCES QuizAndQues(QuizID, QuesID)
);



--START INSERTION--



