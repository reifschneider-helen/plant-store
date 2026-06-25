@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_I_Delivery
  as select from z14_delivery
  association to parent Z14_I_Order as _Order on $projection.OrderId = _Order.OrderId
  
  association [0..1] to Z14_I_StatusText as _StatusText
    on $projection.DeliveryStatus = _StatusText.StatusCode
    and _StatusText.Context = 'DELIVERY'
    and _StatusText.Langu = $session.system_language
{
  key delivery_id     as DeliveryId,
      @ObjectModel.foreignKey.association: '_Order'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'Z14_I_Order', element: 'OrderId' } }]
  key order_id        as OrderId,
      delivery_status as DeliveryStatus,
      _StatusText.StatusText as StatusText,
      _StatusText.Criticality as StatusCriticality,
      
      shipping_date   as ShippingDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      delivery_cost   as DeliveryCost,
      currency_code   as CurrencyCode,
      tracking_number as TrackingNumber,

      _Order,
      _StatusText
}
