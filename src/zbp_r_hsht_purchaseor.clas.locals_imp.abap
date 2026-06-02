CLASS LHC_ZR_HSHT_PURCHASEOR DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrHshtPurchaseor
        RESULT result,
      UploadAttachment FOR MODIFY
            IMPORTING keys FOR ACTION ZrHshtPurchaseor~UploadAttachment RESULT result.
ENDCLASS.

CLASS LHC_ZR_HSHT_PURCHASEOR IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.


  METHOD UploadAttachment.


  "Prepare EML update table for root entity
  DATA lt_update TYPE TABLE FOR UPDATE zr_hsht_purchaseor.

  READ ENTITIES OF zr_hsht_purchaseor IN LOCAL MODE
    ENTITY ZrHshtPurchaseor
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_selected).

  LOOP AT keys INTO DATA(ls_key).

    DATA(lv_stream)   = VALUE xstring( ).
    DATA(lv_mimetype) = VALUE string( ).
    DATA(lv_filename) = VALUE string( ).

    lv_stream   = ls_key-%param-_streamproperties-StreamProperty.
    lv_mimetype = ls_key-%param-_streamproperties-mimetype.
    lv_filename = ls_key-%param-_streamproperties-filename.

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


  MODIFY ENTITIES OF zr_hsht_purchaseor IN LOCAL MODE
    ENTITY ZrHshtPurchaseor
    UPDATE FROM lt_update
    REPORTED DATA(lt_reported)
    FAILED   DATA(lt_failed).

  READ ENTITIES OF zr_hsht_purchaseor IN LOCAL MODE
    ENTITY ZrHshtPurchaseor
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

  result = VALUE #( FOR r IN lt_result (
              %tky   = r-%tky
              %param = r
           ) ).

  ENDMETHOD.

ENDCLASS.
