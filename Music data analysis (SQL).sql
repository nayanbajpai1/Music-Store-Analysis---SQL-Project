create database music_store
use music_store
 
-- Import all the flat files of data


-- Q1 Who is the senior most employee based on job title?

select first_name  , title,  datediff(year , birthdate , getdate()) as age from employees e1 
where datediff(year , birthdate , getdate()) = (select max(datediff(year , birthdate , getdate())) from employees e2 
where e1.title = e2.title 
group by e2.title)

-- Q2 Which countries have the most Invoices?

select top 1 billing_country  , count(invoice_id) as invoice_count from invoice 
group by billing_country 
order by invoice_count desc 


-- Q3. What are top 3 values of total invoice?

select top 3 total as top_3_total_invoice from invoice 
order by total desc 

/* Q4. Which city has the best customers? 
We would like to throw a promotional Music Festival in the city we made the most money.
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */


select top 1 billing_city , sum(total) as total_invoice from invoice 
group by billing_city 
order by total_invoice desc

/* Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money */


select top 1 c.first_name, c.last_name , sum(i.total) as total_money from customer c , invoice i
where c.customer_id = i.customer_id 
group by c.first_name , c.last_name 
order by total_money desc




/* Q6. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A */


select distinct  c.email , c.first_name , c.last_name ,g.name from customer c
inner join invoice i on c.customer_id = i.customer_id
inner join invoice_line i_l on i_l.invoice_id = i.invoice_id
inner join track t on t.track_id = i_l.track_id
inner join genre g on g.genre_id = t.genre_id 
where g.name = 'Rock' and c.email like 'A%' order by c.email asc


/* Q7. Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands*/



select top 10 a.name , count(t.track_id) as track_count from artist a
inner join album al  on al.artist_id = a.artist_id
inner join track t on t.album_id = al.album_id
where genre_id = 1 
group by a.name 
order by track_count desc



/* Q8 Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. 
Order by the song length with the longest songs listed first */

select name , milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc




/* Q9. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */



select c.first_name, c.last_name, ar.name as artist_name, sum(il.quantity * il.unit_price) as total_spent from customer c
inner join invoice i on i.customer_id = c.customer_id
inner join invoice_line il on il.invoice_id = i.invoice_id
inner join track t on t.track_id = il.track_id
inner join album alb on alb.album_id = t.album_id
inner join album2 alb2 on alb2.album_id = t.album_id
inner join artist ar on ar.artist_id = alb.artist_id
inner join artist ar2 on ar.artist_id = alb2.artist_id
group by c.first_name ,c.last_name ,  ar.name
order by  total_spent desc



/* 10. Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount */


select i.customer_id ,c.first_name , c.last_name,  i.billing_country , sum(i.total) as total_amount from invoice i  , customer c
where c.customer_id = i.customer_id
group by i.customer_id,c.first_name , c.last_name ,  i.billing_country  
order by total_amount desc 
















