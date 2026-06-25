CLASS z14_cl_show_version DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS z14_cl_show_version IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( |SAP System Release: { sy-saprl }| ).
  ENDMETHOD.

ENDCLASS.
