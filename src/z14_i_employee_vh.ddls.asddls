@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (View helper)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS

define view entity Z14_I_EMPLOYEE_VH
  as select from z14_employee
{
  key employee_id as EmployeeId,
      first_name as FirstName,
      last_name as LastName,
      concat_with_space( first_name, last_name, 1 ) as FullName,
      role        as Role
}
