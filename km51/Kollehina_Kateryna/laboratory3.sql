-- LABORATORY WORK 3
-- BY Kollehina_Kateryna
 /*1. Написати PL/SQL код, що додає замовлення покупцю з ключем 1000000001, щоб сумарна кількість його замовлень була 4. 
Ключі нових замовлень  - ord1….ordn. Дата цих замовлень відповідає даті замовлення з номером 20005.
10 балів*/
DECLARE 
  v_cust_id customers.cust_id%type;
  v_order_num ordersorder_num%type;
  Ccount integer := 0;
  ord_n integer := 0;
BEGIN
  cust_id := 1000000001
  order_num := 'ord';
  for i in 1..ord_n LOOP
      INSERT INTO products( order_num)
      values(  v_order_num || i)
      EXIT WHEN count(ord_n) =4;
  END LOOP;
end; 

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав більше 10 продуктів - статус  = "yes"
Якщо він продав менше 10 продуктів - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

DECLARE 
  Ccount integer := 0;
  v_vend_status NVARCHAR2;
  v_vend_name vendors.vend_name%type;
  v_vend_id vendors.vend_id%type;
BEGIN
  vendors.vend_id = 'BRSO1';
  select vend_id, 
         vend_name, 
         count(Distinct(products.prod_id))
  into  v_vend_id, 
        v_vend_name,
        Ccount
  from Vendors
  Left JOIN Products
      ON vendors.vend_id = products.vend_id
  WHERE v_vend_id = vend_id;
  
  if Ccount > 10 then
     v_vend_status = 'yes';
  else if Ccount < 10 then
      v_vend_status = 'no';
  else Ccount = 0 then
      v_vend_status = 'unknown';
  DBMS_OUTPUT.PUT_LINE( TRIM(v_vend_name) || v_vend_status)
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести номери замовлення та кількість постачальників, що продавали свої товари у кожне з замовлень.
3.2. Вивести ім'я постачальника за кількість його покупців.
6 балів.*/

CREATE VIEW customers_vendors as
 select
  order_num,
  vend_name,
  vend_id,
  cust_id
  from customers
  JOIN orders
    ON customers.cust_id = orders.cust_id
  JOIN orderitems
    ON orderitems.order_num = orders.order_num
  JOIN products
    ON orderitems.prod_id = products.prod_id
  JOIN vendors
    ON vendors.vend_id = products.vend_id
  group by order_num;
  
  select 
         order_num,
         count(Distinct vendors.vend_id)
  from customers_vendors;
  
  
  select 
         vend_name,
         count(Distinct customers.cust_id)
  from customers_vendors;
