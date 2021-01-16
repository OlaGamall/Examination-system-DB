
CREATE TYPE tempTable AS TABLE
(
  Q_id   INT, 
  Q_answer CHAR(1)
)



create proc auto_correct_exam @exam_id int, @st_id int, @t tempTable readonly
as
begin
   declare @exam_score int
   select @exam_score = score from Exam where Exam_id = @exam_id
   declare @count int 
   select @count = count(*) from @t
   declare @q_degree float, @student_score float
   set @q_degree = CAST(@exam_score AS float) /@count
   set @student_score = 0.0

   declare c1 Cursor
   for select Q_id, Q_answer
	   from @t
   for read only      --update
   declare @id int, @answer char(1)
   open c1
   fetch c1 into @id, @answer
   while @@FETCH_STATUS=0
	   begin
	    
	 	   insert into Student_Answers values(@st_id, @exam_id, @id, @answer)
		   declare @right_ans char(1)
		   select @right_ans = Answer from Questions where Q_id = @id
		   if @answer = @right_ans
		   begin
		      set @student_score += @q_degree
		   end
		   fetch c1 into @id, @answer
	   end
   close c1
   deallocate c1
   insert into Student_Exam values(@st_id, @exam_id, @student_score)
end





declare @t tempTable
insert into @t values(4, 'a')
insert into @t values(13, 'c')
insert into @t values(17, 'c')
insert into @t values(25, 't')
insert into @t values(27, 'f')
insert into @t values(31, 'f')

execute auto_correct_exam 14, 4, @t