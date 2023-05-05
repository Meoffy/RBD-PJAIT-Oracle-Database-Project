/* Select all customers from a specific city: */

SELECT * FROM KLIENT
INNER JOIN ADRES ON KLIENT.ADRES_ID = ADRES.ADRES_ID
WHERE ADRES.MIASTO = 'Warsaw';

/* Select all products from a specific supplier: */

SELECT * FROM PRODUKT
INNER JOIN DOSTAWCA ON PRODUKT.DOSTAWCA_ID = DOSTAWCA.DOSTAWCA_ID
WHERE DOSTAWCA.NAZWAFIRMY = 'XYZ Corp';

/* Select the names of all customers who have ordered products with a discount greater than 10%: */

SELECT KLIENT.IMIE, KLIENT.NAZWISKO
FROM KLIENT
JOIN ZAMOWIENIE ON KLIENT.KLIENT_ID = ZAMOWIENIE.KLIENT_ID
JOIN ZAMOWIENIEPRODUKT ON ZAMOWIENIE.ZAMOWIENIE_ID = ZAMOWIENIEPRODUKT.ZAMOWIENIE_ID
WHERE ZAMOWIENIEPRODUKT.RABAT > 10;

/*Select the names of products that have been ordered by customers in Poland:*/

SELECT PRODUKT_ID, NAZWA, CENA, KATEGORIA_ID, DOSTAWCA_ID
FROM PRODUKT
WHERE CENA BETWEEN 500 AND 1000;

/*This query is joining the KLIENT, ZAMOWIENIE, and ZAMOWIENIEPRODUKT tables on their respective
IDs and then grouping the results by the client's first name, last name, and email.
The query is also summing the total spent by each client
based on the CENATOTAL column of the ZAMOWIENIEPRODUKT table. The results
  are then ordered by the total spent in descending order.
 */

SELECT IMIE, NAZWISKO, EMAIL, SUM(CENATOTAL) as TotalSpent
FROM KLIENT JOIN ZAMOWIENIE ON KLIENT.KLIENT_ID = ZAMOWIENIE.KLIENT_ID
JOIN ZAMOWIENIEPRODUKT ON ZAMOWIENIE.ZAMOWIENIE_ID = ZAMOWIENIEPRODUKT.ZAMOWIENIE_ID
GROUP BY IMIE, NAZWISKO, EMAIL
ORDER BY TotalSpent DESC;

/*This query selects the name of the shipping company and the number of orders
delivered by that company, by joining the SPEDYTOR and ZAMOWIENIE tables on the SPEDYTOR_ID column.
The results are grouped by the company name and ordered by the number of orders delivered in descending order. */
SELECT NAZWAFIRMY, COUNT(ZAMOWIENIE_ID) as NumberOfOrders
FROM SPEDYTOR JOIN ZAMOWIENIE ON SPEDYTOR.SPEDYTOR_ID = ZAMOWIENIE.SPEDYTOR_ID
GROUP BY NAZWAFIRMY
ORDER BY NumberOfOrders DESC;

/*This query selects the names of all products that were ordered by the client with an ID of 10.
It does this by joining the PRODUCT table with the ORDER_PRODUCT table on the PRODUCT_ID column
and then joining the ORDER table on the ORDER_ID column. It filters the results to only show orders
made by the client with ID 10.*/

SELECT P.NAZWA FROM PRODUKT P
JOIN ZAMOWIENIEPRODUKT ZP ON P.PRODUKT_ID = ZP.PRODUKT_ID
JOIN ZAMOWIENIE Z ON ZP.ZAMOWIENIE_ID = Z.ZAMOWIENIE_ID
WHERE Z.KLIENT_ID = 10;

/*This query calculates the total cost of all products ordered by a specific customer,
identified by their KLIENT_ID, by joining the PRODUCT, ORDER PRODUCT and ORDER tables
and summing the product price multiplied by the quantity ordered.*/

SELECT SUM(P.CENA*ZP.ILOSC) FROM PRODUKT P
JOIN ZAMOWIENIEPRODUKT ZP ON P.PRODUKT_ID = ZP.PRODUKT_ID
JOIN ZAMOWIENIE Z ON ZP.ZAMOWIENIE_ID = Z.ZAMOWIENIE_ID
WHERE Z.KLIENT_ID = 10;

/*This query selects the client ID, first name, and last name from the KLIENT table
where the client ID is present in a subquery that selects the distinct client IDs
from the ZAMOWIENIE table where the order date is between January 1st and January 3rd, 2022.*/

SELECT KLIENT_ID, IMIE, NAZWISKO
FROM KLIENT
WHERE KLIENT_ID IN (
SELECT DISTINCT KLIENT_ID
FROM ZAMOWIENIE
WHERE DATAZAMOWIENIA  BETWEEN DATE '2022-01-01' AND DATE '2022-01-03'
);

/*This query returns the total number of orders that were shipped by a specific
company (in this case, "FedEx"). It does this by joining the ZAMOWIENIE and SPEDYTOR
tables on the SPEDYTOR_ID column and then counting the number of rows that match the specified company name.*/

SELECT COUNT(*)
FROM ZAMOWIENIE
JOIN S25007.SPEDYTOR ON ZAMOWIENIE.SPEDYTOR_ID = SPEDYTOR.SPEDYTOR_ID
WHERE SPEDYTOR.NAZWAFIRMY = 'FedEx';

/*This query selects the name, price, and total quantity sold of each product
from the PRODUCT and ORDER_PRODUCT tables, and groups them by name and price.
The results are ordered by the total quantity sold in descending order.*/

SELECT PRODUKT.NAZWA, PRODUKT.CENA, SUM(ZAMOWIENIEPRODUKT.ILOSC) as LICZBASPRZEDANYCH
FROM PRODUKT
JOIN ZAMOWIENIEPRODUKT ON PRODUKT.PRODUKT_ID = ZAMOWIENIEPRODUKT.PRODUKT_ID
GROUP BY PRODUKT.NAZWA, PRODUKT.CENA
ORDER BY LICZBASPRZEDANYCH DESC;

/*This query selects the shipping company's name, the count of orders for each company,
and the average time between order and shipping date for each company.
The results are grouped by shipping company's name.*/

SELECT SPEDYTOR.NAZWAFIRMY, COUNT(ZAMOWIENIE.SPEDYTOR_ID) as LICZBAPRZESYLEK, AVG(DATAWYSYLKI - DATAZAMOWIENIA) as SREDNICZASDOSTAWY
FROM SPEDYTOR
JOIN ZAMOWIENIE ON SPEDYTOR.SPEDYTOR_ID = ZAMOWIENIE.SPEDYTOR_ID
GROUP BY SPEDYTOR.NAZWAFIRMY;




