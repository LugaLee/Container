CREATE USER IF NOT EXISTS luga;

CREATE DATABASE books;

GRANT ALL ON DATABASE books TO luga;

CREATE TABLE tblbooks(
  id INT PRIMARY KEY,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  stars INT,
  category VARCHAR
);

INSERT INTO tblbooks (id, name, phone, email, stars, category) VALUES
(1,'Lucy','130-0000-0000','lucy13000000000@example.net',8,'life'),
(2,'Green ','125-0456-0102','green1250456@example.com',1,'artity'),
(3,'Linda','857-555-0182','linda857@example.com',3,'moon'),
(4,'Wilium','999-555-000','wilium@example.com',5,'sunset'),
(5,'Lily','234-2123-1231','lily1900@example.com',5,'work'),
(6,'Luga','100-0555-0102','luga100@example.com',3,'golang'),
(7,'Qiuchi','777-5555-0000','qiuchi777@example.com',3,'freedom'),
(8,'walse','000-11111-22222','walse@example.com',5,'tutorial'),
(9,'Jhons','444-4433-1213','jhons444@example.com',5,'project'),
(10,'Leon','122-1214-5678','leon1221214@example.com',4,'confidence');
