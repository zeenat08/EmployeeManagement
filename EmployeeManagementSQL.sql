create procedure [dbo].[spUpdateEmployeeSalary]
@id int,
@month varchar(20),
@salary int,
@EmpId int
as
BEGIN
--below line will cause transaction uncommitable if constraint violation occur
set XACT_ABORT on;
begin try
begin TRANSACTION;
update SALARY
set EMPSAL=@salary
where SALARYId=@id and SALARYMONTH=@month and EmpId=@EmpId;
select e.EmpId,e.ENAME,s.EMPSAL,s.SALARYMONTH,s.SALARYId
from Employee e inner join SALARY s
ON e.EmpId=s.EmpId where s.SALARYId=@id;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
IF(XACT_STATE())=-1
BEGIN
  PRINT N'The transaction is in an uncommitable state.'+'Rolling back transaction.'
  ROLLBACK TRANSACTION;
  END;

  IF(XACT_STATE())=1
  BEGIN
    PRINT 
	    N'The transaction is committable. '+'Committing transaction.'
       COMMIT TRANSACTION;
	END;
	END CATCH
END
GO


CREATE TABLE [dbo].[Salary](
	[SalaryId] [int] IDENTITY(1,1) NOT NULL,
	[SalaryMonth] [varchar](20) NULL,
	[EmpSal] [money] NULL,
	[EmpId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Salary]  WITH CHECK ADD FOREIGN KEY([EmpId])
REFERENCES [dbo].[Employee] ([EmpId])
GO


CREATE TABLE [dbo].[Employee](
	[EmpId] [int] IDENTITY(1,1) NOT NULL,
	[EName] [varchar](20) NULL,
	[Gender] [char](1) NULL,
	[HireDay] [date] NULL,
	[DeptNo] [int] NULL,
	[Email] [varchar](20) NULL,
	[BirthDay] [date] NULL,
	[JobDiscription] [varchar](20) NULL,
	[ProfileImage] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


select * from Salary
select * from Employee


insert into Employee values
('SAM','M','2018-10-11',1,'sam@gmail.com','1994-6-10','Software engineer','c:\file\image012.png'),
('Maria','F','2019-10-11',3,'maria@gmail.com','1997-6-10','UI Developer','c:\file\image011.png');

insert into Salary values
('Jan',10000.0,2);

