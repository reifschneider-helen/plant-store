@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_I_Plant
  as select from z14_plant
{
  key plant_id       as PlantId,
      name           as Name,
      category_id    as CategoryId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      currency_code  as CurrencyCode,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      stock_quantity as StockQuantity,
      quantity_unit  as QuantityUnit
}
