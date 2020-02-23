USE classicmodels;

-- 1
select e.officeCode, city, count(employeeNumber) as employee_count from employees e
left join offices o on e.officeCode = o.officeCode
group by e.officeCode
order by employee_count desc limit 3;

-- 2
select productLine, sum(quantityInStock*MSRP-quantityInStock*buyPrice)/sum(MSRP*quantityInStock) as  profit_margin from products
group by productLine;

-- 3
select e.employeeNumber, concat(firstName, lastName) as salesName, 
sum(quantityOrdered*priceEach) as salesRev from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber
left join employees e on c.salesRepEmployeeNumber = e.employeeNumber
group by e.employeeNumber
order by salesRev desc limit 3;

-- employees table, we should update the job title, and ther reportsTo
select e.employeeNumber, concat(firstName, lastName) as salesName, sum(quantityOrdered*priceEach) as salesRev, reportsTo, jobTitle from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber
left join employees e on c.salesRepEmployeeNumber = e.employeeNumber
group by e.employeeNumber
order by salesRev desc limit 3;

-- add column called employees status as either 'active' or 'inactive'
-- checked the status by using element like term_date, etc.
DELIMITER //
CREATE PROCEDURE '3c'()
BEGIN
	select *
    from employees
    where 
END //
DELIMITER ;


-- 4
select e.employee_id, employee_name, count(distinct s.salary) from employee e
left join employee_salary s on e.employee_id = s.employee_id
left join department d on e.department_id = d.department_id
where department_name = 'salesDept'
group by e.employee_id;




select e.employee_id, employee_name, count(distinct s.salary) from employee e
left join employee_salary s on e.employee_id = s.employee_id
left join department d on e.department_id = d.department_id
where department_name = 'salesDept'
group by e.employee_id;


-- 5
select n.employee_name, d.department_name, n.salary 
from (Select *, dense_rank() over(partition by department_id order by salary desc) as salary_rank 
From employee e
where term_date is NULL) n
Left Join department d on d.department_id = n.department_id 
Where n.salary_rank < 4;
















