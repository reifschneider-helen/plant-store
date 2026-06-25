@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity Z14_I_Customer
  as select from z14_customer
  association [0..*] to Z14_I_Order as _Orders on $projection.CustomerId = _Orders.CustomerId
{
  key customer_id as CustomerId,
      first_name  as FirstName,
      last_name   as LastName,
      concat_with_space( first_name, last_name, 1 ) as FullName,
      city        as City,
      email       as Email,

      _Orders
}
