CLASS lhc_ZR_HSHT_PURCHASEOR2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_hsht_purchaseor2 RESULT result.

    METHODS UploadAttachment FOR MODIFY
      IMPORTING keys FOR ACTION zr_hsht_purchaseor2~UploadAttachment RESULT result.

ENDCLASS.

CLASS lhc_ZR_HSHT_PURCHASEOR2 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD UploadAttachment.


  "Prepare EML update table for root entity
  DATA lt_update TYPE TABLE FOR UPDATE zr_hsht_purchaseor2.

  LOOP AT keys INTO DATA(ls_key).

    "1) Read file data from the action parameter (from your debugger screenshot)
    DATA(lv_stream)   = VALUE xstring( ).
    DATA(lv_mimetype) = VALUE string( ).
    DATA(lv_filename) = VALUE string( ).

    lv_stream   = ls_key-%param-_streamproperties-StreamProperty.
    lv_mimetype = ls_key-%param-_streamproperties-mimetype.
    lv_filename = ls_key-%param-_streamproperties-filename.

    "2) Basic guard (optional): if nothing uploaded, just return message
    IF lv_stream IS INITIAL.
      APPEND VALUE #(
        %tky = ls_key-%tky
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'No file content received. Please select a file and try again.'
               )
      ) TO reported-zr_hsht_purchaseor2.
      APPEND VALUE #(
        %tky = ls_key-%tky
*        %msg = new_message_with_text(
*                 severity = if_abap_behv_message=>severity-error
*                 text     = 'No file content received. Please select a file and try again.'
*               )
      ) TO failed-zr_hsht_purchaseor2.
      CONTINUE.
    ENDIF.

    "3) Build update for this instance (important: set %control = mk-on)
    APPEND VALUE #(
      %tky = ls_key-%tky

      Attachment = lv_stream
      Filename   = lv_filename
      Mimetype   = lv_mimetype

      %control-Attachment = if_abap_behv=>mk-on
      %control-Filename   = if_abap_behv=>mk-on
      %control-Mimetype   = if_abap_behv=>mk-on
    ) TO lt_update.

  ENDLOOP.

  "4) Persist the update using EML
  MODIFY ENTITIES OF zr_hsht_purchaseor2 IN LOCAL MODE
    ENTITY zr_hsht_purchaseor2
    UPDATE FROM lt_update
    REPORTED DATA(lt_reported)
    FAILED   DATA(lt_failed).

  "5) Return updated instance (so UI can refresh row values)
  READ ENTITIES OF zr_hsht_purchaseor2 IN LOCAL MODE
    ENTITY zr_hsht_purchaseor2
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

  result = VALUE #( FOR r IN lt_result (
              %tky   = r-%tky
              %param = r
           ) ).

  ENDMETHOD.

ENDCLASS.
