@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order item (Projection)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_C_ORDERITEM
  as projection on Z14_I_OrderItem
{
  key OrderId,
  key OrderItemId,
      @ObjectModel.text.element: ['PlantName']
      PlantId,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      OrderQuantity,
      QuantityUnit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      UnitPrice,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ItemTotalPrice,
      CurrencyCode,
      
      PlantName,
      PlantCategoryId,
      /* Associations */
      _Order : redirected to parent Z14_C_Order,
      _Plant
}
