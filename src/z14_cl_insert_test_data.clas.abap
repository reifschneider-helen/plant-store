CLASS z14_cl_insert_test_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z14_cl_insert_test_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*  CLEAN TABLES
    DELETE FROM z14_customer.
    DELETE FROM z14_employee.
    DELETE FROM z14_plant.
    DELETE FROM z14_order.
    DELETE FROM z14_order_item.
    DELETE FROM z14_delivery.
    DELETE FROM z14_status_txt.


*     Fill Customer
    INSERT z14_customer FROM TABLE @(
        VALUE #(

          ( client = sy-mandt customer_id = '00000001' first_name = 'Anna'  last_name = 'Meier'   city = 'Berlin'    email = 'anna@mail.com' )
          ( client = sy-mandt customer_id = '00000002' first_name = 'Max'   last_name = 'Schmidt' city = 'Hamburg'   email = 'max@mail.com' )
          ( client = sy-mandt customer_id = '00000003' first_name = 'Laura' last_name = 'Becker'  city = 'Munich'    email = 'laura@mail.com' )
          ( client = sy-mandt customer_id = '00000004' first_name = 'Tom'   last_name = 'Wagner'  city = 'Cologne'   email = 'tom@mail.com' )
          ( client = sy-mandt customer_id = '00000005' first_name = 'Sofia' last_name = 'Klein'   city = 'Stuttgart' email = 'sofia@mail.com' )

        )
     ).

*     Fill Employee
    INSERT z14_employee FROM TABLE @(
        VALUE #(

          ( client = sy-mandt employee_id = '00000010' first_name = 'Laura' last_name = 'Palmer'  role = 'Manager' )
          ( client = sy-mandt employee_id = '00000011' first_name = 'Dale'  last_name = 'Cooper' role = 'Sales' )

        )
    ).

*    Fill Plant
    INSERT z14_plant FROM TABLE @(
        VALUE #(
          ( client = sy-mandt plant_id = '00000100' name = 'Rose'   category_id = '00000001' price = 10 currency_code = 'EUR' stock_quantity = 100 quantity_unit = 'PCE' )
          ( client = sy-mandt plant_id = '00000101' name = 'Tulip'  category_id = '00000001' price = 5  currency_code = 'EUR' stock_quantity = 200 quantity_unit = 'PCE' )
          ( client = sy-mandt plant_id = '00000102' name = 'Cactus' category_id = '00000002' price = 15 currency_code = 'EUR' stock_quantity = 80  quantity_unit = 'PCE' )
          ( client = sy-mandt plant_id = '00000103' name = 'Orchid' category_id = '00000001' price = 25 currency_code = 'EUR' stock_quantity = 60  quantity_unit = 'PCE' )

        )
    ).

**    Fill Order
*    INSERT z14_order FROM TABLE @(
*        VALUE #(
*
*          ( client = sy-mandt order_id = '00001000' customer_id = '00000001' employee_id = '00000010' order_date = '20260520' order_status = 'P' )
*          ( client = sy-mandt order_id = '00001001' customer_id = '00000002' employee_id = '00000010' order_date = '20260520' order_status = 'P' )
*          ( client = sy-mandt order_id = '00001002' customer_id = '00000003' employee_id = '00000011' order_date = '20260521' order_status = 'P' )
*          ( client = sy-mandt order_id = '00001003' customer_id = '00000004' employee_id = '00000011' order_date = '20260522' order_status = 'P' )
*          ( client = sy-mandt order_id = '00001004' customer_id = '00000005' employee_id = '00000010' order_date = '20260601' order_status = 'C' )
*          ( client = sy-mandt order_id = '00001005' customer_id = '00000001' employee_id = '00000011' order_date = '20260602' order_status = 'O' )
*
*        )
*    ).
*
**    Fill Order_item
*    INSERT z14_order_item FROM TABLE @(
*        VALUE #(
*
*          ( client = sy-mandt order_item_id = '00002001' order_id = '00001000' plant_id = '00000100' order_quantity = 2 unit_price = 10 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002002' order_id = '00001000' plant_id = '00000101' order_quantity = 5 unit_price = 5  quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002003' order_id = '00001001' plant_id = '00000102' order_quantity = 1 unit_price = 15 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002004' order_id = '00001001' plant_id = '00000103' order_quantity = 2 unit_price = 25 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002005' order_id = '00001002' plant_id = '00000101' order_quantity = 3 unit_price = 5  quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002006' order_id = '00001002' plant_id = '00000100' order_quantity = 4 unit_price = 10 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002007' order_id = '00001003' plant_id = '00000102' order_quantity = 2 unit_price = 15 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002008' order_id = '00001003' plant_id = '00000103' order_quantity = 1 unit_price = 25 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002009' order_id = '00001004' plant_id = '00000100' order_quantity = 6 unit_price = 10 quantity_unit = 'EA' currency_code = 'EUR' )
*          ( client = sy-mandt order_item_id = '00002010' order_id = '00001005' plant_id = '00000101' order_quantity = 3 unit_price = 5  quantity_unit = 'EA' currency_code = 'EUR' )
*
*        )
*    ).
*
*
**    Fill Delivery
*    INSERT z14_delivery FROM TABLE @(
*        VALUE #(
*
*          ( client = sy-mandt delivery_id = '00003001' order_id = '00001000' delivery_status = 'S' shipping_date = '20260522' delivery_cost = 5 currency_code = 'EUR' tracking_number = 'TR1001' )
*          ( client = sy-mandt delivery_id = '00003002' order_id = '00001001' delivery_status = 'N' shipping_date = '20260522' delivery_cost = 7 currency_code = 'EUR' tracking_number = 'TR1002' )
*          ( client = sy-mandt delivery_id = '00003003' order_id = '00001002' delivery_status = 'I' shipping_date = '20260524' delivery_cost = 4 currency_code = 'EUR' tracking_number = 'TR1003' )
*          ( client = sy-mandt delivery_id = '00003004' order_id = '00001003' delivery_status = 'I' shipping_date = '20260524' delivery_cost = 6 currency_code = 'EUR' tracking_number = 'TR1004' )
*
*        )
*    ).


*    Fill Status
    INSERT z14_status_txt FROM TABLE @(
     VALUE #(
      ( langu = 'E' context = 'ORDER' status_code = 'O' status_text = 'Opened'       criticality = 0 )
      ( langu = 'E' context = 'ORDER' status_code = 'P' status_text = 'Payed'        criticality = 3 )
      ( langu = 'E' context = 'ORDER' status_code = 'C' status_text = 'Cancelled'    criticality = 1 )

      ( langu = 'D' context = 'ORDER' status_code = 'O' status_text = 'Offen'        criticality = 0 )
      ( langu = 'D' context = 'ORDER' status_code = 'P' status_text = 'Bezahlt'      criticality = 3 )
      ( langu = 'D' context = 'ORDER' status_code = 'C' status_text = 'Storniert'    criticality = 1 )

      ( langu = 'E' context = 'DELIVERY' status_code = 'N' status_text = 'Not Shipped'  criticality = 1 )
      ( langu = 'E' context = 'DELIVERY' status_code = 'I' status_text = 'In Delivery'  criticality = 2 )
      ( langu = 'E' context = 'DELIVERY' status_code = 'S' status_text = 'Shipped'      criticality = 3 )

      ( langu = 'D' context = 'DELIVERY' status_code = 'N' status_text = 'Nicht versendet' criticality = 1 )
      ( langu = 'D' context = 'DELIVERY' status_code = 'I' status_text = 'In Zustellung'   criticality = 2 )
      ( langu = 'D' context = 'DELIVERY' status_code = 'S' status_text = 'Versendet'       criticality = 3 )
      )
    ).

    out->write( |Tables  were filled successfull { sy-dbcnt }| ).



  ENDMETHOD.
ENDCLASS.
