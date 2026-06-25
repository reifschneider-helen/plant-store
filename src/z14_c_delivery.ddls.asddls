@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery (Projection)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true
define view entity Z14_C_DELIVERY
  as projection on Z14_I_Delivery
{
  key DeliveryId,
  key OrderId,
      @ObjectModel.text.element: ['StatusText']
      DeliveryStatus,
      StatusText,
      StatusCriticality,
      
      ShippingDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      DeliveryCost,
      CurrencyCode,
      TrackingNumber,
      /* Associations */
      _Order : redirected to parent Z14_C_Order
}
