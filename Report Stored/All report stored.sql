
--Stored Procedure 1

create proc report1 @dep_no int 
as
select* from  [dbo].[Student]
where [Dep_id]=@dep_no

exec report1 3
----------------------------------------------------------
--Stored Procedure 2

create proc report2 @student_id int
as
select [Crs_Name],[Grade]
from [Course] c,[Exam] E ,[Student_Exam] se
where se.St_id=@student_id
and se.Exam_id = E.Exam_id
and E.crs_id = C.Crs_id

exec report2 6
----------------------------------------------------------
--Stored Procedure 3
 
create proc reportt3  @inst_id int
as
select [Ins_Name],[Crs_Name],count(*) as 'Student_num'
from [Course] c,[Instructor] i,[Student_Course] sc
where i.Ins_id = @inst_id
 and  i.Ins_id = c.Ins_id
 and  sc.Crs_id = c.Crs_id
 group by Crs_Name, Ins_Name

exec reportt3 4
----------------------------------------------------------
--Stored Procedure 4

create proc report4 @cid int
as 
select C.Crs_Name,Top_Name
from [Course] C,[Topic] T
where C.Crs_id = @cid
  and C.Crs_id = T.Crs_id

exec report4 2
-----------------------------------------------------------
--Stored Procedure 5

create proc report5 @ex_id int
as
select [Q_text],[option_a],[option_b],[option_c],[option_d]
from Questions as q, Exam_Questions as eq 
where eq.Exam_id = @ex_id
 and  eq.Q_id = q.Q_id

exec report5 1
-----------------------------------------------------------
--Stored Procedure 6

create proc report6 @ex_id int, @st_id int
as
select Q_text ,sa.Answer
from Questions as q , Student_Answers as sa
where sa.St_id = @st_id
 and  sa.Exam_id = @ex_id
 and  sa.Q_id = Q.Q_id

exec report6 1,6
------------------------------------------------------------



