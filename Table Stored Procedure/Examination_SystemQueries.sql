create proc Generate_Exam @mcq int, @tf int, @score int, @crsname varchar(20), @duration int, @ins_name varchar(20)
as
begin
  declare @ins_id int, @LASTID int, @crsid int
  select @ins_id = Ins_id from Instructor where Ins_Name = @ins_name

  select @crsid = Crs_id from Course where Crs_Name = @crsname

  insert into Exam values(@duration, @score, @ins_id,@crsid)
 
  SET @LASTID = IDENT_CURRENT('dbo.Exam')

  declare @t1 table(q_id int)
  declare @t2 table(q_id int)

  insert into @t1 
  select top (@tf) Q_id
  from Questions Q, Course C
  where C.Crs_Name = @crsname and Q.Crs_id = C.Crs_id  and flag = 0
  order by newid();

  insert into @t2 
  select top (@mcq) Q_id
  from Questions Q, Course C
  where C.Crs_Name = @crsname and Q.Crs_id = C.Crs_id  and flag = 1
  order by newid();

  declare c1 Cursor
  for select q_id
	  from @t1
  for read only      --update
  declare @id int
  open c1
  fetch c1 into @id
  while @@FETCH_STATUS=0
	  begin
		  insert into Exam_Questions values(@LASTID, @id)
		  fetch c1 into @id
	  end
  close c1
  deallocate c1

  declare c1 Cursor
  for select q_id
	  from @t2
  for read only      
  open c1
  fetch c1 into @id
  while @@FETCH_STATUS=0
	  begin
		  insert into Exam_Questions values(@LASTID, @id)
		  fetch c1 into @id
	  end
  close c1
  deallocate c1
end


exec Generate_Exam 5, 5, 100, 'DataStructure', 60, 'Mahmoud Ouf'

