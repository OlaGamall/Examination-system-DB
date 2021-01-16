--------------------SELECT PROC-------------------- 
alter sel_table1  @col varchar(100,@t varchar(20)
as 
execute('select'+@col+'from'+@t)

exec sel_table1 '[Ins_id],[Ins_Name]'  ,  '[dbo].[Instructor]' 


--------------------insert--------------------------------

alter  proc inst_st @t varchar(10),@col varchar(100),@values varchar(50)
as
execute ('insert into'+' '+@t+' '+'('+@col+')'+' '+'values'+' '+'(' + @values + ')' )


exec inst_st  [Instructor] , '[Ins_Name]' ," 'Noha Salah' "
exec inst_st  [Department] , '[Dep_Name],[Ins_id]' ,"'mobile',3 "
exec inst_st "[Course]" , '[Crs_Name],[Crs_Hours],[Ins_id]' ,"'mob',15,1"
select* from [Course]
select* from [Instructor]
select* from [[Department]

---------------------update------------------------------

alter PROCEDURE update_new1 @t varchar(100),@col varchar(100),@new_val varchar(50),@condition varchar(50)
as
execute('update '+@t+' set '+@col+' = '+@new_val+' where '+@condition)

update_new1  [Instructor], '[Ins_Name]' , "'ahmed'", '[Ins_id] = 5'
update_new1  [Student], '[St_faculty]', "'Education'",'[St_id] = 8'
select* from [Instructor]
select* from [Student]

--------------------------------------delete------------------------------

alter PROCEDURE del_state @t varchar(20),@condition  varchar(50)
as
execute('delete from '+@t+' where '+@condition)

exec del_state  '[Course]', '[Crs_id] = 8'
exec del_state  [Instructor], '[Ins_id] = 9'
select* from [Instructor]
select* from [Course]
