DROP DATABASE IF EXISTS db1;
CREATE DATABASE db1;
USE db1;
CREATE TABLE t1 (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(40) NOT NULL
);
INSERT INTO t1 (name) VALUES ('Fred'),('Barney'),('Wilma'),('Betty');
SELECT * FROM t1;