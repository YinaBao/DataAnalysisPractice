USE classicmodels;


select * from information_schema.routaines;
select * from information_schema.tables;


DELIMITER //
CREATE PROCEDURE `try` (in statename varchar(45), in top int,  out salesRep int )
BEGIN
	select salesRepEmployeeNumber from customers c
    where c.state = statename
    order by c.customerNumber limit top
	into salesRep;
END //

DELIMITER ;


call try('CA', 1, @sales);
select @sales;
 


