CLASS lhc_delivery DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setInitialDeliveryData FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Delivery~setInitialDeliveryData.

ENDCLASS.

CLASS lhc_delivery IMPLEMENTATION.

  METHOD setInitialDeliveryData.
    READ ENTITIES OF Z14_I_Order IN LOCAL MODE
    ENTITY Delivery
        FIELDS ( CurrencyCode ShippingDate )
        WITH CORRESPONDING #( keys )
    RESULT DATA(lt_deliveries).

    MODIFY ENTITIES OF Z14_I_Order IN LOCAL MODE
    ENTITY Delivery
    UPDATE FIELDS ( CurrencyCode ShippingDate )
        WITH VALUE #( FOR ls_delivery IN lt_deliveries (
                       %tky =  ls_delivery-%tky
                       CurrencyCode = 'EUR'
                       ShippingDate = cl_abap_context_info=>get_system_date(  )
                    ) ).

  ENDMETHOD.

ENDCLASS.

