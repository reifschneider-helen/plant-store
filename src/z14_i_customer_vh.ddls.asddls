@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer (View helper)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity Z14_I_CUSTOMER_VH
  as select from z14_customer
{
  key customer_id as CustomerId,
      first_name as FirstName,
      last_name as LastName,
      concat_with_space( first_name, last_name, 1 ) as FullName,
      city        as City
}
