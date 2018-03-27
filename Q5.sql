
 
CREATE TABLE q5(
   QuesID INT,
   NumberOfRight INT,
   NumberOfWrong INT,
   NumberOfNoAns INT
);

DROP VIEW IF EXISTS ClassInfo CASCADE;
DROP VIEW IF EXISTS ClassTeacher CASCADE;
DROP VIEW IF EXISTS ClassStudent CASCADE;
DROP VIEW IF EXISTS StudentAndQ CASCADE;
DROP VIEW IF EXISTS TFAll CASCADE;
DROP VIEW IF EXISTS TFRes CASCADE;
DROP VIEW IF EXISTS TFResT CASCADE;
DROP VIEW IF EXISTS TFResF CASCADE;
DROP VIEW IF EXISTS TFAllPart CASCADE;
DROP VIEW IF EXISTS TFResPart CASCADE;
DROP VIEW IF EXISTS TFResNIL CASCADE;
DROP VIEW IF EXISTS TFT1 CASCADE;
DROP VIEW IF EXISTS TFT2 CASCADE;
DROP VIEW IF EXISTS TFT3 CASCADE;
DROP VIEW IF EXISTS MCAll CASCADE;
DROP VIEW IF EXISTS MCRes CASCADE;
DROP VIEW IF EXISTS MCResT CASCADE;
DROP VIEW IF EXISTS MCResF CASCADE;
DROP VIEW IF EXISTS MCAllPart CASCADE;

DROP VIEW IF EXISTS MCResPart CASCADE;
DROP VIEW IF EXISTS MCResNIL CASCADE;
DROP VIEW IF EXISTS MCT1 CASCADE;
DROP VIEW IF EXISTS MCT2 CASCADE;
DROP VIEW IF EXISTS MCT3 CASCADE;
DROP VIEW IF EXISTS NumAll CASCADE;
DROP VIEW IF EXISTS NumRes CASCADE;
DROP VIEW IF EXISTS NumResT CASCADE;
DROP VIEW IF EXISTS NumResF CASCADE;
DROP VIEW IF EXISTS NumAllPart CASCADE;
DROP VIEW IF EXISTS NumResPart CASCADE;
DROP VIEW IF EXISTS NumResNIL CASCADE;
DROP VIEW IF EXISTS NumT1 CASCADE;
DROP VIEW IF EXISTS NumT2 CASCADE;
DROP VIEW IF EXISTS NumT3 CASCADE;
DROP VIEW IF EXISTS Final CASCADE;


CREATE VIEW ClassInfo AS
SELECT cid, grade, rid 
FROM Class
WHERE grade = 8 AND rid = 120;


--SELECT classes whose teacher name is higgina
CREATE VIEW ClassTeacher AS
SELECT cid, ClassInfo.rid, Room.teacher, grade
FROM Room, ClassInfo
WHERE teacher = 'Mr Higgins';

-- get all student in this class
CREATE VIEW ClassStudent AS
SELECT ClassTeacher.cid, sid, rid, teacher, grade
FROM ClassTeacher, Enrollment
WHERE Enrollment.cid = ClassTeacher.cid;


--SELECT quizes whos is in 'Pr1-220310'
CREATE VIEW StudentAndQ AS
SELECT sid, QuesID
FROM ClassStudent, QuizAndQues
WHERE QuizID = 'Pr1-220310'
GROUP BY sid, QuesID;

CREATE VIEW TFAll AS
SELECT StudentAndQ.QuesID, StudentAndQ.sid
FROM QuestionBank, StudentAndQ
WHERE TYPE = 'TF' AND StudentAndQ.QuesID = QuestionBank.QuesID;


CREATE VIEW TFRes AS
SELECT sid, QuesID, response
FROM StudentResponseTF
WHERE QuizID = 'Pr1-220310'
GROUP BY sid, QuesID, response;


-- select all tf question with right answer
CREATE VIEW TFResT AS 
SELECT TFRes.sid, TFRes.QuesID, TFRes.response
FROM TFRes, TFQuesTrue
WHERE TFRes.response = TFQuesTrue.CorrectAns;

-- select all tf question with wrong answer
CREATE VIEW TFResF AS
(SELECT * FROM TFRes) EXCEPT (SELECT * FROM TFResT);


CREATE VIEW TFAllPart AS
SELECT sid, QuesID
FROM TFAll;

CREATE VIEW TFResPart AS
SELECT sid, QuesID
FROM TFRes;

-- select all tf question with no answer
CREATE VIEW TFResNIL AS
(SELECT * FROM TFAllPart) EXCEPT (SELECT * FROM TFResPart);

-- combine them together
CREATE VIEW TFT1 AS
SELECT QuesID, count(sid) AS NumberOfNoAns
FROM  TFResNIL
GROUP BY QuesID;

-- add right
CREATE VIEW TFT2 AS
SELECT TFT1.QuesID,NumberOfNoAns, count(TFResT.sid) AS NumberOfRight
FROM TFT1, TFResT
WHERE TFT1.QuesID = TFResT.QuesID
GROUP BY TFT1.QuesID, TFT1.NumberOfNoAns;

-- add wrong
CREATE VIEW TFT3 AS
SELECT TFT2.QuesID,NumberOfNoAns,NumberOfRight,  count(TFResF.sid) AS NumberOfWrong
FROM TFT2, TFResF
WHERE TFT2.QuesID = TFResF.QuesID
GROUP BY TFT2.QuesID, TFT2.NumberOfNoAns, TFT2.NumberOfRight;

-- select all mc question
CREATE VIEW MCAll AS
SELECT StudentAndQ.QuesID, StudentAndQ.sid
FROM QuestionBank, StudentAndQ
WHERE TYPE = 'MC' AND StudentAndQ.QuesID = QuestionBank.QuesID;

CREATE VIEW MCRes AS
SELECT sid, QuesID, response
FROM StudentResponseMC
WHERE QuizID = 'Pr1-220310'
GROUP BY sid, QuesID, response;


-- select all MC question with right answer
CREATE VIEW MCResT AS 
SELECT MCRes.sid, MCRes.QuesID, MCRes.response
FROM MCRes, MCQuesTrue
WHERE MCRes.response = MCQuesTrue.Choice;

-- select all MC question with wrong answer
CREATE VIEW MCResF AS
(SELECT * FROM MCRes) EXCEPT (SELECT * FROM MCResT);

CREATE VIEW MCAllPart AS
SELECT sid, QuesID
FROM MCAll;


CREATE VIEW MCResPart AS
SELECT sid, QuesID
FROM MCRes;

-- select all MC question with no answer
CREATE VIEW MCResNIL AS
(SELECT * FROM MCAllPart) EXCEPT (SELECT * FROM MCResPart);

-- combine them together
CREATE VIEW MCT1 AS
SELECT QuesID, count(sid) AS NumberOfNoAns
FROM  MCResNIL
GROUP BY QuesID;

-- add right
CREATE VIEW MCT2 AS
SELECT MCT1.QuesID,NumberOfNoAns, count(MCResT.sid) AS NumberOfRight
FROM MCT1, MCResT
WHERE MCT1.QuesID = MCResT.QuesID
GROUP BY MCT1.QuesID, MCT1.NumberOfNoAns;

-- add wrong
CREATE VIEW MCT3 AS
SELECT MCT2.QuesID,NumberOfNoAns,NumberOfRight,  count(MCResF.sid) AS NumberOfWrong
FROM MCT2, MCResF
WHERE MCT2.QuesID = MCResF.QuesID
GROUP BY MCT2.QuesID, MCT2.NumberOfNoAns, MCT2.NumberOfRight;


-- select all num question
CREATE VIEW NumAll AS
SELECT StudentAndQ.QuesID, StudentAndQ.sid
FROM QuestionBank, StudentAndQ
WHERE TYPE = 'Numeric' AND StudentAndQ.QuesID = QuestionBank.QuesID;

CREATE VIEW NumRes AS
SELECT sid, QuesID, response
FROM StudentResponseNum
WHERE QuizID = 'Pr1-220310'
GROUP BY sid, QuesID, response;

-- select all Num question with right answer
CREATE VIEW NumResT AS 
SELECT NumRes.sid, NumRes.QuesID, NumRes.response
FROM NumRes, NumQuesTrue
WHERE NumRes.response = NumQuesTrue.CorrectAns;


-- select all Num question with wrong answer
CREATE VIEW NumResF AS
(SELECT * FROM NumRes) EXCEPT (SELECT * FROM NumResT);


CREATE VIEW NumAllPart AS
SELECT sid, QuesID
FROM NumAll;

CREATE VIEW NumResPart AS
SELECT sid, QuesID
FROM NumRes;

-- select all Num question with no answer
CREATE VIEW NumResNIL AS
(SELECT * FROM NumAllPart) EXCEPT (SELECT * FROM NumResPart);


-- combine them together
CREATE VIEW NumT1 AS
SELECT QuesID, count(sid) AS NumberOfNoAns
FROM  NumResNIL
GROUP BY QuesID;


-- add right
CREATE VIEW NumT2 AS
SELECT NumT1.QuesID,NumberOfNoAns, count(NumResT.sid) AS NumberOfRight
FROM NumT1, NumResT
WHERE NumT1.QuesID = NumResT.QuesID
GROUP BY NumT1.QuesID, NumT1.NumberOfNoAns;


-- add wrong
CREATE VIEW NumT3 AS
SELECT NumT2.QuesID,NumberOfNoAns,NumberOfRight,  count(NumResF.sid) AS NumberOfWrong
FROM NumT2, NumResF
WHERE NumT2.QuesID = NumResF.QuesID
GROUP BY NumT2.QuesID, NumT2.NumberOfNoAns, NumT2.NumberOfRight;

-- add them together
Create View Final AS
(SELECT * FROM NumT3) UNION (SELECT * FROM MCT3) UNION (SELECT * FROM TFT3);
--Insertion
INSERT INTO q5(QuesID,NumberOfRight,NumberOfWrong,NumberOfNoAns)
    (SELECT QuesID As QuesID,
            NumberOfRight AS NumberOfRight,
            NumberOfWrong AS NumberOfWrong,
            NumberOfNoAns AS NumberOfNoAns
    FROM FINAL
    );
