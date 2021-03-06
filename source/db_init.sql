CREATE SCHEMA employee_management_sys AUTHORIZATION postgres;

SET search_path TO employee_management_sys;

CREATE DOMAIN domain_name AS varchar(50);
CREATE DOMAIN domain_password AS varchar(50);

CREATE TABLE department(
	d_id Serial PRIMARY KEY,
	d_name domain_name NOT NULL
);

CREATE TABLE employee(
	e_id Serial PRIMARY KEY,
	e_name domain_name NOT NULL,
	e_department integer REFERENCES department(d_id),
	e_admin boolean NOT NULL,
	e_password domain_password NOT NULL,
	e_archived boolean NOT NULL
);

INSERT INTO employee(e_name, e_department, e_admin, e_password, e_archived) VALUES('admin', NULL, true, '1234', false);

CREATE DOMAIN domain_content AS varchar(5000);
CREATE DOMAIN domain_timestamp AS timestamp(0);

CREATE TABLE MessagingGroup(
	mg_id SERIAL PRIMARY KEY,
	mg_name domain_name,
	mg_isgroup bool NOT NULL
);

CREATE TABLE message(
	m_id SERIAL PRIMARY KEY,
	m_sender int,
	m_group int,
	m_time domain_timestamp NOT NULL DEFAULT NOW(),
	m_content domain_content
);

ALTER TABLE message ADD CONSTRAINT fk_sender FOREIGN KEY(m_sender)
REFERENCES Employee(e_id) ON DELETE CASCADE;
ALTER TABLE message ADD CONSTRAINT fk_group FOREIGN KEY(m_group)
REFERENCES MessagingGroup(mg_id) ON DELETE CASCADE;


CREATE TABLE empConnection(
	c_eid int not null,
	c_gid int not null
);

ALTER TABLE empconnection ADD CONSTRAINT
constraintCon PRIMARY KEY(c_eid,c_gid);

ALTER TABLE empconnection ADD CONSTRAINT fk_eid FOREIGN KEY(c_eid)
REFERENCES Employee(e_ID) ON DELETE CASCADE;
ALTER TABLE empconnection ADD CONSTRAINT fk_gid FOREIGN KEY(c_gid)
REFERENCES MessagingGroup(mg_ID) ON DELETE CASCADE;