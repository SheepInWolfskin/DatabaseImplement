
CREATE TABLE q3 (
    studentNumber varchar(20),
    lastName varchar(20),
    totalGrade INT
);

DROP VIEW IF EXISTS mc_responce CASCADE;
DROP VIEW IF EXISTS tf_responce CASCADE;
DROP VIEW IF EXISTS num_responce CASCADE;
DROP VIEW IF EXISTS mc_correct CASCADE;
DROP VIEW IF EXISTS tf_correct CASCADE;
DROP VIEW IF EXISTS num_correct CASCADE;
DROP VIEW IF EXISTS mc_score CASCADE;
DROP VIEW IF EXISTS tf_score CASCADE;
DROP VIEW IF EXISTS num_score CASCADE;
DROP VIEW IF EXISTS big_list CASCADE;
DROP VIEW IF EXISTS no_score CASCADE;
DROP VIEW IF EXISTS final_record CASCADE;
DROP VIEW IF EXISTS get_info CASCADE;

-- find all the student's response --

CREATE VIEW mc_responce AS 
SELECT * FROM StudentResponseMC
WHERE QuizID = 'Pr1-220310';

CREATE VIEW tf_responce AS
SELECT * FROM StudentResponseTF
WHERE QuizID = 'Pr1-220310';

CREATE VIEW num_responce AS
SELECT * FROM StudentResponseNum
WHERE QuizID = 'Pr1-220310';

-- getting the correct answer for the questions in the quiz --
CREATE VIEW mc_correct AS
SELECT mc_responce.sid, mc_responce.QuizID, mc_responce.QuesID
FROM mc_responce, MCQuesTrue
WHERE mc_responce.QuesID = MCQuesTrue.QuesID AND 
      mc_responce.response = MCQuesTrue.Choice;
      
CREATE VIEW tf_correct AS
SELECT tf_responce.sid, tf_responce.QuizID, tf_responce.QuesID
FROM tf_responce, TFQuesTrue
WHERE tf_responce.QuesID = TFQuesTrue.QuesID AND 
      tf_responce.response = TFQuesTrue.CorrectAns;
      
CREATE VIEW num_correct AS
SELECT num_responce.sid, num_responce.QuizID, num_responce.QuesID
FROM num_responce, NumQuesTrue
WHERE num_responce.QuesID = NumQuesTrue.QuesID AND 
      num_responce.response = NumQuesTrue.CorrectAns;
      
-- counting the score of students --
CREATE VIEW mc_score AS
SELECT sid, sum(weight) AS weight
FROM mc_correct, QuizAndQues
WHERE mc_correct.QuizID = QuizAndQues.QuizID AND 
      mc_correct.QuesID = QuizAndQues.QuesID
GROUP BY sid;

CREATE VIEW tf_score AS
SELECT sid, sum(weight) AS weight
FROM tf_correct, QuizAndQues
WHERE tf_correct.QuizID = QuizAndQues.QuizID AND 
      tf_correct.QuesID = QuizAndQues.QuesID
GROUP BY sid;

CREATE VIEW num_score AS
SELECT sid, sum(weight) AS weight
FROM num_correct, QuizAndQues
WHERE num_correct.QuizID = QuizAndQues.QuizID AND 
      num_correct.QuesID = QuizAndQues.QuesID
GROUP BY sid;

-- combine all the reocrd --
CREATE VIEW big_list AS
(SELECT * FROM mc_score)
UNION 
(SELECT * FROM tf_score)
UNION 
(SELECT * FROM num_score);

-- get student with no score --
CREATE VIEW no_score AS
SELECT sid
FROM QuizAndClass, Enrollment
WHERE sid NOT IN (SELECT sid FROM big_list) AND QuizAndClass.QuizID = 'Pr1-220310' AND QuizAndClass.cid = Enrollment.cid;

CREATE VIEW final_record AS
(SELECT sid, sum(weight) AS score FROM big_list GROUP BY sid)
UNION 
(SELECT sid, 0 AS score FROM no_score);

-- getting student's information --
CREATE VIEW get_info AS
SELECT final_record.sid, Student.lastName AS lastName, score AS totalGrade
FROM final_record, Student
WHERE final_record.sid = Student.sid;

INSERT INTO q3 (studentNumber, lastName, totalGrade)
(SELECT * FROM get_info);

      