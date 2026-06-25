CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Order RESULT result.

    METHODS setInitialOrderData FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialOrderData.
    METHODS cancelOrder FOR MODIFY
      IMPORTING keys FOR ACTION Order~cancelOrder RESULT result.

    METHODS earlynumbering_order FOR NUMBERING
      IMPORTING entities FOR CREATE Order.

    METHODS earlynumbering_cba_deliveries FOR NUMBERING
      IMPORTING entities FOR CREATE Order\_Deliveries.

    METHODS earlynumbering_cba_items FOR NUMBERING
      IMPORTING entities FOR CREATE Order\_Items.
ENDCLASS.

CLASS lhc_order IMPLEMENTATION.
  METHOD get_global_authorizations.
    result-%create = if_abap_behv=>auth-allowed.
    result-%update = if_abap_behv=>auth-allowed.
    result-%delete = if_abap_behv=>auth-allowed.
  ENDMETHOD.

  METHOD earlynumbering_order.

    LOOP AT entities INTO DATA(ls_entity).

      IF ls_entity-OrderId IS INITIAL.
        TRY.
            DATA lv_number TYPE cl_numberrange_runtime=>nr_number.

            cl_numberrange_runtime=>number_get(
                EXPORTING
                    nr_range_nr = '01'
                    object = 'Z14_ORD_NR'
                IMPORTING
                    number = lv_number ).

            APPEND VALUE #(
                   %cid = ls_entity-%cid
                   %is_draft = ls_entity-%is_draft
                   OrderId = CONV z14_order_id( lv_number )
            ) TO mapped-order.

          CATCH cx_number_ranges.

            APPEND VALUE #(
                    %cid = ls_entity-%cid
                    %is_draft = ls_entity-%is_draft
                    ) TO failed-order.
        ENDTRY.

      ELSE.
        APPEND VALUE #(
                %cid = ls_entity-%cid
                %is_draft = ls_entity-%is_draft
                OrderId = ls_entity-OrderId
             ) TO mapped-order.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_items.

    LOOP AT entities INTO DATA(ls_parent).
      READ TABLE mapped-order WITH KEY cid COMPONENTS %cid = ls_parent-%cid_ref
         ASSIGNING FIELD-SYMBOL(<fs_parent_mapped>).

      DATA(lv_mapped_order_id) = COND z14_order_id(
        WHEN <fs_parent_mapped> IS ASSIGNED THEN <fs_parent_mapped>-OrderId
        ELSE ls_parent-OrderId
      ).

      LOOP AT ls_parent-%target INTO DATA(ls_target).
        IF ls_target-OrderItemId IS INITIAL.
          TRY.
              DATA lv_number TYPE cl_numberrange_runtime=>nr_number.

              cl_numberrange_runtime=>number_get(
                  EXPORTING
                      nr_range_nr = '01'
                      object = 'Z14_ITM_NR'
                  IMPORTING
                      number = lv_number
               ).

              APPEND VALUE #(
                 %cid = ls_target-%cid
                 %is_draft = ls_target-%is_draft
                 OrderId =  lv_mapped_order_id
                 OrderItemId = CONV z14_order_item_id( lv_number )
                 ) TO mapped-item.

            CATCH cx_number_ranges.
              APPEND VALUE #(
                  %cid = ls_target-%cid
                  %is_draft = ls_target-%is_draft

                  ) TO failed-item.

          ENDTRY.

        ELSE.
          APPEND VALUE #(
                 %cid = ls_target-%cid
                 %is_draft = ls_target-%is_draft
                 OrderId = lv_mapped_order_id
                 OrderItemId = ls_target-OrderItemId
                 ) TO mapped-item.
        ENDIF.


      ENDLOOP.
    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_deliveries.

    LOOP AT entities INTO DATA(ls_parent).
      READ TABLE mapped-order WITH KEY cid COMPONENTS %cid = ls_parent-%cid_ref
      ASSIGNING FIELD-SYMBOL(<fs_mapped_parent>).

      DATA(lv_mapped_order_id) = COND z14_order_id(
              WHEN <fs_mapped_parent> IS ASSIGNED THEN <fs_mapped_parent>-OrderId
              ELSE ls_parent-OrderId ).


      LOOP AT ls_parent-%target INTO DATA(ls_target).
        IF ls_target-DeliveryId IS INITIAL.
          TRY.
              DATA lv_number TYPE cl_numberrange_runtime=>nr_number.

              cl_numberrange_runtime=>number_get(
                  EXPORTING
                      nr_range_nr = '01'
                      object = 'Z14_DEL_NR'
                  IMPORTING
                      number = lv_number
                   ).

              APPEND VALUE #(
                  %cid = ls_target-%cid
                  %is_draft = ls_target-%is_draft
                  OrderId = lv_mapped_order_id
                  DeliveryId = CONV z14_delivery_id( lv_number )
              ) TO mapped-delivery.

            CATCH cx_number_ranges.
              APPEND VALUE #(
                  %cid = ls_target-%cid
                  %is_draft = ls_target-%is_draft ) TO failed-delivery.
          ENDTRY.

        ELSE.
          APPEND VALUE #(
                  %cid = ls_target-%cid
                  %is_draft = ls_target-%is_draft
                  OrderId = lv_mapped_order_id
                  DeliveryId = ls_target-DeliveryId
              ) TO mapped-delivery.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD setinitialorderdata.
    READ ENTITIES OF Z14_I_Order IN LOCAL MODE
      ENTITY Order
      FIELDS ( OrderDate OrderStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_orders).

    MODIFY ENTITIES OF Z14_I_Order IN LOCAL MODE
      ENTITY Order
      UPDATE FIELDS ( OrderDate OrderStatus )
      WITH VALUE #( FOR ls_order IN lt_orders (
                      %tky        = ls_order-%tky
                      OrderDate   = cl_abap_context_info=>get_system_date( )
                      OrderStatus = 'O'
                    ) ).

  ENDMETHOD.


  METHOD cancelOrder.

    DATA lt_orders_to_update TYPE TABLE FOR UPDATE Z14_I_ORDER\\Order.

    READ ENTITIES OF z14_i_order IN LOCAL MODE
    ENTITY Order
    FIELDS ( OrderStatus  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_orders).

    LOOP AT lt_orders ASSIGNING FIELD-SYMBOL(<ls_order>).
      IF <ls_order>-OrderStatus = 'C'.
        APPEND VALUE #( %tky =  <ls_order>-%tky
                        %fail-cause = if_abap_behv=>cause-conflict ) TO failed-order.

        APPEND VALUE #(  %tky =  <ls_order>-%tky
                         %msg = new_message_with_text(
                         text     = 'Order is already cancelled.'
                         severity = if_abap_behv_message=>severity-error )
              ) TO reported-order.

      ELSE.
        APPEND VALUE #( %tky =  <ls_order>-%tky
                        OrderStatus = 'C'
                      ) TO lt_orders_to_update.
      ENDIF.
    ENDLOOP.

    IF lt_orders_to_update IS NOT INITIAL.
        MODIFY ENTITIES OF Z14_I_Order IN LOCAL MODE
        ENTITY Order
        UPDATE
        FIELDS ( OrderStatus )
        WITH lt_orders_to_update.

                READ ENTITIES OF Z14_I_Order IN LOCAL MODE
        ENTITY Order
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_upd_orders).

        result = VALUE #( FOR ls_upd_order IN lt_upd_orders
                            ( %tky =  ls_upd_order-%tky
                              %param = ls_upd_order )
                        ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

