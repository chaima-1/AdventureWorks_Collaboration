-- Afficher la structure d'une table
EXEC sp_columns 'Purchasing.ProductVendor';
EXEC sp_columns 'Purchasing.PurchaseOrderDetail';
EXEC sp_columns 'Purchasing.PurchaseOrderHeader';
EXEC sp_columns 'Purchasing.ShipMethod';
EXEC sp_columns 'Purchasing.Vendor';
---------------------------------------------------Nettoyage des données-------------------------------------------------------------
--Purchasing.ProductVendor
SELECT * FROM Purchasing.ProductVendor;
SELECT * FROM Purchasing.ProductVendor WHERE ProductID IS NULL OR BusinessEntityID IS NULL OR AverageLeadTime IS NULL OR StandardPrice IS NULL OR LastReceiptCost IS NULL OR LastReceiptDate IS NULL OR MinOrderQty IS NULL OR MaxOrderQty IS NULL OR OnOrderQty IS NULL OR UnitMeasureCode IS NULL OR ModifiedDate IS NULL  ; 
UPDATE Purchasing.ProductVendor 
SET OnOrderQty=(
    SELECT TOP 1 OnOrderQty
	FROM Purchasing.ProductVendor
	WHERE OnOrderQty IS NOT NULL
	GROUP BY OnOrderQty
	ORDER BY COUNT(*) DESC
	)
WHERE OnOrderQty IS NULL

SELECT * FROM Purchasing.ProductVendor 
GROUP BY ProductID , BusinessEntityID , AverageLeadTime , StandardPrice , LastReceiptCost , LastReceiptDate , MinOrderQty , MaxOrderQty , OnOrderQty , UnitMeasureCode , ModifiedDate
HAVING COUNT (*) > 1;

SELECT * FROM Purchasing.ProductVendor
WHERE AverageLeadTime < 0
   OR StandardPrice < 0
   OR LastReceiptCost < 0
   OR MinOrderQty < 0
   OR MaxOrderQty < 0
   OR OnOrderQty < 0;
SELECT * FROM Purchasing.ProductVendor
WHERE LastReceiptDate > GETDATE()
   OR ModifiedDate > GETDATE();

--Purchasing.PurchaseOrderDetail
SELECT * FROM Purchasing.PurchaseOrderDetail;
SELECT * FROM Purchasing.PurchaseOrderDetail WHERE PurchaseOrderID IS NULL OR PurchaseOrderDetailID IS NULL OR DueDate IS NULL OR OrderQty IS NULL OR ProductID IS NULL OR UnitPrice IS NULL OR LineTotal IS NULL OR ReceivedQty IS NULL OR RejectedQty IS NULL OR StockedQty IS NULL OR ModifiedDate IS NULL ;

SELECT * FROM Purchasing.PurchaseOrderDetail
GROUP BY PurchaseOrderID , PurchaseOrderDetailID , DueDate , OrderQty , ProductID , UnitPrice , LineTotal , ReceivedQty , RejectedQty , StockedQty , ModifiedDate
HAVING COUNT (*) > 1;  

SELECT * FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty < 0
   OR PurchaseOrderID < 0
   OR PurchaseOrderDetailID < 0
   OR ProductID < 0
   OR UnitPrice < 0
   OR LineTotal < 0
   OR ReceivedQty < 0
   OR RejectedQty < 0
   OR StockedQty < 0;
SELECT * FROM Purchasing.PurchaseOrderDetail
WHERE DueDate > GETDATE()
   OR ModifiedDate > GETDATE();

  --Purchasing.PurchaseOrderHeader
SELECT * FROM Purchasing.PurchaseOrderHeader
SELECT * FROM Purchasing.PurchaseOrderHeader WHERE PurchaseOrderID IS NULL OR RevisionNumber IS NULL OR Status IS NULL OR EmployeeID IS NULL OR VendorID IS NULL OR ShipMethodID IS NULL OR  OrderDate IS NULL OR ShipDate IS NULL OR SubTotal IS NULL OR TaxAmt IS NULL OR Freight IS NULL OR TotalDue IS NULL OR ModifiedDate IS NULL ;

SELECT * FROM Purchasing.PurchaseOrderHeader
GROUP BY PurchaseOrderID , RevisionNumber , Status , EmployeeID , VendorID , ShipMethodID ,  OrderDate , ShipDate , SubTotal , TaxAmt , Freight , TotalDue , ModifiedDate
HAVING COUNT (*) > 1;   

SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID < 0
   OR RevisionNumber < 0
   OR SubTotal < 0
   OR TaxAmt < 0
   OR Freight < 0
   OR TotalDue < 0
   OR TotalDue != SubTotal + TaxAmt + Freight
   OR Status NOT IN (1, 2, 3, 4);
SELECT * FROM Purchasing.PurchaseOrderHeader
WHERE OrderDate > GETDATE()
   OR ShipDate > GETDATE()
   OR ShipDate < OrderDate
   OR ModifiedDate > GETDATE();

--Purchasing.ShipMethod
SELECT * FROM Purchasing.ShipMethod
SELECT * FROM Purchasing.ShipMethod WHERE ShipMethodID IS NULL OR Name IS NULL OR ShipBase IS NULL OR ShipRate IS NULL OR rowguid IS NULL OR ModifiedDate IS NULL ; 

SELECT * FROM Purchasing.ShipMethod
GROUP BY ShipMethodID , Name , ShipBase , ShipRate , rowguid , ModifiedDate
HAVING COUNT (*) > 1;  

SELECT * FROM Purchasing.ShipMethod
WHERE ShipMethodID < 0
   OR ShipBase < 0
   OR ShipRate < 0;
SELECT * FROM Purchasing.ShipMethod
WHERE ModifiedDate > GETDATE();

--Purchasing.Vendor
SELECT * FROM Purchasing.Vendor
SELECT * FROM Purchasing.Vendor WHERE BusinessEntityID IS NULL OR AccountNumber IS NULL OR Name IS NULL OR CreditRating IS NULL OR PreferredVendorStatus IS NULL OR ActiveFlag IS NULL OR PurchasingWebServiceURL IS NULL OR ModifiedDate IS NULL ;

UPDATE Purchasing.Vendor
SET PurchasingWebServiceURL = 'Not available'
WHERE PurchasingWebServiceURL IS NULL ;
SELECT * FROM Purchasing.Vendor

SELECT * FROM Purchasing.Vendor
GROUP BY BusinessEntityID , AccountNumber , Name , CreditRating , PreferredVendorStatus , ActiveFlag , PurchasingWebServiceURL , ModifiedDate
HAVING COUNT (*) > 1; 

SELECT * FROM Purchasing.Vendor
WHERE BusinessEntityID < 0
   OR CreditRating < 0
   OR CreditRating NOT BETWEEN 1 AND 5
   OR PreferredVendorStatus NOT IN (0 , 1) 
   OR ActiveFlag NOT IN (0, 1);
SELECT * FROM Purchasing.Vendor
WHERE ModifiedDate > GETDATE();
