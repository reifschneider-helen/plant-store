@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Order (Interface)'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity Z14_I_Order
  as select from z14_order
      composition [0..*] of Z14_I_OrderItem as _Items
      composition [0..*] of Z14_I_Delivery  as _Deliveries 
      
      association [1..1] to Z14_I_Customer  as _Customer   
        on $projection.CustomerId = _Customer.CustomerId
      association [1..1] to Z14_I_Employee  as _Employee   
        on $projection.EmployeeId = _Employee.EmployeeId
            
      association [1..1] to Z14_I_OrderWithTotals as _Totals 
        on $projection.OrderId = _Totals.OrderId
      association [0..1] to Z14_I_StatusText as _StatusText
        on $projection.OrderStatus = _StatusText.StatusCode
            and _StatusText.Context = 'ORDER'
            and _StatusText.Langu = $session.system_language
{
  key order_id     as OrderId,
      @ObjectModel.foreignKey.association: '_Customer'
      customer_id  as CustomerId,
      @ObjectModel.foreignKey.association: '_Employee'
      employee_id  as EmployeeId,
      order_date   as OrderDate,
      order_status as OrderStatus, 
      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      
      _StatusText.StatusText as StatusText,
      _StatusText.Criticality as StatusCriticality,
      
      
      @Semantics.amount.currencyCode: 'CurrencyCode'      
      _Totals.ItemsTotalPrice as ItemsTotalPrice, 
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Totals.TotalPrice as TotalPrice, 
      _Totals.CurrencyCode as CurrencyCode, 


      _Customer,
      _Employee,
      _Items,
      _Deliveries,
      _StatusText
}
