@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant (View helper)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity Z14_I_PLANT_VH
  as select from z14_plant
{
@ObjectModel.text.element: ['PlantName']
  key plant_id       as PlantId,
      name           as PlantName
}
