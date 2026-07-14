/* ---------------------------------------------------------
SECTION 1: GEOGRAPHICAL MARKET ANALYSIS AND GLOBAL SALES 
PERFORMANCE EVALUATION

Objective: To obtain data-driven insights by comprehensively analyzing 
country-based order volumes and revenue distribution in order to 
prioritize logistics operations, identify regional performance 
differences, and develop sustainable market growth strategies.
--------------------------------------------------------- */

select Country
,count(distinct InvoiceDate) as 'Total Orders'
,sum(Quantity * UnitPrice) as 'Total Revenue'
from Sales
group by Country
order by 'Total Revenue'

/* ----------------------------------------------------
SECTION 2: SALES TIMING AND ADVERTISING STRATEGY 
PERFORMANCE ANALYSIS

Objective: To obtain data-driven insights by analyzing 
order intensity based on time patterns, identifying the time 
periods with the highest sales performance, optimizing advertising 
budgets effectively, and directing marketing resources in line 
with data-driven strategies.
--------------------------------------------------------- */

select datepart(hour,InvoiceDate) as 'Sales Hour'
,count(distinct InvoiceNo) as 'Total Sales'-- Calculating the total number of invoices generated during the specified hour
,cast(sum(Quantity * UnitPrice) as decimal(10,2)) as 'Total Revenue' -- Calculating the total revenue generated during the specified hour
from Sales
group by datepart(hour,InvoiceDate)
order by [Total Sales]  desc

/* ---------------------------------------------------------
SECTION 3: PRODUCT PERFORMANCE AND INVENTORY STRATEGY 
ANALYSIS

Objective: To obtain data-driven insights by identifying 
the Top 10 highest-performing products based on sales volume and 
revenue performance, analyzing popular products, optimizing 
inventory management processes, and uncovering cross-selling 
opportunities through data-driven approaches.
--------------------------------------------------------- */

select Description as 'Product Name'
,sum(Quantity) as 'Total Sales Quantity'
,cast(sum(Quantity * UnitPrice) as decimal(10,2)) as 'Total Revenue'
,count(distinct InvoiceNo) 'Order Count'
from Sales
group by Description
order by [Total Sales Quantity] desc

/* ---------------------------------------------------------
SECTION 4: CUSTOMER LOYALTY AND VIP SEGMENTATION 
ANALYSIS

Objective: To identify the Top 10 highest-performing 
customers based on spending amount and purchase frequency, 
analyze customer behaviors, and develop loyalty programs and 
customer retention strategies based on the obtained data-driven 
insights.
--------------------------------------------------------- */

select TOP 10 
CustomerID
,count(distinct InvoiceNo) as 'Total Visits'
,sum(Quantity) as 'Total Quantity Purchased'
,cast(sum(Quantity * UnitPrice) as decimal(10,2)) as 'Customer Revenue Contribution' 
from Sales
where CustomerID is not null
and Quantity > 0
group by CustomerID
order by [Customer Revenue Contribution] desc