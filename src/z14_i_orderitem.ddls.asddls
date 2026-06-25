@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order item (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_I_OrderItem
  as select from z14_order_item
  association to parent Z14_I_Order as _Order on $projection.OrderId = _Order.OrderId
  association [1..1] to Z14_I_Plant as _Plant on $projection.PlantId = _Plant.PlantId
{
      @ObjectModel.foreignKey.association: '_Order'
  key order_id       as OrderId,
  key order_item_id  as OrderItemId,
      @ObjectModel.foreignKey.association: '_Plant'
      plant_id       as PlantId,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      order_quantity as OrderQuantity,
      quantity_unit  as QuantityUnit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      unit_price     as UnitPrice,
      currency_code  as CurrencyCode,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'      
      cast(
        cast( unit_price as abap.dec(13,2) ) * 
        cast( order_quantity as abap.dec(13,2))
        as z14_price)  as ItemTotalPrice,

      _Plant.Name as PlantName,
      _Plant.CategoryId as PlantCategoryId,

      _Order,
      _Plant
}
