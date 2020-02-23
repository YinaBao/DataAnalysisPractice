CREATE VIEW `q8ordered` AS
select customerNumber, sum(quantityOrdered*priceEach) as ordervalue from orderdetails od
left join orders o on o.orderNumber = od.orderNumber
where year(orderDate) = 2004
group by customerNumber;