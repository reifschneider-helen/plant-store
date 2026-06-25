@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'OrderStatus (View Helper)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_I_OrderStatus_VH as select from z14_status_txt
{

    key status_code as StatusCode,
    status_text as StatusText
}

where context = 'ORDER'
    and langu = $session.system_language
