@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z14_I_Employee
  as select from z14_employee
  association [0..*] to Z14_I_Order as _Orders on $projection.EmployeeId = _Orders.EmployeeId
{
  key employee_id as EmployeeId,
      first_name  as FirstName,
      last_name   as LastName,
      concat_with_space( first_name, last_name, 1 ) as FullName,
      role        as Role,

      _Orders
}
