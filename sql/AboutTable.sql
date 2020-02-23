CREATE TABLE `classicmodels`.`departments2` (
  `departId` INT NOT NULL,
  `departName` VARCHAR(45) NOT NULL,
  `departHead` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`departId`));


ALTER TABLE `classicmodels`.`departments2`
ADD COLUMN `Note` VARCHAR(45) NOT NULL AFTER `departHead`;

alter table   `classicmodels`.`departments2`
add column `major` varchar(45) not null after `Note`;

Insert into departments values (9, 'math', 'abc', 'a', 'b' );

Update departments2 set departName = 'statistics' where departId = 9;
