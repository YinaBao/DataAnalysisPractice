USE classicmodels;

-- Single entity
-- 1
SELECT officeCode FROM offices
order by country, state, city;

-- 2
select count(distinct employeeNumber) from employees;

-- 3
select sum(amount) from payments;

-- 4
select productCode, productLine from products
where productLine like '%Cars%';

-- 5
select paymentDate, sum(amount) from payments
where paymentDate  = '2004-10-28';

-- 6
select * from payments
where amount > 100000;

-- 7
select productLine, productCode, productName from products
order by productLine;

-- 8
select count(productCode), productLine from products
group by productLine;

-- 9
select min(amount) from payments;

-- 10
select * from payments
where amount > (select 2*avg(amount) from payments);

-- 11
select (avg(MSRP/buyPrice*100)) as average_percentage_markup from products;

-- 12
select count(distinct productCode) from products
where productLine  like  '%Classic%';

-- 13
select customerName, city from customers
where salesRepEmployeeNumber is not null;

-- 14
select concat(firstName, lastName), jobTitle from employees
where jobTitle like '%Manager%' or jobTitle like '%VP%';

-- 15
select * from orderdetails
having priceEach*quantityOrdered > 5000;

-- One to many relationship
-- 1
select customerNumber, customerName,  salesRepEmployeeNumber, concat(e.firstName, e.lastName) from customers c
left outer join employees e
on c.salesRepEmployeeNumber = e.employeeNumber;

-- 2
select sum(amount) from payments
where customerNumber = (select customerNumber from customers where customerName = 'Atelier graphique');

-- 3
select paymentDate, sum(amount) from payments
group by paymentDate;

-- 4
select p.productCode, productName from products p
left outer join orderdetails o
on o.productCode = p.productCode
where o.productCode is NULL;

-- 5
select sum(p.amount), p.customerNumber, c.customerName from payments p
right join customers c on c.customerNumber = p.customerNumber
group by customerNumber;

-- 6 
select count(o.orderNumber) from orders o
left join customers c on o.customerNumber = c.customerNumber
where c.customerName = 'Herkku Gifts';

-- 7
select e.employeeNumber, concat(e.firstName, e.lastName), o.city from employees e
left join offices o on e.officeCode = o.officeCode
where o.city = 'Boston';

-- 8
select c.customerName, p.amount from payments p
left join customers c on p.customerNumber = c.customerNumber
where p.amount  > 100000
order by p.amount desc;

-- 9
select od.orderNumber, o.status, sum(od.priceEach*od.quantityOrdered) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where o.status = 'On Hold'
group by od.orderNumber;

-- 10
select customerName, c.customerNumber, o.orderNumber from orders o
left join customers c on o.customerNumber = c.customerNumber
where o.status = 'On Hold';

select customerName, c.customerNumber, count(distinct o.orderNumber) from orders o
left join customers c on o.customerNumber = c.customerNumber
where o.status = 'On Hold'
group by o.customerNumber;


-- Many to many relationship
-- 1
select od.orderNumber, o.orderDate, p.productCode, p.productName from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join products p on od.productCode = p.productCode;

-- 2
select o.orderDate from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join products p on od.productCode = p.productCode
where p.productName = '1940 Ford Pickup Truck'
order by o.orderDate desc;

-- 3 
select c.customerName, o.orderNumber, sum(od.quantityOrdered*priceEach) as orderValue from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber
group by od.orderNumber
having orderValue > 25000;

-- 4
select productCode, count(distinct orderNumber) as appeartimes from orderdetails
group by productCode
having appeartimes = (select count(distinct orderNumber) from orderdetails);

-- 5
select distinct p.productName from orderdetails od
left join products p on od.productCode = p.productCode
where od.priceEach < p.MSRP*0.8;

-- 6
select distinct p.productName from orderdetails od
left join products p on od.productCode = p.productCode
where od.priceEach > p.buyPrice*2;

-- 7
select  od.orderNumber, p.productName, weekday(o.orderDate) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join products p on od.productCode = p.productCode
where weekday(o.orderDate) = 0;

-- 8
select  od.orderNumber, sum(quantityOrdered) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where o.status = 'On Hold'
group by od.orderNumber;

select  sum(p.quantityInStock) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join products p on od.productCode = p.productCode
where o.status = 'On Hold';
#group by p.productCode; 

-- Regular expressions
-- 1
select productCode, productName from products
where productName like '%Ford%';

-- 2
select productCode, productName from products
where productName like '%ship';

-- 3
select count(distinct customerNumber), country from customers
where country = 'Denmark' or country = 'Norway' or country  = 'Sweden'
group by country;

-- 4
select * from products
where productCode like 'S700_11__' or productCode like 'S700_12__ '  or productCode like 'S700_13__ '  or productCode like 'S700_14__ ';

-- 5 
select customerName from customers
where customerName REGEXP '[0-9]';

-- 6
select concat(firstName, lastName) from employees
where concat(firstName, lastName) like '%Diane%' or  concat(firstName, lastName) like '%Dianne%';

-- 7
select productName from products
where productName like '%boat%' or productName like '%ship%' ;

-- 8
select * from products
where productCode like 'S700%';

-- 9 
select concat(firstName, lastName) from employees
where concat(firstName, lastName) like '%Larry%' or  concat(firstName, lastName) like '%Barry%';

-- 10
select concat(firstName, lastName) from employees
where concat(firstName, lastName) REGEXP '[^[a-z ]]';

-- 11
select productVendor from products
where productVendor like '%Diecast';

-- General queries
-- 1
select lastName, firstName from employees
where reportsTo is null;

-- 2
select e.firstName, e.lastName from employees e
left join employees ee on e.reportsTo = ee.employeeNumber
where ee.firstName = 'William' and ee.lastName = 'Patterson';

-- 3
select distinct p.productName from orders o
left join customers c on o.customerNumber = c.customerNumber
left join orderdetails od on o.orderNumber = od.orderNumber
left join products p on od.productCode = p.productCode
where c.customerName = 'Herkku Gifts';

-- 4
select e.firstName, e.lastName, sum(od.quantityOrdered*od.priceEach*0.05) as commission from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber
left join employees e on c.salesRepEmployeeNumber = e.employeeNumber
group by c.salesRepEmployeeNumber
order by e.lastName, firstName;

-- 5
select DATEDIFF(max(orderDate), min(orderDate)) from orders;

-- 6
select customerNumber, avg(DATEDIFF(shippedDate, orderDate)) AS AvgDateDiff from orders
group by customerNumber
order by AvgDateDiff desc;

-- 7
select sum(quantityOrdered*priceEach) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
WHERE (shippedDate BETWEEN '2004-08-01' AND '2004-08-31');

-- 8
CREATE VIEW `q8ordered` AS
select customerNumber, sum(quantityOrdered*priceEach) as ordervalue from orderdetails od
left  join orders o on o.orderNumber = od.orderNumber
where year(o.orderDate) = 2004
group by customerNumber;

CREATE VIEW `q8paid` AS
select customerNumber, sum(amount) as paidvalue from payments p
where year(o.paymentDate) = 2004
group by customerNumber;


SELECT o.customerNumber, ordervalue-paidvalue as difference FROM q8ordered o
left join q8paid p on o.customerNumber = p.customerNumber;

-- 9
select concat(e.firstName, e.lastName) from employees e
left join employees ee on e.reportsTo = ee.employeeNumber
left join employees eee on ee.reportsTo = eee.employeeNumber
where eee.firstName  = 'Diane' and eee.lastName = 'Murphy' ;

-- 10
CREATE VIEW `q10` AS
select sum(quantityInStock) as d from products;

select productCode, productName, quantityInStock/(select d from q10)*100 as percentage from products
order by percentage desc;

-- 11
DELIMITER //
CREATE FUNCTION `q11` (mpg float(10,2))
RETURNS float(10,2)
DETERMINISTIC
BEGIN
	declare lpk float(10.2);
	set lpk = 235.215/mpg;
	RETURN lpk;
END //
DELIMITER ;

select q11(2.00) as LPer100Km;

-- 12
DELIMITER //
CREATE PROCEDURE `q12` (in category varchar(45), in percentage float(10,2))
BEGIN
	select productCode, productName, MSRP*(1+percentage/100) as increasedPrice
    from products
    where productLine = category;
END //
DELIMITER ;

call q12('Motorcycles', 1.00);

-- 13
select sum(quantityOrdered*priceEach) from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
WHERE (shippedDate BETWEEN '2004-08-01' AND '2004-08-31');

-- 14
select t.months, payment, received, payment/received as ratio from (
select month(paymentDate) as months, sum(amount) as payment from payments 
where year(paymentDate) = 2004
group by months) t
left join (select month(o.orderDate) as months, sum(quantityOrdered*priceEach) as received from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where year(orderDate) = 2004
group by months) u on t.months = u.months
order by t.months;

-- 15
select t.mo, t.amount04-n.amount03 as difference 
from (select month(paymentDate) as mo, sum(amount) as amount04 from payments
where year(paymentDate) = 2004
group by mo) t
left join (select month(paymentDate) as mo, sum(amount) as amount03 from payments
where year(paymentDate) = 2003
group by mo) n on t.mo = n.mo
order by t.mo;

-- 16
DELIMITER //
CREATE PROCEDURE `q16` (in months int, in years int, in customerString varchar(45))
BEGIN
	select customerName, sum(quantityOrdered*priceEach) as amountOrdered from orderdetails od
	left join orders o on od.orderNumber = o.orderNumber
	left join customers c on o.customerNumber = c.customerNumber
	where month(orderDate) = months and year(orderDate) = years and locate(customerString, c.customerName) != 0
	group by c.customerName;
END //
DELIMITER ;

call q16(5, 2003, 'teli');
 
-- 17
DELIMITER //
CREATE PROCEDURE `q17` (in percentage float(10,2), in country varchar(45))
BEGIN
	select customerName, creditLimit*percentage/100 as changedCredit from customers c
	where c.country = country;
END //
DELIMITER ;

call q17(90, 'USA');

-- 18
#Basket of goods analysis: 
#A common retail analytics task is to analyze each basket or order to learn what products are often purchased together. 
#Report the names of products that appear in the same order ten or more times.

-- 19
select t.customerName, sum(t.revenue) as eachRev, 
sum(t.revenue)/(select sum(od.quantityOrdered*priceEach) from orderdetails od
left join products p on od.productCode = p.productCode) pct_total
from (select o.customerNumber, c.customerName, od.orderNumber, od.quantityOrdered*priceEach as revenue from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber) t
group by t.customerName
order by t.customerName;

-- 20
select t.customerName, sum(t.revenue) as eachProfit, 
sum(t.revenue)/(select sum(od.quantityOrdered*(priceEach-p.buyPrice)) from orderdetails od
left join products p on od.productCode = p.productCode) pct_total
from (select o.customerNumber, c.customerName, od.orderNumber, od.quantityOrdered*(priceEach-p.buyPrice) as revenue from orderdetails od
left join products p on od.productCode = p.productCode
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber) t
group by t.customerName
order by eachProfit desc;

-- 21
select salesRepEmployeeNumber, concat(e.lastName, e.firstName), sum(quantityOrdered*priceEach) as revenue from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on c.customerNumber = o.customerNumber
left join employees e on e.employeeNumber = c.salesRepEmployeeNumber
group by salesRepEmployeeNumber;

-- 22
select salesRepEmployeeNumber, concat(e.lastName, e.firstName), sum(quantityOrdered*(priceEach-buyPrice)) as profit from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on c.customerNumber = o.customerNumber
left join employees e on e.employeeNumber = c.salesRepEmployeeNumber
left join products p on p.productCode = od.productCode
group by salesRepEmployeeNumber
order by profit;

-- 23
select productName, sum(quantityOrdered*priceEach) as revenue from orderdetails od 
left join products p on od.productCode = p.productCode
group by od.productCode
order by productName;

-- 24
select productLine, sum(quantityOrdered*(priceEach-buyPrice)) as profit from orderdetails od 
left join products p on od.productCode = p.productCode
group by productLine
order by profit desc;

-- 25
select t.productCode, anqutity03, anqutity04, anqutity03/anqutity04 as ratio from 
(select od.productCode, sum(quantityOrdered) as anqutity03 from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where year(orderDate) = 2003
group by productCode) t
left join (select od.productCode, sum(quantityOrdered) as anqutity04 from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where year(orderDate) = 2004
group by productCode) n on n.productCode = t.productCode;

-- 26
select t.customerNumber, amount03, amount04, amount03/amount04 as ratio from 
(select customerNumber, sum(amount) as amount03 from payments
where year(paymentDate) = 2003
group by customerNumber) t
left join (select customerNumber, sum(amount) as amount04 from payments
where year(paymentDate) = 2004
group by customerNumber) n on n.customerNumber = t.customerNumber;

-- 27
select productCode, orderDate from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
where year(o.orderDate) = 2003 and od.orderNumber not in  (select orderNumber from orders where year(orderDate) = 2004);

-- 28
select customerNumber, customerName from customers
where customerNumber not in (select customerNumber from payments where year(paymentDate) = 2003);

-- Correlated subqueries
-- 1
select concat(e.firstName, e.lastName) from employees e
left join employees ee on e.reportsTo = ee.employeeNumber
where ee.firstName  = 'Mary' and ee.lastName = 'Patterson' ;

-- 2
select p.paymentDate, p.amount, n.twiceAvg from payments p
left join (
select EXTRACT(YEAR_MONTH FROM  paymentDate) as monthYear, 2*avg(amount) as twiceAvg from payments
group by monthYear) n on EXTRACT(YEAR_MONTH FROM  p.paymentDate)  = n.monthYear
where amount > n.twiceAvg
order by paymentDate;

-- 3
select p.productCode, p.productName, p.productLine, round(p.quantityInStock/ts.total_InStock*100,2) as percentageValue 
from products p
left join (
select productLine, sum(quantityInStock) as total_InStock from products
group by productLine) ts on p.productLine = ts.productLine
order by p.productLine, percentageValue desc;

-- 4
select od.orderNumber, od.productCode, p.productName, pn.product_num, od.quantityOrdered*od.priceEach as order_value, hv.half_value 
from orderdetails od
left join (
select orderNumber, sum(quantityOrdered*priceEach*0.5) as half_value from orderdetails
group by orderNumber) hv on od.orderNumber = hv.orderNumber
left join products p on od. productCode  = p.productCode
left join (
select orderNumber, count(productCode) as product_num from orderdetails 
group by orderNumber ) pn on od.orderNumber = pn.orderNumber
having  pn.product_num > 2 and order_value > hv.half_value;






