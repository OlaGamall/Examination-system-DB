create table Student(

St_id int primary key identity(1,1),
st_Name varchar(20) not null,
St_faculty varchar(20) not null,
Birthdate date,
Dep_id int ,
constraint c1 foreign key(Dep_id) references Department(Dep_id),
on delete set null on update cascade 
)

create table Department(

Dep_id int primary key identity(1,1),
Dep_Name varchar(20) not null,
Ins_id int ,
constraint c2 unique(Dep_Name),
constraint c3 foreign key(Ins_id) references Instructor(Ins_id)
on delete set null on update cascade 
)

create table Instructor(

Ins_id int primary key identity(1,1),
Ins_Name varchar(20) not null
)

create table Course(

Crs_id int primary key identity(1,1),
Crs_Name varchar(20) not null,
Crs_Hours int ,
Ins_id int ,
constraint c4 unique(Crs_Name),
constraint c5 foreign key(Ins_id) references Instructor(Ins_id)
on delete set null on update cascade 
)

create table Topic(

Top_id int primary key identity(1,1),
Top_Name varchar(20)not null,
Crs_id int,
constraint c6 foreign Key(Crs_id) references Course(Crs_id) 
)

create table Exam(

Exam_id int primary key identity(1,1),
Exam_Duration int,
Score int not null,
Ins_id int,
constraint c7 foreign key(Ins_id) references Instructor(Ins_id)
)

create table Questions(

Q_id int primary Key identity(1,1),
Q_text nvarchar(400) not null,
Crs_id int foreign key references Course(Crs_id),
flag int,
option_a varchar(200), 
option_b varchar(200), 
option_c varchar(200),
option_d varchar(200),
Answer char(1) not null,
constraint c8 check(flag in (1,0)),
constraint c9 check( 
                    (Answer in ('T','F') and flag =0) or
					(Answer in ('a','b','c','d') and flag =1)),
)


create table Student_Course(

St_id int,
Crs_id int,
constraint c10 foreign key(St_id) references Student(St_id),
constraint c11 foreign key(Crs_id) references Course(Crs_id),
constraint c12 primary key (St_id, Crs_id),
)


create table Student_Exam(

St_id int foreign key references Student(St_id),
Exam_id int foreign key references Exam(Exam_id),
Grade int,
primary key (St_id, Exam_id),
)


create table Student_Answers(
     St_id int FOREIGN KEY REFERENCES Student(St_id),
     Exam_id int FOREIGN KEY REFERENCES Exam(Exam_id),
	 Q_id int FOREIGN KEY REFERENCES Questions(Q_id),
	 Answer varchar(1),
     primary key (St_id, Exam_id,Q_id)
)


create table Exam_Questions(
     Exam_id int FOREIGN KEY REFERENCES Exam(Exam_id),
	 Q_id int FOREIGN KEY REFERENCES Questions(Q_id),
     primary key (Exam_id,Q_id),
)



delete from Exam_Questions;
delete from Exam;
delete from Student_Exam;


