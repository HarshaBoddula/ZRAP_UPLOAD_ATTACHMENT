@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZHSHT_PURCHASEOR'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_HSHT_PURCHASEOR
  as select from zhsht_purchaseor
{
  key po as Po,
  key po_item as PoItem,
  status as Status,
  'upload' as Upload,
  @Semantics.largeObject : {
            mimeType: 'Mimetype',
            fileName: 'Filename',
            contentDispositionPreference: #INLINE
          }
  attachment as Attachment,
  filename as Filename,
  @Semantics.mimeType: true
  mimetype as Mimetype,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
