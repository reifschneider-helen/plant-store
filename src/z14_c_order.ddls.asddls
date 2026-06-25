@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Order (Projection)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z14_C_Order
  provider contract transactional_query
  as projection on Z14_I_Order

{
  key OrderId,
  
      OrderDate,
      @ObjectModel.text.element: ['StatusText']
      OrderStatus,
      LocalLastChangedAt,
      StatusText,
      StatusCriticality,
      
      @ObjectModel.text.element: ['CustomerName']
      CustomerId,
      _Customer.FullName as CustomerName,
      _Customer.City as CustomerCity,
      _Customer.Email as CustomerEmail,
      
      @ObjectModel.text.element: ['EmployeeName']
      EmployeeId,
      _Employee.FullName as EmployeeName,
      _Employee.Role as EmployeeRole,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ItemsTotalPrice,            
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      
      /* Associations */
      _Customer,
      _Employee,
      
      _Deliveries : redirected to composition child Z14_C_DELIVERY,      
      _Items : redirected to composition child Z14_C_ORDERITEM
}
