
CREATE TABLE q1(
   StudentNumber VARCHAR(11),
   StudentName VARCHAR(50)
);


CREATE VIEW StID AS
   SELECT sid AS StudentNumber, firstName ||' '|| lastName AS StudentName
   FROM Student;


INSERT INTO q1 (StudentNumber, StudentName)
(SELECT * FROM StID);
