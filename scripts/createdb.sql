DROP DATABASE IF EXISTS db1;
CREATE DATABASE db1;
USE db1;
CREATE TABLE t1 (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(40) NOT NULL
);
INSERT INTO t1 (name) VALUES ('Fred'),('Barney'),('Wilma'),('Betty');
DROP USER IF EXISTS 'appuser'@'%';
CREATE USER 'appuser'@'%' IDENTIFIED BY 'Welcome1!';
GRANT Select, Insert, Update, Delete ON db1.* TO 'appuser'@'%';
