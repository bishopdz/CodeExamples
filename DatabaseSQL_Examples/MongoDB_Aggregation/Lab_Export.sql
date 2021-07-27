/*

   ORDERS QUERY
 
*/

select
   o.orderid "orderid"                                ,
   to_char(od.thedate, 'yyyy-mm-dd') "orderdate"      ,
   to_char(rd.thedate, 'yyyy-mm-dd') "receiveddate"   ,
   o.quantity "quantity"                              ,
   o.cost "cost"                                      ,
   o.shippingcost "shippingcost"                      ,
   o.animalid "animal.animalid"                       ,
   a.name "animal.name"                               ,
   a.category "animal.category"                       ,
   a.breed "animal.breed"                             ,
   to_char(a.dateborn,'yyyy-mm-dd') "animal.dateborn" ,
   a.gender "animal.gender"                           ,
   a.registered "animal.registered"                   ,
   a.color "animal.color"                             ,
   a.listprice "animal.listprice"                     ,
   o.merchandiseid "merchandise.merchandiseid"        ,
   m.description "merchandise.description"            ,
   m.quantityonhand "merchandise.quantityonhand"      ,
   m.listprice "merchandise.listprice"                ,
   m.category "merchandise.category"                  ,
   o.supplierid "supplier.supplierid"                 ,
   s.name "supplier.name"                             ,
   s.contactname "supplier.contactname"               ,
   s.phone "supplier.phone"                           ,
   s.address "supplier.address"                       ,
   s.city "supplier.city"                             ,
   s.state "supplier.state"                           ,
   s.zipcode "supplier.zipcode"
from
   orders o
   left join
      datelookup od
      on
         o.orderdate = od.dateid
   left join
      datelookup rd
      on
         o.receiveddate = rd.dateid
   left join
      animal a
      on
         o.animalid = a.animalid
   left join
      merchandise m
      on
         o.merchandiseid = m.merchandiseid
   left join
      supplier s
      on
         o.supplierid = s.supplierid
order by
   orderid
;


/*

	SALES QUERY

*/


select
   s.salefactid "salefactid"                          ,
   s.saleid "saleid"                                  ,
   to_char(sd.thedate,'yyyy-mm-dd') "saledate"        ,
   s.customerid "customer.customerid"                 ,
   c.firstname "customer.firstname"                   ,
   c.lastname "customer.lastname"                     ,
   c.phone "customer.phone"                           ,
   c.address "customer.address"                       ,
   c.city "customer.city"                             ,
   c.state "customer.state"                           ,
   c.zipcode "customer.zipcode"                       ,
   s.animalid "animal.animalid"                       ,
   a.name "animal.name"                               ,
   a.category "animal.category"                       ,
   a.breed "animal.breed"                             ,
   to_char(a.dateborn,'yyyy-mm-dd') "animal.dateborn" ,
   a.gender "animal.gender"                           ,
   a.registered "animal.registered"                   ,
   a.color "animal.color"                             ,
   a.listprice "animal.listprice"                     ,
   s.merchandiseid "merchandise.merchandiseid"        ,
   m.description "merchandise.description"            ,
   m.quantityonhand "merchandise.quantityonhand"      ,
   m.listprice "merchandise.listprice"                ,
   m.category "merchandise.category"                  ,
   s.quantity "quantity"                              ,
   s.saleprice "saleprice"                            ,
   s.salestax "salestax"
from
   sales s
   left join
      datelookup sd
      on
         s.saledate = sd.dateid
   left join
      animal a
      on
         s.animalid = a.animalid
   left join
      merchandise m
      on
         s.merchandiseid = m.merchandiseid
   left join
      customer c
      on
         s.customerid = c.customerid
order by
   salefactid
;