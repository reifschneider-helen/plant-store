CLASS z14_cl_set_num_range DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z14_cl_set_num_range IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lo_range_handler) = NEW lcl_reset_number_range( ).

    DATA lv_result TYPE lo_range_handler->ty_result.
    " ==========================================
    " 1. Z14_ORD_NR
    " ==========================================
    lv_result = lo_range_handler->delete( 'Z14_ORD_NR' ).
    out->write( lv_result ).
    COMMIT WORK.
    lv_result = lo_range_handler->create( 'Z14_ORD_NR' ).
       out->write( lv_result ).
    COMMIT WORK.

    " ==========================================
    " 2. Z14_ITM_NR
    " ==========================================
    lv_result = lo_range_handler->delete( 'Z14_ITM_NR' ).
           out->write( lv_result ).
    COMMIT WORK.
    lv_result = lo_range_handler->create( 'Z14_ITM_NR' ).
           out->write( lv_result ).
    COMMIT WORK.

    " ==========================================
    " 3. Z14_DEL_NR
    " ==========================================
    lv_result = lo_range_handler->delete( 'Z14_DEL_NR' ).
           out->write( lv_result ).
    COMMIT WORK.
    lv_result = lo_range_handler->create( 'Z14_DEL_NR' ).
           out->write( lv_result ).
    COMMIT WORK.

    out->write( '+++ Interval 01 is setted +++' ).

  ENDMETHOD.
ENDCLASS.
