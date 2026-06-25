CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS setInitialItemData FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~setInitialItemData.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD setInitialItemData.
    READ ENTITIES OF Z14_I_Order IN LOCAL MODE
    ENTITY Item
        FIELDS ( CurrencyCode QuantityUnit )
        WITH CORRESPONDING #( keys )
    RESULT DATA(lt_items).

    MODIFY ENTITIES OF Z14_I_Order IN LOCAL MODE
    ENTITY Item
        UPDATE FIELDS ( CurrencyCode QuantityUnit )
        WITH VALUE #( FOR ls_item IN lt_items (
                        %tky = ls_item-%tky
                        CurrencyCode = 'EUR'
                        QuantityUnit = 'EA'
                     ) ).
  ENDMETHOD.
ENDCLASS.

