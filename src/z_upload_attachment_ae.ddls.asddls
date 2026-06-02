@EndUserText.label: 'Action Param for Uploading Attachment'
define root abstract entity Z_UPLOAD_ATTACHMENT_AE
{
// Dummy is a dummy field
@UI.hidden: true
dummy : abap_boolean;
     _StreamProperties : association [1] to Z_FILE_STREAM_AE on 1 = 1;
    
}
