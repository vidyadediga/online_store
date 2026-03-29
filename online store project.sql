drop table if exists Books;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);



drop table if exists customer;
create table Customers(
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country varchar(150)
);
drop table if exists orders;
create table Orders(
Order_Id serial primary key,
Customer_ID int references Customers(Customer_ID),
Book_ID int references Books(Book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2));

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\online store\Books.csv'
CSV HEADER;


COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\online store\Customers.csv'
csv header;
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\online store\Orders.csv' 
CSV HEADER;

select * from books
where genre='Fiction';

select * from books
where published_year>1950;

select*from customers
where country='Canada';

select * from orders
where order_date between '2023-11-01' and '2023-11-30';

select sum(stock) as total_stock from books;

select * from books
order by Price desc Limit 1;

select * from Customers;
select * from orders;

select * from orders
where quantity>1;

select *from orders 
where total_amount>20;

select distinct genre from books;
select *from books
order by stock  limit 1;

select sum(total_amount) as total_revenue from orders; 

select * from orders;
-- Advance questions:
select * from orders; 
select b.genre,sum(o.quantity)
from orders o
join books b on o.book_id=b.book_id
group by b.genre;

select avg(price) from books
where genre='Fantasy';

select customer_id, count(order_id)
from orders
group by customer_id
having count(order_id)>=2;

select book_id, count(order_id) as order_count
from orders
group by book_id
order by  order_count desc limit 1;

select * from books;
select book_id from books
where genre='Fantasy'
order by book_id  desc limit 3; 

select b.author,sum(o.quantity) as total_books_sold
from  orders o
join books b on o.book_id=b.book_id
group by b.author;

select * from orders;
select distinct c.city,total_amount 
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount>30;

select c.customer_id,c.name,sum(o.total_amount) as total_spent
from orders o
join customers c
on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc;

--imp query
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0)as order_quantity,
b.stock - coalesce(sum(o.quantity),0)as remaining_quantity
from books b
left join orders o 
on b.book_id=o.book_id
group by b.book_id;
