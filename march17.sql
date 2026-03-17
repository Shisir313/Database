create database BankDB;
USE BankDB;
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance double
);
INSERT INTO accounts (account_id, account_holder, balance)
VALUES 
(1, 'Ram', 50000),
(2, 'Shyam', 30000),
(3, 'Sita', 20000);

select * from accounts; 
#3Transfer from one account to another

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1 AND balance >= 1000;

UPDATE accounts
SET balance = balance + 1000
WHERE account_id = 2;

COMMIT;

#4 use of rollback
Start transaction;

update accounts set balance = balance - 10000 where account_id = 2;
update accounts set balance = balance + 10000 where account_id = 3;

rollback;

#5 use of savepoint

Start transaction;

update accounts set balance = balance - 10000 where account_id = 3;
savepoint sp1;
update accounts set balance = balance + 10000 where account_id = 2;
savepoint sp2;
rollback to sp1;
commit;

#triggers
create table employess(
emp_id int primary key,
name varchar(100),
salary decimal (10 ,2)
);
#2
create table Salary_log(
log_id int,
emp_id int
);

drop table Salary_log;

create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal (10, 2),
new_salary decimal(10 , 2),
updated_at timestamp default current_timestamp
);

Delimiter $$
create trigger check_salary
before insert on employess
for each row
begin
if new.salary < 10000 then 
signal sqlstate '45000'
set message_text= 'salary must be at least 10000';
end if ;
end
$$
Delimiter ;

Delimiter $$
create trigger log_salary_update
after update on employess
for each row
begin
	insert into salary_log(emp_id,old_salary,new_salary)
    values(old.emp_id,old.salary,new.salary);
end 
$$ 
Delimiter ;

#store procedure
#1.store procedure to retrive all records from table
 
Delimiter $$
create procedure getEmployee()
Begin
select* from employess;
end
$$
Delimiter ;

call getEmployee();

Delimiter $$
create procedure addEmployee(
in p_id int, in p_name varchar (100),
in p_salary decimal(10,2))
begin
insert into employess
values(p_id,p_name,p_salary);
end
$$
Delimiter ;

call addEmployee(5,'Hari',20000);

call getEmployee();


#procedure to store update
Delimiter $$
create procedure updateEmployee(
in p_id int, in new_salary decimal(10,0))
begin 
update employee
set salary = new_salary
where emp_ip = P_id;
end
$$
Delimiter ;

call updateEmployee(1, 50000);

#4procedure that transfer money between two accounts
DELIMITER $$

CREATE PROCEDURE getTransfer(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE from_balance DECIMAL(10,2);

    -- Start transaction
    START TRANSACTION;

    -- Get balance of the source account
    SELECT balance INTO from_balance
    FROM accounts
    WHERE account_id = from_account;

    -- Check if sufficient balance exists
    IF from_balance < amount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    ELSE
        -- Deduct from source account
        UPDATE accounts
        SET balance = balance - amount
        WHERE account_id = from_account;

        -- Add to destination account
        UPDATE accounts
        SET balance = balance + amount
        WHERE account_id = to_account;

        -- Commit transaction
        COMMIT;
    END IF;
END $$

DELIMITER ;

call gettransfer(1,2,5000);