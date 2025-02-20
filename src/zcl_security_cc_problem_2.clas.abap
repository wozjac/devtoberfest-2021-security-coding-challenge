CLASS zcl_security_cc_problem_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    "Uses Data Model - https://github.com/SAP-samples/abap-platform-refscen-flight
  PROTECTED SECTION.
  PRIVATE SECTION.
    "Simulate Input Parameters via a constant to keep example UI/Service/Interface agnostic

    "During Input Someone Puts Extra SQL Conditions into the input value - SQL Injection!
    "Remember we are simulating the input here, this normally would come from UI or Service Interface
    CONSTANTS: input TYPE string VALUE `AA' OR CARRIER_ID = 'AZ`.
ENDCLASS.



CLASS zcl_security_cc_problem_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " We could validate allowed input using own rules
    " some_validator->validate_input( ... ) etc.

    " Check authorization(s)
    " AUTHORITY-CHECK OBJECT 'S_CARRID'
    "   ID 'CARRID' FIELD input
    "   ID 'ACTVT'  FIELD '03'.

    " or use whitelists
    " cl_abap_dyn_prg=>check_whitelist_tab( val = input
    "                                       whitelist = ...whitelisted input carriers ).

    DATA(sql) = `CARRIER_ID = @input`.
    " or
    " DATA(sql) = `CARRIER_ID = ` && cl_abap_dyn_prg=>quote( input ).
    SELECT * FROM /dmo/flight WHERE (sql) INTO TABLE @DATA(results).
    out->write( results ).
  ENDMETHOD.
ENDCLASS.
