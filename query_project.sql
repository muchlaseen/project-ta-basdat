##### MODUL 1 #####

CREATE TABLESPACE muchlasin_06941_md1
datafile 'C:\Users\Achmad Muchlasin\praktikum_basdat\outsourcing.dbf'
size 30M;

CREATE USER muchlasin06941
IDENTIFIED BY muchlas
DEFAULT TABLESPACE muchlasin_06941_md1
QUOTA 30M ON muchlasin_06941_md1;

GRANT ALL PRIVILEGES TO muchlasin06941;

CREATE TABLE employee(
    id_employee int not null,
    employee_name varchar2(30),
    employee_addr varchar2(100),
    gender varchar2(3),
    phone_no number(12),
    email varchar(30),
    CONSTRAINT PK_employee PRIMARY KEY (id_employee)
);

CREATE TABLE client(
    id_client int not null,
    client_name varchar2(30),
    client_addr varchar2(100),
    client_email varchar(30),
    client_phone_no number(12),
    CONSTRAINT PK_client PRIMARY KEY (id_client)
);

CREATE TABLE job(
    id_job int not null,
    id_client int,
    job_name varchar2(50),
    category varchar2(30),
    description varchar2(100),
    CONSTRAINT PK_job PRIMARY KEY (id_job)
);

CREATE TABLE project(
    id_project int not null,
    id_job int,
    id_employee int,
    start_date date,
    end_date date,
    CONSTRAINT PK_project PRIMARY KEY (id_project)
);

ALTER TABLE job
add CONSTRAINT FK_job_client FOREIGN KEY (id_client)
REFERENCES client (id_client);

ALTER TABLE project
add CONSTRAINT FK_project_employee FOREIGN KEY (id_employee)
REFERENCES employee (id_employee)
add CONSTRAINT FK_project_job FOREIGN KEY (id_job)
REFERENCES job (id_job);

CREATE SEQUENCE id_project 
MINVALUE 1
MAXVALUE 100
START WITH 1
INCREMENT BY 1
CACHE 20;

SELECT * FROM EMPLOYEE;

SELECT * FROM CLIENT;

SELECT * FROM JOB JOIN CLIENT ON JOB.ID_CLIENT = CLIENT.ID_CLIENT;

CREATE OR REPLACE VIEW JOB_FROM_CLIENT_V AS 
SELECT JOB.ID_JOB, JOB.JOB_NAME, JOB.DESCRIPTION, CLIENT.ID_CLIENT, CLIENT.CLIENT_NAME FROM JOB INNER JOIN CLIENT
ON JOB.ID_CLIENT = CLIENT.ID_CLIENT;

SELECT * FROM JOB_FROM_CLIENT_V;

SELECT PROJECT.ID_PROJECT, JOB.JOB_NAME, EMPLOYEE.EMPLOYEE_NAME, PROJECT.START_DATE, PROJECT.END_DATE FROM PROJECT JOIN JOB 
ON PROJECT.ID_JOB = JOB.ID_JOB JOIN EMPLOYEE ON PROJECT.ID_EMPLOYEE = EMPLOYEE.ID_EMPLOYEE 
ORDER BY PROJECT.ID_PROJECT ASC;

##### MODUL 2 #####

### TABLE EMPLOYEE ###
INSERT INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (101, 'Muchlas', 'Dusun Duran Sedati', 'L', '8124186', 'muchlas@gmail.com');
INSERT INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (102, 'Sterling', 'Surabaya Sukolilo', 'L', '8225045', 'sterling@gmail.com');

INSERT ALL
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (103, 'Naura', 'Rungkut Surbaya', 'P', '8774501', 'naura@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (104, 'Alya', 'WR Supratman Surabaya', 'P', '85643801', 'alya@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (105, 'John', 'Gedangan Sidoarjo', 'L', '811345716', 'john@gmail.com')
SELECT 1 FROM dual;

### TABLE CLIENT ###
INSERT INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (11, 'Hexamedika', 'Rungkut Surabaya', 'admin@hexa.co.id', '14041');
INSERT INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (12, 'Ekalya Vessel', 'Darmo Surabaya', 'hrd@ekalya.co.id', '14042');

INSERT ALL
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (13, 'Avodamitra', 'Semampir Sidoarjo', 'hrd@avoda.co.id', '14043')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (14, 'Golden Union', 'Jabon Sidoarjo', 'hr.ga@golden.co.id', '14044')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (15, 'Orela Shipyard', 'Pangkah Gresik', 'support@orela.co.id', '14045')
SELECT 1 FROM dual;

### TABLE JOB ###
INSERT INTO job (id_job, id_client, job_name, category, description) values (1101, 11, 'Network Administrator', 'IT', 'Manage and monitoring network');
INSERT INTO job (id_job, id_client, job_name, category, description) values (1102, 12, 'Front-End Developer', 'IT', 'Design and develop UI Website');

INSERT ALL
INTO job (id_job, id_client, job_name, category, description) values (1103, 13, 'RAC Engineer', 'Engineer', 'Install and maintain cooling system')
INTO job (id_job, id_client, job_name, category, description) values (1104, 14, 'Accounting Staff', 'Finance', 'Reviewing financial statement')
INTO job (id_job, id_client, job_name, category, description) values (1105, 15, 'QA/QC Vessel', 'Engineer', 'Inspect and test materials')
SELECT 1 FROM dual;

### TABLE PROJECT ###
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1101, 101, to_date('01/05/2020', 'dd/mm/yyyy'), to_date('20/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1102, 102, to_date('02/05/2020','dd/mm/yyyy'), to_date('10/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1103, 103, to_date('03/05/2020', 'dd/mm/yyyy'), to_date('30/05/2020', 'dd/mm/yyyy'))
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1104, 104, to_date('04/05/2020', 'dd/mm/yyyy'), to_date('20/05/2020', 'dd/mm/yyyy'))
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1105, 103, to_date('05/05/2020', 'dd/mm/yyyy'), to_date('15/05/2020', 'dd/mm/yyyy'))


UPDATE job
SET id_client = 15,
job_name = 'QA Vessel',
category = 'Vessel Engineer',
description = 'quality assessment'
WHERE id_job = 1103;

UPDATE client
SET client_name = 'Hexamedika Corp',
client_addr = 'Rungkut Industri Surabaya',
client_email = 'admin.ho@hexa.co.id',
client_phone_no = '140111'
WHERE client_email LIKE 'admin@hexa%' AND client_name = 'Hexamedika' AND id_client <= 13;

UPDATE employee
SET employee_name = 'Narendra',
employee_addr = 'Taman Bungkul Surabaya',
gender = 'L',
phone_no = '81110145'
WHERE email LIKE 'naura%' AND employee_name LIKE 'Naura%' AND id_employee = 103;

UPDATE client
SET client_name = 'CV Avodamitra',
client_addr = 'Semampir Waru',
client_email = 'hrd@avodamitra.co.id',
client_phone_no = '1481222'
WHERE client_name LIKE 'Avoda%' OR client_email LIKE 'hrd@avo%' AND id_client < 15;

UPDATE project
SET id_job  = 1101,
id_employee = 103,
start_date = to_date('07/05/2020', 'dd/mm/yyyy'),
end_date = to_date('28/05/2020', 'dd/mm/yyyy')
WHERE id_project <= 8 AND start_date = to_date('05/05/2020', 'dd/mm/yyyy') AND end_date >= to_date('15/05/2020', 'dd/mm/yyyy');



DELETE FROM project
WHERE start_date = to_date('01/05/2020', 'dd/mm/yyyy') AND end_date = to_date('20/05/2020', 'dd/mm/yyyy') AND id_project < 8;

DELETE FROM project
WHERE end_date = to_date('20/05/2020', 'dd/mm/yyyy') AND start_date > to_date('03/05/2020', 'dd/mm/yyyy') OR id_project = 7;

DELETE FROM project
WHERE start_date BETWEEN to_date('02/05/2020', 'dd/mm/yyyy') AND to_date('06/05/2020', 'dd/mm/yyyy') AND id_project > 4;

SAVEPOINT del_project;
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1104, 101, to_date('10/05/2020', 'dd/mm/yyyy'), to_date('22/05/2020', 'dd/mm/yyyy'))
ROLLBACK TO SAVEPOINT del_project;

COMMIT;

SAVEPOINT del_project_4;
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1104, 101, to_date('10/05/2020', 'dd/mm/yyyy'), to_date('22/05/2020', 'dd/mm/yyyy'))

ROLLBACK TO SAVEPOINT del_project_4;

COMMIT;

SELECT * FROM proejct ORDER BY end_date;
SELECT end_date, count(id_job) FROM project GROUP BY end_date;

##### MODUL 3 #####
INSERT ALL
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (106, 'Maya', 'Medaeng', 'P', '1066666', 'maya@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (107, 'Aga', 'Waru', 'L', '1077777', 'aga@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (108, 'Nara', 'Sidoarjo', 'P', '1088888', 'nara@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (109, 'Moka', 'Candi', 'L', '1099999', 'moka@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (110, 'Tara', 'Tanggulangin', 'L', '1100000', 'tara@gmail.com')
SELECT 1 FROM dual;

INSERT ALL
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (16, 'Foxtrot Alto', 'Bukti Darmo', 'hr.ga@foxalto.co', '14444')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (17, 'Padinet', 'Mayjen Sungkono', 'admin.ho@padi.net', '15555')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (18, 'Grand Tower Corp', 'Basuki Rahmat', 'admin.hr@gtower.co.id', '16666')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (19, 'PT Sejahtera Abadi', 'Tanggulangin Sda', 'inquiry@sa.co.id', '17777')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (20, 'Maersk Corp', 'Pandaan', 'hr.ho@maersk.co.id', '18888')
SELECT 1 FROM dual;

INSERT ALL
INTO job (id_job, id_client, job_name, category, description) values (1106, 16, 'Software Engineer', 'IT engineer', 'Maintain website')
INTO job (id_job, id_client, job_name, category, description) values (1107, 18, 'Bussiness Dev', 'General', 'Collect and submit tender')
INTO job (id_job, id_client, job_name, category, description) values (1108, 16, 'IT Support', 'IT engineer', 'Maintain network peripheral')
INTO job (id_job, id_client, job_name, category, description) values (1109, 20, 'HRD', 'HR', 'Manage employee')
INTO job (id_job, id_client, job_name, category, description) values (1110, 20, 'General Affair', 'General', 'Manage office tools')
SELECT 1 FROM dual;

INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1106, 106, to_date('06/05/2020', 'dd/mm/yyyy'), to_date('15/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1107, 107, to_date('07/05/2020','dd/mm/yyyy'), to_date('18/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1108, 108, to_date('08/05/2020', 'dd/mm/yyyy'), to_date('30/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1109, 107, to_date('09/05/2020', 'dd/mm/yyyy'), to_date('21/05/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1110, 110, to_date('10/05/2020', 'dd/mm/yyyy'), to_date('24/05/2020', 'dd/mm/yyyy'));

SELECT id_job, MAX(id_client) AS
tertinggi, MIN(id_client) AS terendah FROM job
GROUP BY id_job;

SELECT id_project, COUNT(id_employee) FROM project 
WHERE id_project > 2 AND start_date >= to_date('06/05/2020', 'dd/mm/yyyy') AND end_date < to_date('30/05/2020', 'dd/mm/yyyy')
GROUP BY id_project;

SELECT SUM(id_client) AS
total_id_client FROM job;

SELECT AVG(id_client) AS 
rerata_total_id_client FROM job;

SELECT id_job, (SELECT MAX(id_client) FROM job)                                             
AS id_client_max, (SELECT MIN(id_client) FROM job
AS id_client_min FROM job 
WHERE id_client = 20 OR id_client = 11; 

SELECT id_client, (SELECT COUNT(id_client) FROM job
WHERE job.id_client =  client.id_client)
AS total_id_client FROM client WHERE id_client > 10 AND client_name LIKE 'F%' OR client_name LIKE 'P%';

SELECT id_job, (SELECT SUM(id_job) FROM project
WHERE project.id_job = job.id_job)
AS jumlah_id_job FROM job;

SELECT id_client, (SELECT AVG(id_client) FROM job
WHERE job.id_client = client.id_client)
AS rerata_id_client FROM client;

SELECT id_employee, (SELECT COUNT(id_employee) FROM project
WHERE project.id_employee = employee.id_employee)
AS jumlah_id_employee FROM employee
GROUP BY id_employee;

SELECT id_project, MAX(start_date) AS 
tertinggi, MIN(start_date) AS terendah FROM project
WHERE id_project IN (SELECT id_project FROM project WHERE start_date > to_date('06/05/2020', 'dd/mm/yyyy'))
GROUP BY id_project;


SELECT id_project,  

##### MODUL 4 ######
INSERT ALL
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (111, 'Roni', 'Sedati', 'L', '1111111', 'roni@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (112, 'Yuna', 'Waru', 'P', '1222222', 'yuna@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (113, 'Rainy', 'Sidoarjo', 'P', '1333333', 'rainy@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (114, 'Moza', 'Candi', 'L', '1444444', 'moza@gmail.com')
INTO employee (id_employee, employee_name, employee_addr, gender, phone_no, email) values (115, 'Taro', 'Tanggulangin', 'L', '1555555', 'taro@gmail.com')
SELECT 1 FROM dual;

INSERT ALL
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (21, 'Langitnet', 'Sidoarjo', 'admin@langit.net', '12111')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (22, 'PT PAL', 'Tanjung Perak', 'hrd@pal.co.id', '12222')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (23, 'PT Semen Indonesia', 'Gresik', 'inquiry@semen.co.id', '12333')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (24, 'PT DOK Surabaya', 'Tanjung Perak', 'admin.hrd@dok.co.id', '12444')
INTO client (id_client, client_name, client_addr, client_email, client_phone_no) values (25, 'D-Net', 'Basuki Rahmat', 'it@d-net.co.id', '12555')
SELECT 1 FROM dual;

INSERT ALL
INTO job (id_job, id_client, job_name, category, description) values (1111, 21, 'Admin IT', 'IT', 'Input ticket and generate ticket report')
INTO job (id_job, id_client, job_name, category, description) values (1112, 22, 'GA Drafter', 'Engineer', 'Collect and submit tender')
INTO job (id_job, id_client, job_name, category, description) values (1113, 21, 'IT Support', 'IT', 'Maintain network peripheral')
INTO job (id_job, id_client, job_name, category, description) values (1114, 25, 'General Affair', 'General', 'Manage office tools')
INTO job (id_job, id_client, job_name, category, description) values (1115, 23, 'Admin HRD', 'HR', 'Input data employee')
SELECT 1 FROM dual;

INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1111, 111, to_date('01/06/2020', 'dd/mm/yyyy'), to_date('30/06/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1112, 112, to_date('02/06/2020','dd/mm/yyyy'), to_date('10/06/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1113, 113, to_date('10/06/2020', 'dd/mm/yyyy'), to_date('30/06/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1114, 112, to_date('15/06/2020', 'dd/mm/yyyy'), to_date('30/06/2020', 'dd/mm/yyyy'));
INSERT INTO project (id_project, id_job, id_employee, start_date, end_date) values (id_project.nextval, 1115, 114, to_date('15/06/2020', 'dd/mm/yyyy'), to_date('15/07/2020', 'dd/mm/yyyy'));

### EQUI JOIN ###
select j.id_job, j.job_name, j.description, c.client_name from job j inner join client c on j.id_client = c.id_client
where j.id_job <= 1110 order by j.id_job;

select p.id_project, j.job_name, e.employee_name, p.start_date, p.end_date from project p left join job j
on p.id_job = j.id_job left join employee e
on p.id_employee = e.id_employee
where p.id_project in (select id_project from project where start_date <= to_date('10/06/2020', 'dd/mm/yyyy'));


select p.id_project, j.job_name, j.description, e.employee_name, e.email from project p right join job j
on p.id_job = j.id_job right join employee e
on p.id_employee = e.id_employee
where p.id_project > (select count(id_project) from project) AND p.end_date > to_date('30/05/2020', 'dd/mm/yyyy');

### VIEW ###
CREATE OR REPLACE VIEW JOB_FROM_CLIENT_V AS select j.id_job, j.job_name, j.description, c.id_client, c.client_name from job j inner join client c on j.id_client = c.id_client
where j.id_job <= 1110 order by j.id_job;

CREATE OR REPLACE VIEW PROJECT_UNDER_10JUNE_V AS 
select p.id_project, j.job_name, e.employee_name, p.start_date, p.end_date from project p left join job j
on p.id_job = j.id_job left join employee e
on p.id_employee = e.id_employee
where p.id_project in (select id_project from project where start_date <= to_date('10/06/2020', 'dd/mm/yyyy'));

CREATE OR REPLACE VIEW DUE_DATE_AFTER_30MAY AS
select p.id_project, j.job_name, j.description, e.employee_name, e.email from project p right join job j
on p.id_job = j.id_job right join employee e
on p.id_employee = e.id_employee
where p.id_project > (select count(id_project) from project) AND p.end_date > to_date('30/05/2020', 'dd/mm/yyyy');

UPDATE JOB_FROM_CLIENT_V
SET client_name = 'Golden Union Oil'
WHERE id_client = 1104;