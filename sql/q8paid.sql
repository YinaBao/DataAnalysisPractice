CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `classicmodels`.`q8paid` AS
    SELECT 
        `classicmodels`.`payments`.`customerNumber` AS `customerNumber`,
        SUM(`classicmodels`.`payments`.`amount`) AS `paidvalue`
    FROM
        `classicmodels`.`payments`
    WHERE
        (YEAR(`classicmodels`.`payments`.`paymentDate`) = 2004)
    GROUP BY `classicmodels`.`payments`.`customerNumber`