DROP DATABASE `TRY1`;
CREATE DATABASE IF NOT EXISTS `TRY1`;
USE `TRY1`;


DROP TABLE IF EXISTS `User`;
CREATE TABLE `User`
(
    `user_id`   INT PRIMARY KEY AUTO_INCREMENT,
    `user_name` VARCHAR(255) UNIQUE NOT NULL,
    `password`  VARCHAR(130) NOT NULL
);

DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role`
(
    `role_id`   INT PRIMARY KEY AUTO_INCREMENT,
    `role_name` VARCHAR(255) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`
(
    `user_role_id`  INT PRIMARY KEY AUTO_INCREMENT,
    `user_id`       INT NOT NULL,
    `role_id`       INT NOT NULL,
    FOREIGN KEY USER_ROLE_U (user_id) REFERENCES User(user_id),
    FOREIGN KEY USER_ROLE_R (role_id) REFERENCES Role(role_id),
    UNIQUE(user_id , role_id)
);


DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee`
(
	`employee_id` INT PRIMARY KEY,
	`first_name` VARCHAR(255) NOT NULL, 
	`last_name` VARCHAR(255) NOT NULL, 
	`designation` VARCHAR(255) NOT NULL,
	`date_of_birth` DATE NOT NULL,
	FOREIGN KEY EMPLOYEE_USER (employee_id) REFERENCES User(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS `Employee_contact`;
CREATE TABLE `Employee_contact`
(
	`contact_number` VARCHAR(20),
	`employee_id` INT,
	PRIMARY KEY(`employee_id` , `contact_number`),
	CONSTRAINT FK_CONT_EMP FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Employee_email`;
CREATE TABLE `Employee_email`
(
	`email_id` VARCHAR(255),
	`employee_id` INT,
	PRIMARY KEY(`employee_id` , `email_id`),
	CONSTRAINT FK_EMAIL_EMP FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS `Task`;
CREATE TABLE `Task`
(
	`task_id` INT PRIMARY KEY AUTO_INCREMENT,
	`task_desc` TEXT NOT NULL,
	`given_date` DATE,
	`deadline` DATE NOT NULL,
	`given_by` INT NOT NULL,
	`status` INT DEFAULT 0,
	`done_on` DATE,
	CONSTRAINT GIVEN_BY_EMP FOREIGN KEY (given_by) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER `set_given_date` BEFORE INSERT ON Task
FOR EACH ROW
BEGIN
IF NEW.given_date IS NULL THEN
	SET NEW.given_date = CURDATE();
END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER `set_done_on` BEFORE UPDATE ON Task
FOR EACH ROW
BEGIN
IF (NEW.status = 1 AND OLD.status = 0) THEN
	SET NEW.done_on = CURDATE();
END IF;
END $$

DELIMITER ;

DROP TABLE IF EXISTS `Task_given_to`;
CREATE TABLE `Task_given_to`
(
	`task_id` INT,
	`employee_id` INT,
	PRIMARY KEY(task_id , employee_id),
	FOREIGN KEY TASK_GIVEN_TO_TASK (task_id) REFERENCES Task(task_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY TASK_GIVEN_TO_EMP (employee_id) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

DROP TABLE IF EXISTS `Employee_schedule`;
CREATE TABLE `Employee_schedule`
(
	`employee_id` INT,
	`start_time` DATETIME,
	`end_time` DATETIME NOT NULL,
	`description` TEXT NOT NULL,
	PRIMARY KEY(employee_id , start_time),
	CONSTRAINT FK_SCH_EMP FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS `Expense`;
CREATE TABLE `Expense`
(
	`expense_id` INT PRIMARY KEY AUTO_INCREMENT,
	`description` TEXT NOT NULL,
	`edate` DATE,
	`amount` INT NOT NULL,
	`added_by` INT,
	CONSTRAINT ADDED_BY_EMP FOREIGN KEY (added_by) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE SET NULL
);


DELIMITER $$

CREATE TRIGGER `set_given_date_expense` BEFORE INSERT ON Expense
FOR EACH ROW
BEGIN
IF NEW.edate IS NULL THEN
	SET NEW.edate = CURDATE();
END IF;
END $$

DELIMITER ;


DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer`
(
    `customer_id` INT PRIMARY KEY,
	`first_name` VARCHAR(255) NOT NULL,
	`last_name` VARCHAR(255) NOT NULL, 
	`city` VARCHAR(255) NOT NULL,
	`state` VARCHAR(255) NOT NULL,
	`revenue` INT NOT NULL,
	`industry` VARCHAR(255) NOT NULL,
	`gender` VARCHAR(6) NOT NULL,
	FOREIGN KEY USER_CUST (customer_id) REFERENCES User(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Customer_contact`;
CREATE TABLE `Customer_contact`
(
	`contact_number` VARCHAR(20),
	`customer_id` INT,
	PRIMARY KEY(customer_id , contact_number),
	CONSTRAINT FK_CONT_CUS FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Customer_email`;
CREATE TABLE `Customer_email`
(
	`email_id` VARCHAR(255),
	`customer_id` INT,
	PRIMARY KEY(customer_id , email_id),
	CONSTRAINT FK_EMAIL_CUS FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Meeting`;
CREATE TABLE `Meeting`
(
    `meeting_id` INT PRIMARY KEY AUTO_INCREMENT,
	`minutes` TEXT,
	`start_time` DATETIME NOT NULL,
	`end_time` DATETIME NOT NULL,
	`rating` INT ,
	`employee_id` INT,
	`customer_id` INT,
	CONSTRAINT FK_MEET_EMP FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT FK_MEET_CUS FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER $$

CREATE TRIGGER `update_schedule` AFTER INSERT ON Meeting
FOR EACH ROW
BEGIN
INSERT INTO Employee_schedule VALUES (NEW.employee_id , NEW.start_time , NEW.end_time , 'Meeting with Customer');
END $$

DELIMITER ;

DROP TABLE IF EXISTS `Fd`;
CREATE TABLE `Fd`
(
	`fd_id` INT PRIMARY KEY AUTO_INCREMENT,
	`bank_name` VARCHAR(255) NOT NULL,
	`amount` INT NOT NULL,
	`interest_rate` REAL NOT NULL,
	`customer_id` INT,
	CONSTRAINT FK_FD_CUST FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE 
);

DROP TABLE IF EXISTS `Equity`;
CREATE TABLE `Equity`
(
	`ticker_symbol` VARCHAR(255),
	`average_buy_price` REAL NOT NULL,
	`quantity` INT NOT NULL,
	`customer_id` INT,
	PRIMARY KEY(ticker_symbol , customer_id),
	CONSTRAINT FK_EQ_CUST FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Metals`;
CREATE TABLE `Metals`
(
	`type` VARCHAR(255),
	`average_buy_price` REAL NOT NULL,
	`quantity` INT NOT NULL,
	`customer_id` INT,
	PRIMARY KEY(type , customer_id),
	CONSTRAINT FK_ME_CUST FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Funds`;
CREATE TABLE `Funds`
(
	`amc_fund_house` VARCHAR(255),
	`quantity` INT NOT NULL,
	`average_buy_price` REAL NOT NULL,
	`customer_id` INT,
	PRIMARY KEY(amc_fund_house , customer_id),
	CONSTRAINT FK_FU_CUST FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS `Variables`;
CREATE TABLE `Variables`
(
	`variable_name` VARCHAR(255) PRIMARY KEY,
	`value` VARCHAR(255)
);

DELIMITER $$

CREATE FUNCTION get_age(date_of_birth DATE)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE i INT;
SET i = (YEAR(NOW()) - YEAR(date_of_birth) - (RIGHT(NOW(), 5) < RIGHT(date_of_birth, 5))); 
RETURN i;
END$$

DELIMITER ;

ALTER TABLE Customer ADD CONSTRAINT CHK_PersonAge CHECK (gender in ("Male" , "Female"));

ALTER TABLE Customer_email ADD CONSTRAINT CHK_Email CHECK (email_id LIKE "%_@_%");

ALTER TABLE Employee_email ADD CONSTRAINT CHK_Email_Emp CHECK (email_id LIKE "%_@_%");

ALTER TABLE Task ADD CONSTRAINT CHK_Deadline CHECK (deadline >= given_date);

ALTER TABLE Employee_schedule ADD CONSTRAINT CHK_CheckDate CHECK (end_time >= start_time);

ALTER TABLE Meeting ADD CONSTRAINT CHK_CheckDate_Meet CHECK (end_time >= start_time);

ALTER TABLE Employee ADD CONSTRAINT CHK_CheckDesg CHECK (designation in ("Manager" , "Deputy Manager" , "Office Boy"));