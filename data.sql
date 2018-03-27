INSERT INTO Student (sid, firstName, lastName) VALUES
('0998801234', 'Lena', 'Headey'),
('0010784522', 'Peter', 'Dinklage'),
('0997733991', 'Emillia', 'Clarke'),
('5555555555', 'Kit', 'Harriongton'),
('1111111111', 'Sophie', 'Turner'),
('2222222222', 'Maisie', 'William');


INSERT INTO room (rid, teacher) VALUES
(120, 'Mr Higgins'),
(366, 'Miss Nyers');

INSERT INTO Class (cid, grade, rid) VALUES
(1, 8, 120),
(2, 5, 366);

INSERT INTO Enrollment(cid, sid) VALUES
(1, '0998801234'),
(1, '0010784522'),
(1, '0997733991'),
(1, '5555555555'),
(1, '1111111111'),
(2, '2222222222');

INSERT INTO QuestionBank(QuesID, Type, QuesText) VALUES
(782, 'MC', 'What do you promise when you take the oath of citizenship?'),
(566, 'TF', 'The Prime Minister, Justin Trudeau, is Canada''s Head of State.'),
(601, 'Numeric', 'During the "Quiet Revolution," Quebec experienced rapid change. In what decade did this occur? (Enter the year that began the decade, e.g., 1840.)'),
(625, 'MC', 'What is the Underground Railroad?'),
(790, 'MC', 'During the War of 1812 the Americans burned down the Parliament Buildings in York (now Toronto). What did the British and Canadians do in return?');

INSERT INTO NumQuesFalse(QuesID, lower_bound, upper_bound, HINT) VALUES
(601, 1800, 1900, 'The Quiet Revolution happened during the 20th Century.'),
(601, 2000, 2010, 'The Quiet Revolution happened some time ago.'),
(601, 2020, 3000, 'The Quiet Revolution has already happened!');


INSERT INTO MCQuesFalse (QuesID , Choice) VALUES 
(782, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian'),
(782, 'To pledge your loyalty to Canada from sea to sea'),
(625, 'The first railway to cross Canada'),
(625, 'CPR''s secret railway line'),
(625, 'The TTC subway system'),

(790, 'They attacked American merchant ships'),
(790, 'They expanded their defence system, including Fort York'),      
(790, 'They captured Niagara Falls');

INSERT INTO MCHINT(QuesID, Choice, HINT) VALUES
(782, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 'Think regally.'),
(625, 'The first railway to cross Canada', 'The Underground Railroad was generally south to north, not east-west.'),
(625, 'CPR''s secret railway line', 'The Underground Railroad was secret, but it had nothing to do with trains.'),
(625, 'The TTC subway system', 'The TTC is relatively recent; the Underground Railroad was in operation over 100 years ago.');


INSERT INTO NumQuesTrue(QuesID, CorrectAns) VALUES
(601, 1960);

INSERT INTO MCQuesTrue(QuesID, Choice) VALUES
(782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II'),
(625, 'A network used by slaves who escaped the United States into Canada'),
(790, 'They burned down the White House in Washington D.C.');

INSERT INTO TFQuesTrue(QuesID, CorrectAns) VALUES
(566, 'False');

INSERT INTO Quiz(QuizID, title ,duedate, duetime, HINT) VALUES 
('Pr1-220310', 'Citizenship Test Practise Questions', to_date('2017-10-01', 'YYYY-MM-DD'), '13:30:00', 'True');

INSERT INTO QuizAndQues(QuizID, QuesID, weight) VALUES
('Pr1-220310', 601, 2),
('Pr1-220310', 566, 1),
('Pr1-220310', 790, 3),
('Pr1-220310', 625, 2);

INSERT INTO QuizAndClass(QuizID, cid) VALUES
('Pr1-220310', 1);

INSERT INTO StudentResponseMC(sid, QuizID, QuesID, response) VALUES
('0998801234' ,'Pr1-220310' ,790 ,'They expanded their defence system, including Fort York' ),
('0998801234' ,'Pr1-220310' ,625 ,'A network used by slaves who escaped the United States into Canada' ),

('0010784522' ,'Pr1-220310' ,790 ,'They burned down the White House in Washington D.C.' ),
('0010784522' ,'Pr1-220310' ,625 ,'A network used by slaves who escaped the United States into Canada' ),

('0997733991' ,'Pr1-220310' ,790 ,'They burned down the White House in Washington D.C.' ),
('0997733991' ,'Pr1-220310' ,625 ,'The CPR''s secret railway line' ),

('5555555555' ,'Pr1-220310' ,790 ,'They captured Niagara Falls' );


INSERT INTO StudentResponseNum(sid, QuizID, QuesID, response) VALUES
('0998801234' ,'Pr1-220310' ,601 ,1950 ),
('0010784522' ,'Pr1-220310' ,601 ,1960 ),
('0997733991' ,'Pr1-220310' ,601 ,1960 );


INSERT INTO StudentResponseTF(sid, QuizID, QuesID, response) VALUES
('0998801234' ,'Pr1-220310' ,566 ,'False' ),
('0010784522' ,'Pr1-220310' ,566 ,'False' ),
('0997733991' ,'Pr1-220310' ,566 ,'True' ),
('5555555555' ,'Pr1-220310' ,566 ,'False' );



