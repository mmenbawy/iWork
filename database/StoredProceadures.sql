

-- “As an registered/unregistered user, I should be able to ...”

--- 1- Search For A company By A given name , address , type
go
create proc SearchForCompany
@name varchar(50),@address varchar(100) , @type varchar(50)
as
begin
if(@name is not null)
begin
	select c.company_name
	from Company_profiles c
	where c.company_name like '%' + @name + '%';
end
else
	begin
		if(@address is not null)
			select c.company_name
			from Company_profiles c
			where c.company_address = @address;
		else
			begin
				if(@type is not null)
					select c.company_name
					from Company_profiles c
					where c.company_type = @type;
				
			end
	end


end

--- 2- Get All Info About A company

go

create proc getCompanies
as
	select *
	from Company_profiles

go


------ 3- View the information of a certain company along with the departments in that company

create proc CompanyDepsInfo
@company_email varchar(50)
as
begin
	select c.company_name, c.email , c.company_address , c.company_type ,c.domain_name , c.field_of_spec , c.vision , d.department_name
	from Company_profiles c , Departments d
	where d.department_company = c.email and c.email = @company_email;
end

------ 4-View the information of a certain department in a certain company along with the jobs that have vacancies in it

go

create proc DepInfoAndJobs
@department_code int , @department_company varchar(50)
as
begin
	select d.department_company , d.department_code , d.department_name ,hrcj.jid
	from Departments d , HR_employee_create_job hrcj
	where d.department_code = @department_code and d.department_company = @department_company and hrcj.department_code = @department_code and hrcj.department_Company = @department_company;
end

------5- Register to the website to be able to apply for any job later on. Any user has to register in the website with a unique username and a password, along with all the needed information. 


go

create proc Register
@username varchar(50), @passwd varchar(50), @personal_email varchar(50), @birth_date date, @first_name varchar(20), @middle_name varchar(20), @last_name varchar(20), @experience_years int
as
begin
	insert into Job_Seekers values (@username,@passwd,@personal_email,@birth_date,@first_name,@middle_name,@last_name,@experience_years);
end

-----6- Search for jobs that have vacancies on the system and their short description or title contain a string of keywords entered by the user.

go

create proc FindJob
@keyword varchar(50)
as
begin
	select c.company_name , d.department_name , j.*
	from Jobs j , Departments d , Company_profiles c , HR_employee_create_job hrce
	where (hrce.jid = j.job_id and hrce.department_code = d.department_code and hrce.department_Company = d.department_company and c.email = hrce.department_Company) and (j.short_description like '%' + @keyword + '%' or j.detailed_description like '%' + @keyword + '%' ) ;
end

------7-View companies in the order of having the highest average salaries.

go

create proc CompaniesOrderedBySalary
as
begin
	select c.email ,AVG(sm.salary)
	from Company_profiles c , Staff_Members sm
	where sm.department_company = c.email
	group by c.email
	order by AVG(sm.salary) desc;
end
go


-- “As a registered user, I should be able to ...”


-------1- Login to the website using my username and password which checks that i am an existing user, and whether i am job seeker, HR employee, Regular employee or manager. Login Bit indicates if The Login Succsseded and Type Varchar returns the type of the user.

create proc Log_in
@username varchar(50),@password varchar(50) ,@login bit output, @type varchar(50) output
as
begin
	Declare @x varchar(50);
	select @x = s.username
	from Staff_Members s
	where s.username = @username and s.passwd = @password;
	if(@x is not null)
	begin
		set @login = 1;
		Declare @y varchar(50);
		select @y = s.username
		from Regular_Employees s
		where s.username = @username;
		if(@y is not null)
			set @type = 'Regular';
		else
		begin
			select @y = s.username
			from Managers s
			where s.username = @username;
			if(@y is not null)
				set @type = 'Manager';
			else
			begin
				select @y = s.username
				from HR_Employees s
				where s.username = @username;
				if(@y is not null)
					set @type = 'HR';
				else
					set @type = 'else';

			end
		end
	end
	else
	begin
		select @x = s.username
		from Job_Seekers s
		where s.username = @username and s.passwd = @password;
		
		if(@x is not null)
		begin
			set @login = '1';
			set @type = 'Seeker';
		end
		else
		begin
			set @login = '0';
			set @type = 'NOLOGIN';
		end
	end


end

------2- View all of my possible information.


go

create proc getMyInfo
@username varchar(50), @password varchar(50)
as
begin
	
	Declare @type varchar(50);
	select @type = j.username
	from Job_Seekers j
	where j.username = @username

	if(@type is not null)
		begin
			select *
			from Job_Seekers j
			where j.username = @username and j.passwd = @password;
		end
	else
	begin
		select *
		from Staff_Members s
		where s.username = @username and s.passwd = @password;
	end
end

----- 4-Edit all of my personal information.

go

create proc UpdateInfo_JobSeeker
@username varchar(50), @passwd varchar(50), @personal_email varchar(50), @birth_date date, @first_name varchar(20), @middle_name varchar(20), @last_name varchar(20), @experience_years int
as
begin
	update Job_Seekers 
	set personal_email =  @personal_email, birth_date  = @birth_date , first_name = @first_name, middle_name =  @middle_name, last_name =  @last_name, experience_years = @experience_years
	where username = @username and passwd = @passwd;
end
go

go

create proc UpdateInfo_StaffMember
@username varchar(50), @passwd varchar(50), @personal_email varchar(50), @birth_date date, @first_name varchar(20), @middle_name varchar(20), @last_name varchar(20), @experience_years int , @salary float,  @company_email varchar(50), @day_off varchar(10), @total_no_of_leaves int, @Department_code int, @Department_Company varchar(50), @job int
as
begin
	update Staff_Members 
	set personal_email =  @personal_email, birth_date  = @birth_date , first_name = @first_name, middle_name =  @middle_name, last_name =  @last_name, experience_years = @experience_years ,  salary = @salary,  company_email = @company_email, day_off = @day_off, total_number_of_leaves = @total_no_of_leaves, Department_code = @Department_code, Department_Company = @Department_Company, job = @job
	where username = @username and passwd = @passwd;
end

-----------“As a job seeker, I should be able to ...”

---- 1 -Apply for any job as long as I have the needed years of experience for the job. Make sure that a job seeker can’t apply for a job, if he/she applied for it before and the application is still pending. 

go

create proc JobSeekerApply
@username varchar(50) , @jid int
as
begin
	Declare @x varchar(50);
	Declare @expYrs int;
	select @x = username , @expYrs = experience_years
	from Job_Seekers 
	where username = @username;

	if(@x is not null)
	begin
	
	Declare @ReqYrs int;
	select @ReqYrs = j.minimum_experience_years
	from Jobs j 
	where j.job_id = @jid

	if(@ReqYrs<=@expYrs)
	begin
	
	Declare @check varchar(50);

	select @check = applicant_status
	from Applications
	where applicant = @username and job = @jid;

	if(@check is null)
		insert into Applications (applicant,applicant_status,job) values (@username ,'Pending',@jid);


	end

	end
end

---------- 2 -View the interview questions related to the job I am applying for.

go
create proc getInterviewQuestions
@username varchar(50)
as
begin

	select q.*
	from Interview_questions q , Applications a
	where a.applicant = @username and q.job = a.job;

end

----------- 3 - Save the score I got while applying for a certain job.

go

create proc saveScore 
@a_id int , @username varchar(50) , @score int
as
begin
	update Applications set score = @score where a_id = @a_id and applicant = @username;
end

go



-- job seeker 
--4
create proc StatusOfJobsAndScore 
@username varchar(50)
as
begin 
select applicant_status,score 
from Applications
where @username=applicant
end
 
 --5
 go
create proc ChooseAcceptedJob
@username varchar (50),@job_title varchar(50),@dayOFF varchar(10)
as
begin

declare @jID int , @salary float 


select @jID =A.job ,@salary=J.salary
from Applications A, Jobs J ,Accepted_applications C
where A.job=J.job_id and A.applicant_status='Accepted' and @job_title=J.title and @username=A.applicant and C.manager_response='Accepted' and  @username=C.applicant and A.a_id=C.a_id

declare @companyName varchar (20),@departmentCode int

select @companyName=department_Company,@departmentCode=department_code 
from HR_employee_create_job
where @jID=jid
declare @companyDomain varchar (50)
select  @companyDomain=domain_name 
from Company_profiles
where @companyName =  company_name

declare @departmentName varchar(50)
select  @departmentName from Departments where @departmentCode=department_code
declare @mail varchar(50) = @username +'@'+@companyDomain
if(@dayOFF<>'Friday')
begin
insert into Staff_Members(username,salary,company_email,day_off,department_code,department_company,job,total_number_of_leaves)values (@username,@salary,@mail,@dayOFF,@departmentCode,@departmentName,@jID,30)
end
else
print('You should enter another day rather than friday')

declare @numOfVacances int 
select  @numOfVacances =number_of_vacancies from Jobs where @jID=job_id
 update Jobs 
 set number_of_vacancies=@numOfVacances-1
 where  @jID=job_id 

end
------6
go
create proc deleteApplication
@username varchar(50)
as
begin
delete 
from Applications
where @username=applicant and applicant_status ='PENDING'
end

----------as staff member 
---1
go
create proc checkIn
@username varchar (50)
as
begin
declare @day varchar(10) =datename(day,getdate())
declare @dayoff varchar (10) 
select  @dayoff=day_off from Staff_Members
where @username=username

if(@day<>@dayoff)
insert into Attendances (start_time,staff_username,attendance_date)values ( current_timestamp,@username,getdate()) 
 else 
 print ('you can not check in  in your dayOFF')
end
----2

go
create proc checkOut
@username varchar (50),@attendancedate date
as
begin
declare @day varchar(10) =datename(day,@attendancedate)
declare @dayoff varchar (10) 
select  @dayoff=day_off from Staff_Members
where @username=username

if(@day<>@dayoff)
update Attendances 
set end_time =CURRENT_TIMESTAMP
where @username=staff_username and attendance_date= @attendancedate 
else 
 print ('you can not check out in your dayOFF')
end



go
---3
create proc AttendanceRecords
@username varchar (50)
as
begin
declare @WorkingHours int 
select  @WorkingHours=J.working_hours
from Jobs J,Staff_Members S 
where J.job_id=S.job and @username= S.username


declare @duration int 
declare @missingHours int
-- DATEDIFF(HOUR ,start_time,end_time)
select start_time, end_time,attendance_date, datediff (HOUR,end_time ,start_time) as duration, @WorkingHours-@duration as missingHours
from Attendances
where @username=staff_username



end 

----4

go
create proc ApplayForRequest
  @username varchar(50),@startdate date, @enddate date ,@type varchar(50)
  as 
  begin
  declare @m varchar(50);

  select @m = username
  from Managers
  where Managers.username = @username

  if(@m is null)
  begin
  
  Declare @anual_leaves int;

  select @anual_leaves = s.total_number_of_leaves
  from Staff_Members s
  where s.username = @username;
  
  Declare @duration int = DATEDIFF (day, @startdate, @enddate);

  if(@anual_leaves - @duration > 0)
  begin

	declare @temp int;

	select top 1 @temp = r.rid
	from Requests r
	where (@startdate between r.startdate and r.enddate) or (@enddate between r.startdate and r.enddate);

	if(@temp is not null)
	print('Cannot Make Your Request');
	else
	begin
  
		insert into Requests (enddate,startdate,staff_Member) values (@enddate,@startdate,@username);

		declare @req int;
		select @req =r.rid
		from Requests r
		where r.enddate = @enddate and r.startdate =@startdate and r.staff_Member = @username;
	
		if(@type = 'leave')
		insert into LeaveRequests (rid)values (@req);
		else
       if(@type = 'business')
		insert into BusinussRequests(rid) values (@req);
	end

  end

  else
	print('You Do not have suffitient leave days');

  end

  
	

	
  Declare @anual_leaves_man int;

  select @anual_leaves_man = s.total_number_of_leaves
  from Staff_Members s
  where s.username = @username;
  
  Declare @dur int = DATEDIFF (day,@startdate, @enddate  );

  if(@anual_leaves_man - @dur > 0)
  begin

	declare @temp2 int;

	select top 1 @temp2 = r.rid

	from Requests r
	where (@startdate between r.startdate and r.enddate) or (@enddate between r.startdate and r.enddate);

	if(@temp2 is not null)
	print('Cannot Make Your Request');
	else
	begin
  
		insert into Requests (enddate,startdate,staff_Member,request_finalstatus_hr,request_status_manager) values (@enddate,@startdate,@username,'Accepted','Accepted');

		declare @req1 int;
		select @req1 =r.rid
		from Requests r
		where r.enddate = @enddate and r.startdate =@startdate and r.staff_Member = @username;
	
		if(@type = 'leave')
		insert into LeaveRequests(rid) values (@req1);
		else
		insert into BusinussRequests(rid) values (@req1);
	end
 end
  else
	print('You Do not have suffitient leave days');
end


--5 view Requests status 
go
create proc RequestStatus
@username varchar (50)
as
begin
select request_status_manager,request_finalstatus_hr
from Requests
where @username=staff_Member

end


--6 delete any request  i applied for while it in the review process 
go
create proc DeleteRequest
@username varchar (50)
as
begin 
delete 
from Requests
where  (request_status_manager is null or request_finalstatus_hr is null)
end
--7
go
create proc SendEmails
@sender varchar (50),@recepiant varchar(50),@email_subject text, @body text
as
begin
insert into Staff_member_sends_emails  (sender,recipient,email_subject,body)values (@sender,@recepiant,@email_subject,@body);
end
--8 
--  view mails sent to me by other staff members
go
create proc ViewMails
@username varchar(50)
as
begin
select *from Staff_member_sends_emails where @username=recipient
end

--9 replay to mails sent to me 
go
create proc ReplayToMails 
@sender varchar (50),@recepiant varchar(50),@email_subject text, @body text
as
begin
insert into Staff_member_sends_emails  (sender,recipient,subject,body)values (@sender,@recepiant,@email_subject,@body);
end

--10 view announcement 
go
create proc viewAnnouncement 
@username varchar (50)
as

begin

select A.*
from Staff_Members S,Announcements A
where( S.username=@username and S.department_company=A.company)  and ( DATEDIFF(day, A.announcement_date,GETDATE()) < 20)
end


go





--------------------------

/*View new requests from staff members working in my department. Note that only managers with
type = ‘HR’ are allowed to review requests applied for by HR employees, and this manager’s review
is considered the final decision taken for this request, i.e. it does not pass by an HR employee
afterwards.*/ 
go
create proc view_requests(@username varchar(50))
as
begin


if(exists(select * from Managers where username=@username))--this a  manager
begin
	declare @department int ;
	select @department = s.department_code From Staff_Members s where s.username=@username; --department of a manager

	declare @department_company varchar(50);
	select @department_company =department_company from Staff_Members where username=@username;

	declare @manager_type varchar(50);
	select @manager_type = maanger_type from Managers where username=@username ; --type of manager

	if(@manager_type = 'HR')
	begin
		select rid,startdate,enddate,total_no_of_leaves,request_date,replacement_employee,staff_Member,review_by,approving_HR,reason,request_status_manager,request_finalstatus_hr
		from
		Requests r ,Staff_Members s 
		where r.staff_Member=s.username  and  s.department_code=@department and s.department_company=@department_company
		and  r.request_status_manager IS NULL;

		
		;
	end
	else
	begin
		
		select rid,startdate,enddate,total_no_of_leaves,request_date,replacement_employee,staff_Member,review_by,approving_HR,reason,request_status_manager,request_finalstatus_hr
		from
		Requests r ,Staff_Members s 
		where   r.staff_Member=s.username and s.department_code=@department and s.department_company=@department_company and not EXISTS(select * from HR_Employees Hr where Hr.username=r.staff_Member  ) and  (r.request_status_manager) is null;
		
	end
end
end
-------------------------------------------------
/*Accept or reject requests from staff members working in my department before being reviewed by
the HR employee. In case of disapproval, I should provide a reason to be saved.*/
go
create proc accept_reject_request(@username varchar(50),@rid int,@response varchar(10) ,@reason text =null)
as

begin

if(exists(select * from Managers where username=@username))
begin
	declare @department int ;
	select @department = s.department_code From Staff_Members s where s.username=@username; --department of a manager

	declare @department_company varchar(50);
	select @department_company =department_company from Staff_Members where username=@username;

	declare @employee varchar(50);
	select @employee = staff_Member from Requests where rid=@rid;

	declare @department1 int ;
	select @department1 = s.department_code From Staff_Members s where s.username=@employee; --department of a manager

	declare @department_company1 varchar(50);
	select @department_company1 =department_company from Staff_Members where username=@employee;
	if(@department1=@department and @department_company=@department_company1)
	begin
	if(@response='Accepeted')

	update Requests set review_by=@username,request_status_manager='Accepted' where rid=@rid;
	if(@response='Rejected' and @reason  is null) 
	print'Enter a reason please!';

	if(@response='Rejected' and @reason is not null) -- should provide a reason to reject
	update Requests set review_by=@username,request_status_manager='Rejected',reason=@reason where rid=@rid;
end	
end
end




---------------------------------




/*Create a new project in my department with all of its information.*/
go
create proc create_project(@defining_manager varchar(50),@project_name varchar(20),@p_start_date date=null,@p_end_date date=null)

as
begin
if(exists(select * from Managers where username=@defining_manager))
begin
	declare @department_company varchar(50);
	select @department_company=department_company from Staff_Members where username=@defining_manager;--company of the manager
	Insert into Projects Values(@department_company,@project_name,@p_start_date,@p_end_date,@defining_manager)
end
end

--------------------------------------------------------------------------------------------------------------------------------
/*View applications for a specific job in my department that were approved by an HR employee. For
each application, I should be able to check information about the job seeker, job, and the score
he/she got while applying.*/
go





create proc view_applications(@job_id int,@username varchar(50))
as
begin
if(exists(select * from Managers where username=@username))
	begin
	declare @department_company varchar(50);
	select @department_company =department_company from Staff_Members where username=@username;

	declare @department int ;
	select @department = s.department_code From Staff_Members s where s.username=@username; --

	select applicant as jobseeker,job,score from Applications a ,HR_employee_create_job H
	where H.jid=@job_id 
	and a.applicant_status='Accepted' 
	and H.department_code=@department 
	and a.job=@job_id 
	end
end



go
/*Accept or reject job applications to jobs related to my department after being approved by an HR
employee*/

create proc accept_reject_application(@username varchar(50),@a_id int ,@applicant varchar (50),@manager_response varchar(50))
as
begin

if(exists(select * from Managers where username=@username))

begin
	declare @st varchar (50);
	select @st=applicant_status from Applications where a_id=@a_id and applicant=@applicant;

	if(@st='Accepted' and @manager_response='Accepted')
	insert into Accepted_applications values(@applicant,@a_id,'Accepted',@username);
	if(@st='Accepted' and @manager_response='Rejected')
	insert into Accepted_applications values(@applicant,@a_id,'Rejected',@username);

end
end
go
---------------------------------------------









---------------------------------------

go
/*Assign regular employees to work on any project in my department. Regular employees should be
working in the same department. Make sure that the regular employee is not working on more than
two projects at the same time.*/

create proc assign(@username varchar(50),@regular varchar(50),@project_company varchar(50),@project_name varchar(20))
as
begin

if(exists(select * from Managers where username=@username) and exists(select username from Regular_Employees where username=@regular) and exists(select * from Projects where project_company=@project_company and project_name=@project_name ) ) -- if this is a manger and is a regular employee
begin
	declare @department int ;
	select @department = s.department_code From Staff_Members s where s.username=@username;
	declare @dep int ;
	select @dep= department_code from Staff_Members  where username = @regular ;

	declare @department_company1 varchar(50);
	select @department_company1 =department_company from Staff_Members where username=@username;

	declare @department_company2 varchar(50);
	select @department_company2 =department_company from Staff_Members where username=@regular;

	declare @count int ;
	select @count = count(*) from Employees_assignedBy_Managers E where E.employee=@regular

	if(@department_company2=@department_company1 and @dep=@department and (@count<=1))
	begin
	Insert into Employees_assignedBy_Managers values (@regular,@project_name,@project_company);
end
	end
end
-----------------
go

/*
7 Remove regular employees assigned to a project as long as they don’t have tasks assigned to him/her
in this project
*/
create proc remove_regular(@username varchar(50),@project_company varchar(50),@project_name varchar (20))
as
begin

if(exists(select * from Managers where username=@username) and exists(select * from Projects where project_company=@project_company and project_name=@project_name ))
begin

	DELETE Employees_assignedBy_Managers WHERE 
	(NOT EXISTS (SELECT E.employee,E.project_name,E.project_company FROM Employees_assignedBy_Managers E,Tasks T WHERE
				 T.project_company = @project_company and E.project_company=@project_company and E.project_name=@project_name and T.project_name=@project_name and T.employee
				 =E.employee and T.task_name is not null ))
end
end

-----------------------
go
/*8 Define a task in a project in my department which will have status ‘Open’.
*/
create proc define_task(@username varchar(50),@task_name varchar (50) ,
@desription text=null,
@deadline date,
@comment text=null,
@employee  varchar (50),
@project_company varchar (50),
@project_name varchar (20))
as
begin
declare @department int ;
	select @department = s.department_code From Staff_Members s where s.username=@username;
	declare @dep int ;
	select @dep= department_code from Staff_Members  where username = @employee ;

	declare @department_company1 varchar(50);
	select @department_company1 =department_company from Staff_Members where username=@username;

	declare @department_company2 varchar(50);
	select @department_company2 =department_company from Staff_Members where username=@employee;
if(@dep=@department and @department_company1=@department_company2 and exists(select * from Managers where username=@username) and @task_name is not null and @project_company is not null and @project_name is not  null and exists(select * from Company_profiles where email=@project_company ) )
begin
	insert into Tasks values (@task_name,@desription,@deadline,'Open',@comment,@username,@employee,@project_company,@project_name); 
end
end
---------------


go
/*Assign one regular employee (from those already assigned to the project) to work on an already
defined task by me in this project.
*/
create proc assigntask(@username varchar(50),@regular varchar (50), @project_name varchar (20),
 @project_company varchar (50),@taskname varchar (50))
as
begin

if(exists(select * from Managers where username=@username) and exists(select * from Employees_assignedBy_Managers where employee=@regular and project_name=@project_name and project_company=@project_company) and @taskname is not null and @project_name is not null and @project_company is not null  and exists(select * from Tasks where task_name=@taskname and project_name=@project_name and  project_company=@project_company))
begin
	update Tasks set employee=@regular where task_name=@taskname and project_company=@project_company and project_name=@project_name;
end

end
---------------

go
/*11 View a list of tasks in a certain project that have a certain status.
*/
create proc view_tasks(@project_name varchar (20),
 @project_company varchar (50),@task_status varchar (50),@username varchar(50))
 as
 begin

if(exists(select * from Managers where username=@username) and exists(select * from Projects where project_company=@project_company and project_name=@project_name))
begin
	 select * from Tasks T where T.task_status=@task_status and T.project_company=@project_company and T.project_name=@project_name;
 end


 end

 go
 /*Change the regular employee working on a task on the condition that its state is ‘Assigned’, i.e. by assigning it to another regular employee. */

 create proc change_employee(@employee varchar (50), @task_name varchar (50),@project_company varchar (50),@project_name varchar (20) )
 as
 begin 
 if(exists(select * from Tasks where task_name=@task_name and  project_company=@project_company and project_name=@project_name) and exists(select * from Regular_Employees where username=@employee))
 begin
 declare @task_status varchar(50);
 select @task_status = task_status from Tasks where  task_name=@task_name and  project_company=@project_company and project_name=@project_name ;
 if(@task_status='Assigned')
 update Tasks set employee=@employee where task_name=@task_name and  project_company=@project_company and project_name=@project_name;
 

 end

 end












 /*Review a task that I created in a certain project which has a state ‘Fixed’, and either accept or
reject it. If I accept it, then its state would be ‘Closed’, otherwise it will be re-assigned to the same
regular employee with state ‘Assigned’. The task should have now a new deadline.
*/
go
create proc review(@username varchar(50),@task_name varchar (50) ,
@project_company varchar (50),
@project_name varchar (20),@response varchar (50) ,@deadline date=null)
as
begin

if(exists(select * from Managers where username=@username) and exists(select *  from Tasks T where T.task_name=@task_name and T.project_company=@project_company and T.project_name=@project_name))
begin
	declare @task_status varchar(50);
	select @task_status =T.task_status from Tasks T where T.task_name=@task_name and T.project_company=@project_company and T.project_name=@project_name;
	if(@task_status='Fixed')
	begin
	if(@response='Accepted')
	update Tasks  set task_status ='Closed' , employee=null  where task_name=@task_name and  project_company=@project_company and project_name=@project_name;
	if(@response='Rejected')

	update Tasks  set task_status ='Assigned',deadline=@deadline where task_name=@task_name and  project_company=@project_company and project_name=@project_name;

	end


end
end

go



-- MENEBAWY


-- As an HR employee, I should be able to .......
--1 Add a new job that belongs to my department, including all the information needed about the
--job and its interview questions along with their model answers. the title of the added job should
--contain at the beginning the role that will be assigned to the job seeker if he/she was accepted in
--this job; for example: “manager - junior sales manager”

CREATE PROC HR_adds_jobs

@title VARCHAR(50),
@short_description text ,
@detailed_description text ,
@number_of_vacancies int ,
@application_deadline Datetime ,
@salary float ,
@working_hours int ,
@minimum_experience_years int ,
@hr_employee VARCHAR(50) 


AS
IF @title IS NULL or @short_description IS NULL or @detailed_description IS NULL or
@number_of_vacancies IS NULL or @application_deadline IS NULL or @salary IS NULL or  
@working_hours IS NULL or @minimum_experience_years IS NULL or @hr_employee IS NULL 
print 'One of the inputs is null'
Else
IF @title NOT LIKE '%-%'
print 'Title is not in correct format'
Else
begin 

INSERT INTO Jobs(title, short_description, detailed_description, number_of_vacancies, application_deadline, salary, working_hours, minimum_experience_years)
VALUES(@title, @short_description, @detailed_description, @number_of_vacancies, @application_deadline, @salary, @working_hours, @minimum_experience_years )

DECLARE @department_Company VARCHAR(50)
DECLARE @department_code int 
SELECT @department_code = staffm.department_code, @department_Company = staffm.department_company
FROM Staff_Members staffm
	INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

DECLARE @jid int
SELECT @jid = job_id
FROM Jobs 
WHERE title = @title

INSERT INTO HR_employee_create_job(jid, department_Company, department_code,hr_employee)
VALUES (@jid, @department_Company, @department_code, @hr_employee)

end

go
-- add interview questions to a job
CREATE PROC HR_adds_interviewquestion

@hr_employee VARCHAR(50) ,
@question text,
@answer text ,
@job_title varchar (50)

AS
IF  @hr_employee IS NULL or @question IS NULL or @answer IS NULL or @job_title IS NULL
print 'One of the inputs is null'
Else
BEGIN

DECLARE @jid INT
SELECT @jid = job_id
FROM Jobs 
WHERE  title = @job_title

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
	INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee


IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code 
print 'This job is from a different department'
ELSE

INSERT INTO Interview_questions(question, answer, job )
VALUES (@question, @answer, @jid)

END

go

--2 View information about a job in my department.

 CREATE PROC HR_view_job
@input_title varchar (50),
@hr_employee VARCHAR(50) 

AS
IF @input_title IS NULL or @hr_employee IS NULL 
print 'One of the inputs is null'
Else
begin

DECLARE @jid int
SELECT @jid = job_id
FROM Jobs 
WHERE  title = @input_title

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
DECLARE @JOB_creator_hr VARCHAR(50)
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code, @JOB_creator_hr = hr_employee
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code
print 'This job is from a different department'
ELSE
begin

SELECT  job_id , title, short_description,  detailed_description, number_of_vacancies, application_deadline, salary, working_hours, minimum_experience_years, 
		HCJ.department_Company, HCJ.department_code, HCJ.hr_employee as 'HR employee creating job'
FROM Jobs j
	INNER JOIN HR_employee_create_job HCJ ON HCJ.jid = j.job_id
WHERE  @jid = j.job_id

-- outputs a table of questions
SELECT question, answer
FROM Interview_questions
WHERE job = @jid

END
END

go

--3 Edit the information of a job in my department.

CREATE PROC HR_edit_job
@input_title varchar (50),
@hr_employee VARCHAR(50) ,
@title varchar (50) ,
@short_description text ,
@detailed_description text ,
@number_of_vacancies int ,
@application_deadline date ,
@salary float ,
@working_hours int ,
@minimum_experience_years int ,
@department_code int 

AS
IF @title IS NULL and @short_description IS NULL and @detailed_description IS NULL and
@number_of_vacancies IS NULL and @application_deadline IS NULL and @salary IS NULL and  
@working_hours IS NULL and @minimum_experience_years IS NULL  and 
@department_code  IS NULL
print 'At least one input should has a value'
ELSE
BEGIN

DECLARE @jid INT
SELECT @jid = job_id
FROM Jobs 
WHERE  title = @input_title

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
	INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code
print 'This job is from a different department'
ELSE
begin
 
if @title !=''
update Jobs 
set title = @title
where job_id = @jid

if CONVERT(VARCHAR, @short_description) !=''
update Jobs 
set  short_description = @short_description
where job_id = @jid

if CONVERT(VARCHAR, @detailed_description) !=''
update Jobs 
set  detailed_description = @detailed_description
where job_id = @jid

if @number_of_vacancies !=''
update Jobs 
set number_of_vacancies = @number_of_vacancies
where job_id = @jid

if @application_deadline !=''
update Jobs 
set application_deadline = @application_deadline
where job_id = @jid

if @salary !=''
update Jobs 
set salary = @salary
where job_id = @jid

if @working_hours !=''
update Jobs 
set working_hours = @working_hours
where job_id = @jid

if @minimum_experience_years !=''
update Jobs 
set minimum_experience_years = @minimum_experience_years 
where job_id = @jid

if @department_code !=''
update HR_employee_create_job 
set department_code = @department_code 
where jid = @jid

END
END

go
-- delete interview question for a job
CREATE PROC HR_delete_interviewquestion

@input_title varchar (50),
@hr_employee VARCHAR(50) ,
@question_id int

AS
IF @input_title IS NULL or @hr_employee IS NULL or @question_id IS NULL 
print 'One of the inputs is null'
Else
begin

DECLARE @jid int
SELECT @jid = job_id
FROM Jobs 
WHERE  title = @input_title

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
	INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code
print 'This job is from a different department'
ELSE
begin


DELETE FROM Interview_questions
WHERE qid = @question_id

END
END

go

--4 View new applications for a specific job in my department. For each application, I should be able
--to check information about the job seeker, job, the score he/she got while applying.

CREATE PROC HR_view_applications
@input_title varchar (50),
@hr_employee VARCHAR(50) 

AS
IF @input_title IS NULL or @hr_employee IS NULL 
print 'One of the inputs is null'
Else
begin

DECLARE @jid int
SELECT @jid = job_id
FROM Jobs 
WHERE  title = @input_title

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code
print 'This job is from a different department'
ELSE

SELECT app.a_id, app.score, app.applicant_status, app.checking_HR_employee, js.username, js.birth_date, js.age, 
	CONCAT(js.first_name, ' ',js.middle_name,' ', js.last_name) as 'Name', js.personal_email, js.experience_years, j.*
FROM Applications app
	INNER JOIN Job_Seekers js ON js.username = app.applicant
	INNER JOIN Jobs j ON j.job_id = app.job
WHERE app.job = @jid 

END

go

--5 Accept or reject applications for jobs in my department.

CREATE PROC HR_checks_applications

@applicant varchar (50) ,
@a_id int,
@hr_employee VARCHAR(50) ,
@hr_response VARCHAR(50)

AS
IF @applicant IS NULL or @a_id IS NULL or @hr_employee IS NULL or @hr_response is null
print 'One of the inputs is null'
Else
begin

DECLARE @jid int
SELECT @jid = job
FROM Applications
WHERE a_id = @a_id and applicant = @applicant

DECLARE @JOB_department_Company VARCHAR(50)
DECLARE @JOB_department_code int
SELECT @JOB_department_Company = department_Company, @JOB_department_code = department_code
FROM HR_employee_create_job 
WHERE jid = @jid

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @JOB_department_Company <> @HR_department_Company or @JOB_department_code <> @HR_department_code
print 'This job is from a different department'
ELSE

UPDATE Applications
SET applicant_status = @hr_response, checking_HR_employee = @hr_employee
WHERE applicant = @applicant and a_id = @a_id 

END

go

--6 Post announcements related to my company to inform staff members about new updates.

CREATE PROC HR_post_announcement

@hr_employee VARCHAR(50) ,
@title VARCHAR(50) ,
-- @announcement_date datetime ,
@announcement_type VARCHAR(50) ,
@announcement_description TEXT 

AS
IF @hr_employee IS NULL or @title IS NULL or @announcement_type IS NULL or @announcement_description IS NULL 
print 'One of the inputs is null'
Else
begin

DECLARE @HR_department_Company VARCHAR(50)
SELECT  @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

INSERT INTO Announcements ( title, announcement_type, announcement_description, company, maker )
VALUES (@title, @announcement_type, @announcement_description, @HR_department_Company, @hr_employee)

END

go

--7 View requests (business or leave) of staff members working with me in the same department that
--were approved by a manager only.

CREATE PROC HR_view_requests
@hr_employee VARCHAR(50)  

AS
DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
    INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

SELECT req.* 
FROM Requests req
    INNER JOIN Staff_Members staffm ON req.staff_Member = staffm.username
WHERE staffm.department_company = @HR_department_Company and staffm.department_code = @HR_department_code
    and req.request_status_manager = 'Accepted' and req.request_finalstatus_hr is NULL
go

--8 Accept or reject requests of staff members working with me in the same department that were
--approved by a manager. My response decides the final status of the request, therefore the annual
--leaves of the applying staff member should be updated in case the request was accepted. Take into
--consideration that if the duration of the request includes the staff member’s weekly day-off and/or
--Friday, they should not be counted as annual leaves.

CREATE PROC HR_checks_requests
@rid int,
@hr_employee VARCHAR(50) ,
@hr_response VARCHAR(50)
AS

IF @rid IS NULL or @hr_employee IS NULL or @hr_response IS NULL
print 'One of the inputs is null'
Else
begin
DECLARE @request_finalstatus_hr varchar(20)
DECLARE @manager_response varchar(20)
DECLARE @staff_Member varchar(50)
DECLARE @request_total_number_of_leaves int----------
DECLARE @startdate date -----------------
SELECT @staff_Member = staff_Member, @manager_response = request_status_manager, @request_total_number_of_leaves = total_no_of_leaves,
	@request_finalstatus_hr = request_finalstatus_hr , @startdate = startdate 
FROM Requests
WHERE rid = @rid

if @manager_response <> 'Accepted'
print 'This request is not approved by the manager'
ELSE
if @request_finalstatus_hr = 'Accepted'
print 'This request is already accepted'
ELSE
BEGIN

DECLARE @department_Company VARCHAR(50)
DECLARE @department_code int 
DECLARE @day_off VARCHAR(10)-----------
DECLARE @total_number_of_leaves int-------------
SELECT @department_code = department_code, @department_Company = department_company, @day_off = day_off, @total_number_of_leaves = total_number_of_leaves
FROM Staff_Members
WHERE username = @staff_Member

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @department_Company <> @HR_department_Company or @department_code <> @HR_department_code
print 'This request is presented by employee from a different department'
ELSE
BEGIN

UPDATE Requests
SET request_finalstatus_hr = @hr_response, approving_HR = @hr_employee
WHERE rid = @rid

DECLARE @day varchar(10)
DECLARE @startdate_name varchar(10)
SELECT @startdate_name = DATENAME(dw, @startdate) 

declare @i int
set @i = 1
while @i <= @request_total_number_of_leaves%7
begin
select @day = DATENAME(dw, DATEADD(day, @i, @startdate))
if @day <> 'FRIDAY' and @day <> @day_off
set @total_number_of_leaves = @total_number_of_leaves - 1
set @i = @i +1
end

DECLARE @working_weekdays int
IF @day_off is null
set @working_weekdays = 6
ELSE
SET @working_weekdays = 5

IF ( @request_total_number_of_leaves / 7 ) <> 0
SET @total_number_of_leaves = @total_number_of_leaves - ( @request_total_number_of_leaves / 7 ) * @working_weekdays

UPDATE Staff_Members
SET total_number_of_leaves =  @total_number_of_leaves 
WHERE username = @staff_Member

END
END
END

go

--9 View the attendance records of any staff member in my department (check-in time, check-out time,
--duration, missing hours) within a certain period of time.

CREATE PROC HR_checks_attendence_of_staffm

@hr_employee VARCHAR(50) ,
@staff_member VARCHAR(50),
@start_check_date date,
@end_check_date date

AS
IF @hr_employee IS NULL or @staff_member IS NULL or @start_check_date IS NULL or @end_check_date IS NULL 
print 'One of the inputs is null'
Else
begin

DECLARE @staffm_department_Company VARCHAR(50)
DECLARE @staffm_department_code int 
SELECT @staffm_department_code = department_code, @staffm_department_Company = department_company
FROM Staff_Members 
WHERE username = @staff_member

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @staffm_department_Company <> @HR_department_Company or @staffm_department_code <> @HR_department_code
print 'This staff member is from a different department'
ELSE
begin

DECLARE @jid INT
SELECT @jid = job
FROM Staff_Members
WHERE username = @staff_member

DECLARE @working_hours INT
SELECT @working_hours = working_hours
FROM Jobs
WHERE job_id = @jid

Select  attendance_date,  start_time,  end_time, DATEDIFF(HOUR, start_time, end_time ) AS duration,
	( DATEDIFF(HOUR, start_time, end_time ) - @working_hours) AS 'missing hours'
FROM Attendances
WHERE  staff_username = @staff_member and attendance_date >= @start_check_date and attendance_date <= @end_check_date

END
END

go

--10 View the total number of hours for any staff member in my department in each month of a certain
--year.

CREATE PROC HR_checks_total_hours_staffm
@hr_employee VARCHAR(50) ,
@staff_member VARCHAR(50),
@target_year int

AS
IF @hr_employee IS NULL or @staff_member IS NULL or @target_year IS NULL  
print 'One of the inputs is null'
Else
begin

DECLARE @staffm_department_Company VARCHAR(50)
DECLARE @staffm_department_code int 
SELECT @staffm_department_code = department_code, @staffm_department_Company = department_company
FROM Staff_Members 
WHERE username = @staff_member

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
	INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee

IF @staffm_department_Company <> @HR_department_Company or @staffm_department_code <> @HR_department_code
print 'This staff member is from a different department'
ELSE

SELECT MONTH(attendance_date) AS 'MONTH', SUM(DATEDIFF(HOUR, start_time, end_time ) ) AS 'Month working hours'
FROM  Attendances
WHERE staff_username = @staff_member and YEAR(attendance_date) = @target_year
GROUP BY MONTH(attendance_date)

END

go

--11 View names of the top 3 high achievers in my department. A high achiever is a regular employee
--who stayed the longest hours in the company for a certain month and all tasks assigned to him/her
--with deadline within this month are fixed.

CREATE PROC HR_decides_topachievers
@hr_employee VARCHAR(50) ,
--1/Month/Year
@target_month date 

AS
DECLARE @start_check_date DATE
DECLARE @end_check_date DATE
SET @start_check_date = @target_month 
SET @end_check_date = DATEADD( DAY, -1, (DATEADD(MONTH, 1, @target_month)) ) 

DECLARE @HR_department_Company VARCHAR(50)
DECLARE @HR_department_code int 
SELECT @HR_department_code = staffm.department_code, @HR_department_Company = staffm.department_company
FROM Staff_Members staffm
    INNER JOIN HR_Employees HRe ON  staffm.username = HRe.username
WHERE HRe.username = @hr_employee;


with temp AS 
(
SELECT username
FROM Regular_Employees
EXCEPT
	(
	SELECT employee
	FROM Tasks
	WHERE deadline >= @target_month AND deadline < (DATEADD(MONTH, 1, @target_month)) AND task_status <> 'FIXED'
	)
)

SELECT TOP 3 staffm.username, CONCAT(staffm.first_name, ' ', staffm.middle_name, ' ', staffm.last_name) AS 'Regular Employee Name' 
     -- SUM(DATEDIFF(HOUR, start_time, end_time ) ) AS 'Month working hours'
FROM 
 Attendances att
    INNER JOIN Regular_Employees reg ON att.staff_username = reg.username
    INNER JOIN Staff_Members staffm ON  reg.username = staffm.username
    INNER JOIN temp ON temp.username = staffm.username
WHERE staffm.department_company = @HR_department_Company and staffm.department_code = @HR_department_code
    and att.attendance_date >= @start_check_date and att.attendance_date <= @end_check_date
--GROUP BY staffm.username
--ORDER BY 'Month working hours' DESC


go

--“As a regular employee, I should be able to ...”

--1 View a list of projects assigned to me along with all of their information.

CREATE PROC RE_view_projects 
@re_username varchar(50)

AS
IF @re_username IS NULL
print 'missing parameter'
ELSE
BEGIN
DECLARE @username varchar(50)
SELECT @username = username
FROM Regular_Employees 
WHERE username = @re_username

IF @username IS NULL
print 'unauthorized to view these details'
ELSE
SELECT *
FROM Projects p
    INNER JOIN Employees_assignedBy_Managers EAM  ON EAM.project_company = p.project_company AND EAM.project_name = p.project_name
WHERE EAM.employee = @re_username

END 


go

--2 View a list of tasks in a certain project assigned to me along with all of their information and status.


CREATE PROC RE_view_tasks
@re_username varchar(50) ,
@project_company varchar(50) ,
@project_name varchar(20)

AS
IF @re_username IS NULL or @project_company IS NULL or @project_name IS NULL
print 'missing parameter'
ELSE

BEGIN
DECLARE @username varchar(50)
SELECT @username = username
FROM Regular_Employees 
WHERE username = @re_username

IF @username IS NULL
print 'unauthorized to view these details'
ELSE
SELECT *
FROM Tasks
WHERE employee = @re_username AND project_company = @project_company AND  project_name = @project_name 

END 

go



