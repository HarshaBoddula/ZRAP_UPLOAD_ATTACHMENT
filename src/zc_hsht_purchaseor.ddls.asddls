@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZHSHT_PURCHASEOR'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_HSHT_PURCHASEOR
  provider contract transactional_query
  as projection on ZR_HSHT_PURCHASEOR
  association [1..1] to ZR_HSHT_PURCHASEOR as _BaseEntity on $projection.Po = _BaseEntity.Po and $projection.PoItem = _BaseEntity.PoItem
{
  key Po,
  key PoItem,
  Status,
  Upload,
  Attachment,
  Filename,
  Mimetype,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
