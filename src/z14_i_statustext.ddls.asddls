@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status text (Interface)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z14_I_StatusText as select from z14_status_txt
{
    key langu as Langu,
    key context as Context,
    key status_code as StatusCode,
    @Semantics.text: true
    status_text as StatusText,
    criticality as Criticality
}

where langu = $session.system_language
