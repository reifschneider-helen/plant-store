CLASS lcl_reset_number_range DEFINITION.
  PUBLIC SECTION.
    TYPES ty_c10 TYPE c LENGTH 10.

    TYPES: BEGIN OF ty_result,
             object  TYPE ty_c10,
             success TYPE abap_bool,
             message TYPE string,
           END OF ty_result.

    CONSTANTS: cv_default_interval TYPE cl_numberrange_runtime=>nr_interval VALUE '01',
               cv_proc_insert      TYPE c LENGTH 1 VALUE 'I'.

    METHODS delete
      IMPORTING iv_obj           TYPE ty_c10
      RETURNING VALUE(rs_result) TYPE ty_result.

    METHODS create
      IMPORTING iv_obj           TYPE ty_c10
      RETURNING VALUE(rs_result) TYPE ty_result.
ENDCLASS.

CLASS lcl_reset_number_range IMPLEMENTATION.

  METHOD delete.
    rs_result = VALUE #( object = iv_obj success = abap_false ).
    DATA lv_error TYPE cl_numberrange_intervals=>nr_error.

    TRY.
        cl_numberrange_intervals=>delete(
          EXPORTING
            object   = iv_obj
            interval = VALUE #( ( nrrangenr = cv_default_interval ) )
          IMPORTING
            error    = lv_error ).

        IF lv_error IS INITIAL.
          rs_result-success = abap_true.
          rs_result-message = |Interval { cv_default_interval } successfully deleted.|.
        ELSE.
          rs_result-message = |Deletion failed with application error: { lv_error }|.
        ENDIF.

      CATCH cx_number_ranges INTO DATA(lx_error).
        rs_result-message = |Critical Exception: { lx_error->get_text( ) }|.
    ENDTRY.
  ENDMETHOD.

  METHOD create.
    rs_result = VALUE #( object = iv_obj success = abap_false ).
    DATA lv_error TYPE cl_numberrange_intervals=>nr_error.

    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            object   = iv_obj
            interval = VALUE #( ( nrrangenr  = cv_default_interval
                                  fromnumber = '00000001'
                                  tonumber   = '99999999'
                                  procind    = cv_proc_insert ) )
          IMPORTING
            error    = lv_error ).

        IF lv_error IS INITIAL.
          rs_result-success = abap_true.
          rs_result-message = |Interval { cv_default_interval } successfully created.|.
        ELSE.
          rs_result-message = |Creation failed with application error: { lv_error }|.
        ENDIF.

      CATCH cx_number_ranges INTO DATA(lx_error).
        rs_result-message = |Critical Exception: { lx_error->get_text( ) }|.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
