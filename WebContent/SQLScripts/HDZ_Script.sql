drop table HDZ_interviewresp;
drop table HDZ_award;
drop table HDZ_codingquest;
drop table HDZ_interviewquest;
drop table HDZ_interview;
drop table HDZ_application;
drop table HDZ_jobhistory;
drop table HDZ_Education;
drop table HDZ_reftable;
drop table HDZ_jobs;
drop table HDZ_skillappbridge;
drop table HDZ_skills;
drop table HDZ_Applicant;
drop table HDZ_employee;

drop sequence hdz_interviewresp_id_seq;
drop sequence hdz_award_id_seq;
drop sequence hdz_codingquest_id_seq;
drop sequence hdz_interviewquest_id_seq;
drop sequence hdz_interview_id_seq;
drop sequence hdz_application_id_seq;
drop sequence hdz_jobhistory_id_seq;
drop sequence hdz_education_id_seq;
drop sequence hdz_reftable_id_seq;
drop sequence hdz_jobs_id_seq;
drop sequence hdz_skillappbridge_id_seq;
drop sequence hdz_skill_id_seq;
drop sequence hdz_applicant_id_seq;
drop sequence hdz_employee_id_seq;

create sequence  hdz_interviewresp_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_award_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_codingquest_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_interviewquest_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_interview_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_applicant_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_education_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_jobhistory_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_reftable_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_jobs_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_skillappbridge_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_skill_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_application_id_seq start with 1 increment by 1 nocache;
create sequence  hdz_employee_id_seq start with 1 increment by 1 nocache;


create table HDZ_employee(
employeeid integer primary key,
empname varchar2(50) ,
email varchar2(100) ,
hashedpwd varchar2(200) ,
salt varchar2(200),
position varchar2(100) 
);

create table HDZ_Applicant (
applicantID integer primary key,
email varchar2(50) unique ,
hashedpwd varchar2(200) ,
salt varchar2(200),
firstname varchar2(100) ,
lastname varchar2(100) ,
bday varchar2(100) ,
citizenflag varchar2(1),
citizen varchar2(100) ,
visaflag varchar2(1),
visa varchar2(100) ,
veteranflag varchar2(1),
veteran varchar2(100) ,
drugtestflag varchar2(1),
drugtest varchar2(100) ,
stdpanelflag varchar2(1),
stdpanel varchar2(100) ,
dottestflag varchar2(1),
dottest varchar2(100) ,
alcoholtestflag varchar2(1),
alcoholtest varchar2(100),
careerobj varchar2(100),
appsummary varchar2(100),
phonenum integer,
employeeid integer,
CONSTRAINT fk_HDZ_Applicant_employeeID FOREIGN KEY (employeeID) references HDZ_employee(employeeID)
);

create table HDZ_Education(
educationid integer primary key,
educationflag varchar2(1),
applicantid integer,
schoolname varchar2(200) ,
degreecompleted varchar2(100),
datecompleted varchar2(100),
CONSTRAINT fk_HDZ_Education_applicantID FOREIGN KEY (applicantID) references HDZ_Applicant(applicantID)
);

create table HDZ_jobhistory(
jobhistoryid integer primary key,
jobhistoryflag varchar2(1),
applicantid integer,
position varchar2(50) ,
companyname varchar2(200) ,
startdate varchar2(100) ,
enddate varchar2(100),
description varchar2(100) ,
CONSTRAINT fk_jobhistory_applicantID FOREIGN KEY (applicantID) references HDZ_applicant(applicantID)
);

create table HDZ_reftable(
refid integer primary key,
refflag varchar2(1),
applicantid integer,
refname varchar2(50) ,
refemail varchar2(200) ,
refphone varchar2(200) ,
refposition varchar2(200) ,
CONSTRAINT fk_HDZ_reftable_applicantID FOREIGN KEY (applicantID) references HDZ_applicant(applicantID)
);

create table HDZ_skills(
skillid integer primary key,
skillname varchar2(100)
);

create table HDZ_Jobs(
jobsid integer primary key,
position varchar2(50) ,
description varchar2(200),
skillid integer,
codingtestreq varchar2(100),
CONSTRAINT fk_HDZ_skills_skillID FOREIGN KEY (skillID) references HDZ_skills(skillID)
);

create table HDZ_application(
applicationid integer primary key,
applicantid integer ,
codingtest varchar2(1) ,
jobsid integer ,
appstatus varchar2(50) ,
comments varchar2(500) ,
appscore integer default null,
codingtestscore integer,
CONSTRAINT fk_HDZ_application_applicantID FOREIGN KEY (applicantID) references HDZ_applicant(applicantID),
CONSTRAINT fk_HDZ_application_jobsID FOREIGN KEY (jobsID) references HDZ_jobs(jobsID)
);

create table HDZ_skillappbridge(
skillappbridgeid integer primary key,
skillid integer,
applicantid integer,
experience varchar2(200),
CONSTRAINT fk_HDZ_skillappbri_applicantID FOREIGN KEY (applicantID) references HDZ_applicant(applicantID),
CONSTRAINT fk_HDZ_skillappbri_skillid FOREIGN KEY (skillid) references HDZ_skills(skillid)
);

create table HDZ_award(
awardid integer primary key,
awardname varchar2(100),
awardyear varchar2(100),
applicantid integer,
CONSTRAINT fk_award_applicantID FOREIGN KEY (applicantID) references HDZ_applicant(applicantID)
);

create table HDZ_codingquest(
codingquestid integer primary key,
question varchar2(200),
answer varchar2(200)
);

create table HDZ_interviewquest(
interviewquestid integer primary key,
jobsid integer,
interviewtype varchar2(100),
question varchar2(200),
CONSTRAINT fk_HDZ_interviewquest_jobsID FOREIGN KEY (jobsid) references HDZ_jobs(jobsid)
);

create table HDZ_interview(
interviewid integer primary key,
interviewtype varchar2(100),
score integer default null,
applicationid integer,
CONSTRAINT fk_HDZ_interview_applicationID FOREIGN KEY (applicationID) references HDZ_application(applicationID)
);

create table HDZ_interviewresp(
interviewrespid integer primary key,
applicationid integer,
interviewquestid integer,
interviewtype varchar2(100),
questionflag varchar(1),
CONSTRAINT fk_HDZ_interresp_applicationID FOREIGN KEY (applicationID) references HDZ_application(applicationID),
CONSTRAINT fk_HDZ_inresp_interviewquestid FOREIGN KEY (interviewquestid) references HDZ_interviewquest(interviewquestid)
);

commit;
