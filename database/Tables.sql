
create table Job_Seekers(
username varchar(50) primary key,
passwd varchar(50) not null ,
personal_email varchar(50),
birth_date date,
first_name varchar(20),
middle_name varchar(20),
last_name varchar (20),
experience_years int,
age as year(current_timestamp) - year(birth_date)
);

-- the jid is an identity &TITLE unique
create table Jobs 
( 
job_id int IDENTITY primary key ,
title varchar (50) unique,
short_description text ,
detailed_description text ,
number_of_vacancies int ,
application_deadline date ,
salary float ,
working_hours int ,
minimum_experience_years int 
);



 CREATE Table Company_profiles ( 
    email VARCHAR(50) PRIMARY KEY,
    company_name VARCHAR(20) NOT NULL,
    company_address varchar(100) NOT NULL,
    domain_name VARCHAR(20) NOT NULL,
    company_type VARCHAR(50),
    vision VARCHAR(50),
    field_of_spec VARCHAR(50)   
);

--the department code in not an IDENTITY
 CREATE Table Departments (
    department_code int ,
    department_company VARCHAR(50),
    department_name VARCHAR(50) NOT NULL,
    PRIMARY KEY(department_company, department_code),
    FOREIGN KEY(department_company) REFERENCES Company_profiles ON DELETE CASCADE ON UPDATE CASCADE
);


create table Staff_Members(
username varchar(50) primary key,
passwd varchar(50) not null,
personal_email varchar(50),
birth_date date,
first_name varchar(20),
middle_name varchar(20),
last_name varchar (20),
salary float ,
company_email varchar(50),
day_off varchar(10),
total_number_of_leaves int,
experience_years int,
age as year(current_timestamp) - year(birth_date),
department_code int,
department_company varchar(50),
job int foreign key REFERENCES Jobs on update cascade on delete cascade,
foreign key(department_company,department_code) references Departments on delete cascade on update cascade,
);


create table HR_Employees(
username varchar (50) foreign key references Staff_Members on delete cascade on update cascade,
primary key (username),
);

create table Managers(
username varchar (50) foreign key references Staff_Members on delete cascade on update cascade,
primary key (username),
);


create table Regular_Employees(
username varchar (50) foreign key references Staff_Members on delete cascade on update cascade,
primary key (username),
);

-- the default value of the status is pending
create table Applications
(
applicant varchar (50) foreign key references  Job_Seekers,
a_id int identity,
score int ,
applicant_status varchar (50) DEFAULT 'PENDING',
checking_HR_employee varchar(50) foreign key  references HR_employees,
job int foreign key references Jobs not null ,
primary key (applicant,a_id)
);

create table Projects (
project_company varchar(50) foreign key references Company_Profiles on delete cascade on update cascade,
project_name varchar(20),
p_start_date date ,
p_end_date date,
defining_manager varchar(50) foreign key references Managers,
primary key (project_company,project_name),
);


--the task primary key is its name, and the 2 project primary keys
create table Tasks
(
task_name varchar (50) ,
desription text,
deadline date,
task_status varchar(50) DEFAULT 'Open',
comment text,
defining_Manager varchar(50) foreign key references  Managers,
employee  varchar (50) foreign key references  Regular_Employees,
project_company varchar (50) not null,
project_name varchar (20) not null,
foreign key (project_company,project_name) references Projects , 
primary key (task_name, project_company, project_name)
);



-- 2 attributes are added the hr_response and the hr_checking the requests
 create table Requests(
rid INT IDENTITY Primary Key,
startdate Date ,
enddate Date , 
total_no_of_leaves as DATEDIFF (day, startdate,  enddate) ,
request_date Date Default getDate() ,
replacement_employee varchar(50) , 
staff_Member varchar(50) ,
review_by varchar(50),
approving_HR varchar(50),
reason text,
request_status_manager varchar(10) , --manager response
request_finalstatus_hr varchar(10) , --HR response
FOREIGN KEY (approving_HR) REFERENCES HR_employees,
FOREIGN KEY (replacement_employee) REFERENCES Staff_Members,
FOREIGN KEY (staff_Member) REFERENCES Staff_Members,
FOREIGN KEY (review_by) REFERENCES Managers,
);


create table Staff_members_previous_jobs(
staff_member varchar(50) foreign key references Staff_Members on delete cascade on update cascade, 
previous_job_titles varchar (50),
primary key (staff_member,previous_job_titles),
);

create table Job_seeker_previous_jobs(
job_seeker varchar(50) foreign key references Job_Seekers on delete cascade on update cascade, 
previous_job_titles varchar (50),
primary key (job_seeker,previous_job_titles),
);



create table Employees_assignedBy_Managers(
employee varchar (50) foreign key references Regular_Employees,
project_name varchar (20),
project_company varchar (50),
foreign key (project_company,project_name) references Projects,
primary key (employee , project_company , project_name)
);


create table Accepted_applications
(
applicant varchar(50),
a_id int,
manager_response varchar(50),
checking_manager varchar(50) foreign key references Managers,
primary key (applicant,a_id),
foreign key (applicant,a_id) references Applications,
check (dbo.Application_Status(applicant,a_id) = '1' ),

);

 CREATE Table HR_employee_create_job (
    jid int PRIMARY KEY,
    department_Company VARCHAR(50) NOT NULL,
    department_code int NOT NULL,
    hr_employee VARCHAR(50) DEFAULT 'UNKNOWN' NOT NULL,
    FOREIGN KEY(jid) REFERENCES Jobs,    
    FOREIGN KEY(department_Company, department_code) REFERENCES Departments,
    FOREIGN KEY(hr_employee) REFERENCES HR_employees
 );


 CREATE Table Interview_questions (
    qid int IDENTITY PRIMARY KEY , 
    question TEXT, 
    answer TEXT, 
    job int NOT NULL,
    FOREIGN KEY(job) REFERENCES Jobs ON DELETE CASCADE ON UPDATE CASCADE    
 );



CREATE Table Phone_numbers (
    ph_number int NOT NULL,
    company VARCHAR(50),
    PRIMARY KEY(company, ph_number),
    FOREIGN KEY(company) REFERENCES Company_profiles ON DELETE CASCADE ON UPDATE CASCADE
);



 CREATE Table Announcements (
    announcement_ID int IDENTITY PRIMARY KEY ,  
    title VARCHAR(50) NOT NULL,
    announcement_date datetime NOT NULL,
    announcement_type VARCHAR(50),
    announcement_description TEXT,
    company VARCHAR(50) NOT NULL,
    maker VARCHAR(50) DEFAULT 'UNKNOWN' NOT NULL,
    FOREIGN KEY(company) REFERENCES Company_profiles,
    FOREIGN KEY(maker) REFERENCES HR_employees
 );



-- the start and end times of an attendance should be of Datetime type not date to record the time
CREATE TABLE Attendances(

attendance_date Date , 
staff_username varchar(50) ,
start_time Datetime,
end_time Datetime ,
PRIMARY KEY (attendance_date, staff_username),
FOREIGN KEY (staff_username) REFERENCES Staff_members,
);


create table Attendances_checkedBy_HR_Employees(
hr_username varchar(50),
attendance_date Date, 
staff_username varchar(50),
PRIMARY KEY (attendance_date, staff_username,hr_username),    
FOREIGN KEY (hr_username) REFERENCES HR_employees,
FOREIGN KEY (attendance_date,staff_username) REFERENCES Attendances,
);



create table LeaveRequests(
rid int Primary Key,
request_type text ,
FOREIGN KEY (rid) REFERENCES Requests,
);

create table BusinussRequests(
rid int primary key,  
trip_destination text,
purpose text,
FOREIGN KEY (rid) REFERENCES Requests
);

create Table Staff_member_sends_emails(
    sender VARCHAR(50),
    recipient VARCHAR(50),
    email_timestamp datetime default current_timestamp,
    email_subject text,
    body text,
    PRIMARY KEY(sender, recipient, email_timestamp ),
    FOREIGN KEY(sender) REFERENCES  Staff_Members    ,   
    FOREIGN KEY(recipient) REFERENCES  Staff_Members       
);