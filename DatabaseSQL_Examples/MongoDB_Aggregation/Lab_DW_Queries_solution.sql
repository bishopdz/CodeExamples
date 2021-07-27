--SELECT a.Category, m.category
SELECT a.Category, 
       c.City, 
       c.State, 
       SUM((s.Quantity*s.SalePrice)+s.SalesTax) TotalPrice, 
       SUM(s.Quantity) TotalCount
  FROM Sales s
  JOIN Animal a ON s.animalid = a.animalid
  JOIN Customer c ON s.CustomerID = c.CUSTOMERID
 GROUP BY ROLLUP(a.Category,c.State,c.City)
 ORDER BY 1, TotalPrice ASC;
 
/*

1(a) - Total amount of animal sales -             $32,308.18
1(b) - Category with the most sales by price -    Dog - $17941.83
1(c) - Category with the most sales by count -    Dog - 95 total sales
1(d) - State with the most sales of Dogs -        KY - $2,612.63 (14 total sales)
1(e) - City/State with the most Cat sales -       Chapel Hill, NC ($614.43, 3 total sales)
1(f) - Animal category that sold the fewest -     Spider $384.92 (3 total sales)
1(g) - Information you cannot discern -           You cannot find any information where
                                                   the Category is NULL except the overall
                                                   total.

*/

SELECT dl.month, m.DESCRIPTION, s.name, s.state, SUM(o.quantity*o.COST), AVG(o.shippingcost), SUM(o.quantity)
FROM ORDERS o
NATURAL JOIN Merchandise m
NATURAL JOIN Supplier s 
JOIN DATELOOKUP dl ON o.orderdate = dl.dateid
--WHERE s.Name IS NOT NULL AND dl.month is null and m.description is null and s.state is null
GROUP BY CUBE(dl.month, m.description, s.name, s.state)
ORDER BY 1,4,6 DESC;

/*

2(a) - Month with the highest number of orders -  May - 4383 Total Orders, $7,379.81
2(b) - Supplier that supplied the most in May -   Parrish (2001)
2(c) - Supplier with the highest avg shipping -   Osborne - $43.53
2(d) - State with the highest avg shipping -      NE - $35.10
2(e) - Month with highest avg shipping in NE -    September - $37.98
2(f) - Month to reorder supplies, pref. suppl. -  June, Harrison - Shipping only averaged $14.22 

*/

/* PART 3 QUERIES */
SELECT * FROM
(SELECT 'Sale' typ, d.MONTH mon, sum(s.quantity) ct
   FROM sales s
   JOIN animal a ON s.animalid = a.animalid
   JOIN datelookup d ON s.SALEDATE = d.DATEID
  WHERE d.year = '2004'
  GROUP BY ROLLUP('Sale', d.month)
UNION
 SELECT 'Order' typ, d.month mon, sum(o.quantity) ct
   FROM orders o
   JOIN animal a ON o.animalid = a.animalid
   JOIN datelookup d ON o.ORDERDATE = d.dateid
  WHERE d.year = '2004'
GROUP BY ROLLUP('Order',  d.month))
ORDER BY 1, TO_DATE('01-' || NVL(mon,'DEC') || '-2004', 'DD-MON-YYYY');

/* #3 - Analysis

When tracking animal sales, versus animal orders, the following trend is observed:

1. Both animal orders and sales occur frequently in January and February and drop
    off sharply for March.
2. Orders exceed sales from January to April. In May, sales exceed orders. This
    is most likely because of supply and demand. Notice that the total number
    of animals sold from Jan to Dec 2004 was 185, while the total number of
    animals ordered from Jan to July 2004 was 189.
3. This information indicates the company pre-orders animals rather than ordering
    them after they run out.

*/

SELECT * FROM
(SELECT 'Sale' typ, d.MONTH mon, sum(s.quantity) ct
   FROM sales s
   JOIN merchandise m ON s.merchandiseid = m.MERCHANDISEID
   JOIN datelookup d ON s.SALEDATE = d.DATEID
  WHERE d.year = '2004'
  GROUP BY ROLLUP('Sale', d.month)
UNION
 SELECT 'Order' typ, d.month mon, sum(o.quantity) ct
   FROM orders o
   JOIN merchandise m ON o.MERCHANDISEID = m.MERCHANDISEID
   JOIN datelookup d ON o.ORDERDATE = d.dateid
  WHERE d.year = '2004'
GROUP BY ROLLUP('Order',  d.month))
ORDER BY 1, TO_DATE('01-' || NVL(mon,'DEC') || '-2004', 'DD-MON-YYYY');

/*

For merchandise orders and sales, a trend would be extrememly difficult to
establish. This is because the total orders in 2004 were 14,912, compared to
only 1,273 sales during the same period. Therefore, we cannot establish a trend
for merchandise orders and sales.

*/