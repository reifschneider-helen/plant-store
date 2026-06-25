@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Totals (Aggregation)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z14_I_OrderWithTotals
as select from Z14_I_OrderItem as _OrderItem
    left outer join Z14_I_Delivery as _Delivery
        on _OrderItem.OrderId = _Delivery.OrderId
{
    key _OrderItem.OrderId as OrderId,
    
    @Semantics.amount.currencyCode: 'CurrencyCode'    
    sum(_OrderItem.ItemTotalPrice) as ItemsTotalPrice,
    
    @Semantics.amount.currencyCode: 'CurrencyCode'
    cast(
        cast(sum(_OrderItem.ItemTotalPrice) as abap.dec(13,2))
      + coalesce(max(cast(_Delivery.DeliveryCost as abap.dec(13,2))), 0) 
      as z14_price) as TotalPrice,
    _OrderItem.CurrencyCode

}
    group by _OrderItem.OrderId, _OrderItem.CurrencyCode
