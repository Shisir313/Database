show databases;
use dbemp;
CREATE TABLE Dept (
    DEPT_No INT PRIMARY KEY,
    DNAME VARCHAR(100) NOT NULL,
    LOC VARCHAR(100)
);

rename table Dept to Departmentt;
Alter table departmentt
rename column DNAME to DEPT_NAME;
alter table departmentt
add column PINCODE int not null;
alter table departmentt
modify LOC char(10);
drop table departmentt;


