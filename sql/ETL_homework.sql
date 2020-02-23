use classicmodels;

drop table if exists employee_tab;
CREATE TABLE employee_tab (
	employeeNumber_fk INT(11) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    reportsTo INT(11) NULL,
    jobTitle VARCHAR(50) NOT NULL,
    officeCode VARCHAR(10) NOT NULL,
	PRIMARY KEY (employeeNumber_fk)
	);
    
INSERT INTO employee_tab ( employeeNumber_fk, lastName, firstName, extension, email, reportsTo, jobTitle, officeCode )
select employeeNumber, lastName, firstName, extension, email, reportsTo, jobTitle, officeCode from employees;



CREATE TABLE customer_tab (
	customerNumber_fk INT(11) NOT NULL,
    customerName  VARCHAR(50) NOT NULL,
    contactLastName  VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone  VARCHAR(50) NOT NULL,
    addressLine1  VARCHAR(50) NOT NULL,
    addressLine2  VARCHAR(50) NULL DEFAULT NULL,
    postalCode  VARCHAR(15) NULL DEFAULT NULL,
    country  VARCHAR(50) NOT NULL,
    salesRepEmployeeNumber  INT(11) NULL,
    creditLimit  DOUBLE NULL DEFAULT NULL,
	PRIMARY KEY (customerNumber_fk)
	);

CREATE TABLE product_tab (
	productCode_fk VARCHAR(15) NOT NULL,
	productName VARCHAR(70) NOT NULL,
    productScale  VARCHAR(10) NOT NULL,
    productVendor  VARCHAR(50) NOT NULL,
    productDescription  TEXT NOT NULL,
    quantityInStock  SMALLINT(6) NOT NULL,
    buyPrice  DOUBLE NOT NULL,
    MSRP  DOUBLE NOT NULL,
	PRIMARY KEY (productCode_fk)
	);

CREATE TABLE date_tab (
	date_fk INT(11) NOT NULL,
    dates DATETIME NOT NULL,
    weekday INT(11) NOT NULL,
    days_month INT(11) NOT NULL,
    days_year INT(11) NOT NULL,
    weeks_month INT(11) NOT NULL,
    weeks_year INT(11) NOT NULL,
    months INT(11) NOT NULL,
    years INT(11) NOT NULL,
	PRIMARY KEY (date_fk)
	);
# https://gist.github.com/johngrimes/408559
    
    CREATE TABLE location_tab (
		locationCode_fk INT(11) NOT NULL,
        city VARCHAR(50) NOT NULL,
        state VARCHAR(50) NULL DEFAULT NULL,
        country VARCHAR(50) NOT NULL,
        postalCode VARCHAR(15) NOT NULL,
	PRIMARY KEY (locationCode_fk)
	);
    
-- Fact Table Order
drop table if exists Order_tab;
CREATE TABLE Order_tab (
	orderNumber INT(11) NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    customerNumber INT(11) NOT NULL,
    employeeNumber INT(11) NOT NULL,
    locationCode VARCHAR(15) ,
    dateCode DATE NOT NULL,
	payment DOUBLE NOT NULL,
	orderQuantity  INT(11) NOT NULL,
	PRIMARY KEY (orderNumber, productCode)
);

INSERT INTO Order_tab (orderNumber, productCode, customerNumber, employeeNumber, locationCode, dateCode, payment, orderQuantity)
select od.orderNumber, od.productCode, o.customerNumber, c.salesRepEmployeeNumber, c.postalCode, 
o.orderDate, od.priceEach*od.quantityOrdered, od.quantityOrdered from orderdetails od
left join orders o on od.orderNumber = o.orderNumber
left join customers c on c.customerNumber = o.customerNumber;