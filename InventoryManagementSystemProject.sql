use InventoryManagementSystem_030_037_035



create table Vendor( --1
VendorID varchar(50) not null,
VendorName varchar(50) not null,
--Balance int,
--Credit varchar(50),
VendorPhone_no varchar(50),
VendorEmail varchar(50),
VendorWebsite varchar(50),
--Currency varchar(50),
Primary key (VendorID)
)

create table Product( -- 2
ProductID varchar(50) not null,
ProductName varchar(50),
Category varchar(50),
Cost int,
SalePrice int,
Quantity int,
Weights int,
Lengths int,
Width int,
Height int,
Primary Key (ProductID)
)

create table Ret_Order( --3
RetOrderID varchar(50) not null,
Subtotal int,
OrderStatus varchar(50),
RetOrderPlacedDate varchar(50),
Description varchar(50),
Primary key (RetOrderId)
)

create table godown(-- 19
GodownID varchar(50) not null ,
CapacityVol int,
status varchar(50) --status means is it on rent or owned
primary key(GodownID)
)

create table Taxing( -- 22
TaxingID varchar(50) not null,
TaxingDate datetime,
TaxingPercent int,
primary key(TaxingID)
)

create table VenProdRet_OrdTaxBridge( --4
VendorID varchar(50) not null,
RetOrderID varchar(50) unique not null,
ProductID varchar(50) not null,
TaxingID varchar(50) not null,
UnitPrice int,
Discount int,
Quantity int,
PaymentTerms varchar(50),
Remarks varchar(50),
subtotal int
constraint fk_vendorID foreign key(VendorID) references Vendor(VendorID),
constraint fk_RetOrderID foreign key(RetOrderID) references Ret_Order(RetOrderID),
constraint fk_ProductID foreign key(ProductID) references Product(ProductID),
constraint fk_TaxingID foreign key(TaxingID) references Taxing(TaxingID)
);


create table Retailer ( -- 5
RetailerID varchar(50) not null,
RetailerName varchar(50) not null,
RetailerPhone_No varchar(50) not null,
RetailerEmail varchar(50),
RetailerWebsite varchar(50),
Primary key (RetailerID),
)

create table RetRet_ordBridge( --6
RetailerID varchar(50) not null,
RetOrderID varchar(50) unique not null,
constraint fk_RetailerID foreign key(RetailerID) references Retailer(RetailerID),
constraint fk_RetOrderID_2 foreign key (RetOrderID) references Ret_Order(RetOrderID)
)


create table CustomerOrder( --7
CustomerOrderID varchar(50),
OrderStatus varchar(50),
CustomerOrderPlaced varchar(50),
Descriptions varchar(50),
Primary key (CustomerOrderID)
)

create table RetProdCust_OrdTaxBridge( --8  ------------------- edit
CustomerOrderID varchar(50) unique not null,
RetailerID varchar(50) not null,
ProductID varchar(50) not null,
TaxingID varchar(50) not null,
UnitPrice int,
remarks varchar(50),
Discount int,
Quantity int,
PaymentTerms varchar(50),
subtotal int
constraint fk_CustomerOrderID foreign key(CustomerOrderID) references CustomerOrder(customerOrderID),
constraint fk_RetailerID_2 foreign key(RetailerID) references Retailer(RetailerID),
constraint fk_ProductID_2 foreign key(ProductID) references Product(ProductID),
constraint fk_TaxingID_2 foreign key(TaxingID) references Taxing(TaxingID)
)

Create table cust( --9
CustomerID varchar(50) not null,
custName varchar(50),
--custBalance varchar(50),
custPhone_No varchar(50),
custEmail varchar(50),
primary key (customerID)
)

Create table Locations( -- 12
PostalCode varchar(50) not null,
country varchar(50),
city varchar(50),
area varchar(50),
street varchar(50),
plot_no varchar(50),
flat_no varchar(50),
Primary key (PostalCode)
)

create table Employee( --13
EmployeeID varchar(50) not null,
Names varchar(50),
EmpAddress varchar(100),
Phone_No varchar(50),
Status varchar(50),
Email varchar(50),
Gender varchar (15),
Designation varchar(50),
EmployeeSalary int,
Primary key (EmployeeID)
);

create table LocCustomer_ordShipBridge(--14 ----------- edited
PostalCode varchar(50) not null,
CustomerOrderID varchar(50) unique not null,
CustAddress varchar(50), 
ReceivedDate datetime,
ShippingCharges int,
constraint fk_PostalCode foreign key(PostalCode)references Locations(PostalCode),
constraint fk_CustomerOrderID_2 foreign key(CustomerOrderID) references CustomerOrder(CustomerOrderID)
)

create table Shipper( --15
ShipperID varchar(50) not null,
ShipperName varchar(50),
ShipperPhone_no varchar(50),
ShipperLoadLimit int,
primary key (shipperID)
);

create table End_product( -- 16
End_ProductID varchar(50) not null,
End_ProductName varchar(50),
Category varchar(50),
cost int,
sale_price int,
Quantity int,
Weights int,
lengths int,
width int,
height int,
Primary Key(End_ProductID)
)

Create table CustCust_OrdBridge ( --10  ------------------------------------------- edited 
CustomerID varchar (50),
CustomerOrderID varchar(50) not null unique,
constraint fk_CustomerID foreign key(CustomerID) references cust(customerID),
constraint fk_CustomerOrderID_3 foreign key(CustomerOrderID) references CustomerOrder(customerOrderID), 
);

Create table LocShipperEmpRet_OrdBridge ( --11 ---------------------------- edited
PostalCode varchar(50) not null,
EmployeeID varchar(50) not null,
RetOrderID varchar(50) unique not null,
ShipperID varchar(50) not null,
ReceivedDate varchar(50),
ShippingCharges int,
--Total int,
constraint fk_PostalCode_3 foreign key(PostalCode) references Locations(PostalCode),
constraint fk_EmployeeID foreign key(EmployeeID) references Employee(EmployeeID),
Constraint fk_RetOrderID_3 foreign key(RetOrderID) references Ret_Order(retOrderID),
constraint fk_ShipperID foreign key(ShipperID) references shipper(shipperID)
)

create table CustomerOrdProdEnd_ProdBridge(-- 17
CustomerOrderID varchar(50) not null,
ProductID varchar(50) not null,
End_ProductID varchar(50) not null,
servicesCharges int,
constraint fk_CustomerOrderID_4 foreign key(CustomerOrderID) references CustomerOrder(CustomerOrderID),
constraint fk_ProductID_3 foreign key(ProductID) references product(ProductID),
constraint fk_End_ProductID foreign key(End_ProductID) references End_product(End_ProductID),
)

create table End_ProdEmployeeGodownBridge(-- 18
EmployeeID varchar(50) not null,
End_ProductID varchar(50) not null,
GodownID varchar(50) not null,
constraint fk_End_ProductID_2 foreign key(End_ProductID) references End_product(End_ProductID),
constraint fk_GodownID_4 foreign key(GodownID)references godown(GodownID),
constraint fk_EmployeeID_2 foreign key(EmployeeID)references Employee(EmployeeID)
)

create table ProductGodownBridge( -- 20
ProductID varchar(50) not null,
GodownID varchar(50) not null,
constraint fk_ProductID_4 foreign key(ProductID) references Product(ProductID),
constraint fk_GodownID foreign key(GodownID)references godown(GodownID)
) 

create table RetailerLocationGodownBridge( -- 21 --------------------------- edit
RetailerID varchar(50) not null,
PostalCode varchar(50) not null,
GoDownID varchar(50) unique not null,
constraint fk_RetailerID_3 foreign key(RetailerID) references Retailer(RetailerID),
constraint fk_PostalCode_2 foreign key(PostalCode)references Locations(PostalCode),
constraint fk_GodownID_2 foreign key(GodownID)references godown(GodownID)
)

create table VendorLocationGodownBridge( -- 23
PostalCode varchar(50) not null,
GoDownID varchar(50) not null,
VendorID varchar(50) not null,
constraint fk_VendorID_2 foreign key(VendorID)references vendor(VendorID),
constraint fk_PostalCode_4 foreign key(PostalCode)references Locations(PostalCode),
constraint fk_GodownID_3 foreign key(GodownID)references godown(GodownID)
)

create table VenRetail_TRANSACTION_Bridge(-- 24
VendorID varchar(50) not null,
RetailerID varchar(50) not null,
RetBalance int ,
RetCredit int,
VenBalance int,
VenCredit int,
constraint fk_VendorID_3 foreign key(VendorID)references vendor(VendorID),
constraint fk_RetailerID_4 foreign key(RetailerID) references Retailer(RetailerID),
)

insert into CustomerOrder(CustomerOrderID,OrderStatus,CustomerOrderPlaced,Descriptions)
values ('custord001', 'delivered', '2021-12-23', 'no alteration needed'),
('custord002','delivered', '2021-11-24', 'no alteration needed'),
('custord003','processing','2022-1-10', 'alteration needed'),
('custord004','shipping','2022-1-9','no alteration needed')
select * from CustomerOrder

insert into cust (CustomerID, custName, custPhone_No ,custEmail)
values ('cust001', 'Ali', 03212438738, 'ali1990@hotmail.com'),
('cust002', 'salman', 03212438738, 'salman323@hotmail.com'),
('cust003', 'Hammad', 03245454646, 'hammad34@hotmail.com'),
('cust004', 'Lester', 03212487483, 'Lester848@hotmail.com')
select * from cust

insert into Locations (PostalCode,country,city,area,street,plot_no,flat_no)
values ('POS001', 'Pakistan', 'karachi', 'FB Area', 'street001','1','A-275'),
('POS002','Pakistan','Lahore','Azizabad','street002','2','C-78'),
('POS003','Pakistan','Karachi','Gulshan e Iqbal','street003','3','i-102'),
('POS004','Pakistan','Islamabad','DHA','street004','4','f-34')
select * from Locations

insert into Employee (EmployeeID, Names, EmpAddress, Phone_No,Status,Email,Gender,Designation,EmployeeSalary)
values ('Emp001', 'Raheem', 'kucthi gali no.1 marriot road karachi','03313434334','part-time','raheem@hotmail.com','Male','Accountant', 800000),
('Emp002','Taimoor', '94 4rd floor aiwan-e-tijarat road', '021357389489','Full-time','taimoor478@gmail.com','Male','Deliveryman',10000),
('Emp003','Hassham', 'house#13,f-16','0216479376378','Full-time','Hassham3536@yahoo.com','male','supervisor',30000),
('Emp004','Maria','6-shahid colony opp wahadat road', '033156382999','part-time', 'maria463@outlook.com','Female','Receptionist',25000)
select * from employee

/*insert into CustomerOrder(CustomerOrderID,OrderStatus,CustomerOrderPlaced,Descriptions)
values ('custord001', 'delivered', '2021-12-23', 'no alteration needed'),
('custord002','delivered', '2021-11-24', 'no alteration needed'),
('custord003','processing','2022-1-10', 'alteration needed'),
('custord004','shipping','2022-1-9','no alteration needed')
select * from CustomerOrder

insert into cust (CustomerID, custName, custPhone_No ,custEmail)
values ('cust001', 'Ali', 03212438738, 'ali1990@hotmail.com'),
('cust002', 'salman', 03212438738, 'salman323@hotmail.com'),
('cust003', 'Hammad', 03245454646, 'hammad34@hotmail.com'),
('cust004', 'Lester', 03212487483, 'Lester848@hotmail.com')
select * from cust


insert into Employee (EmployeeID, Names, EmpAddress, Phone_No,Status,Email,Gender,Designation,EmployeeSalary)
values ('Emp001', 'Raheem', 'kucthi gali no.1 marriot road karachi','03313434334','part-time','raheem@hotmail.com','Male','Accountant', 800000),
('Emp002','Taimoor', '94 4rd floor aiwan-e-tijarat road', '021357389489','Full-time','taimoor478@gmail.com','Male','Deliveryman',10000),
('Emp003','Hassham', 'house#13,f-16','0216479376378','Full-time','Hassham3536@yahoo.com','male','supervisor',30000),
('Emp004','Maria','6-shahid colony opp wahadat road', '033156382999','part-time', 'maria463@outlook.com','Female','Receptionist',25000)
select * from employee*/

insert into godown (GodownID,CapacityVol,status)
values ('god001',544,'on-rent'),
('god002',700,'owned'),
('god003',600,'on-rent'),
('god004',550,'owned')
select * from godown

insert into End_Product (End_ProductID,    End_ProductName,Category,cost,sale_price,Quantity,Weights,lengths,width,height)
values ('EndP001', 'Soap','Toiletries', 130,150,200,20,7,8,4),
('EndP002', 'Cat Food', 'Pet accessories', 180,200,50,54,20,30,40),
('EndP003', 'Shirt', 'Articles', 480, 500, 20,3,20,54,32),
('EndP004', 'Chocolates' , 'confectionaries', 250,300, 50,5,10,5,3)
select * from End_product

insert into Product(ProductID,ProductName,Category,Cost,SalePrice,Quantity,Weights,Lengths,Width,Height)
values ('Prod001','Screw','parts',12,20,100,1,3,2,3),
('Prod002','wire','parts',10,15,201,2,10,1,1),
('Prod003','paddle','parts',100,150,50,3,4,3,2),
('Prod004','Chain','parts',12,20,100,1,3,2,3)
select * from Product

insert into Ret_Order(RetOrderID,OrderStatus,RetOrderPlacedDate,Description)
values ('RetOrd001','processing','2019-11-23','a part'),
('RetOrd002','complete','2022-02-9','a part'),
('RetOrd003','shipping','2012-03-27','a part'),
('RetOrd004','processing','2018-07-21','a part')
select * from Ret_Order

insert into Retailer(RetailerID,RetailerName,RetailerPhone_No,RetailerEmail,RetailerWebsite)
values ('Ret001','jamaima ameen','03182739483','jamAmee@gmail.com','www.jamaima.com'),
('Ret002','sufyan','03129485710','suf.yan123@gmail.com','www.suf.com'),
('Ret003','waqas yunus','03192837463','wa.yun@gmail.com','www.waqas.com'),
('Ret004','madeen talha','03183928473','mad.tal@gmail.com','www.talMadeen.com')
select * from Retailer

Insert into Shipper(ShipperID,ShipperName,ShipperPhone_no,ShipperLoadLimit)
values ('Ship001','Tahir Ali','03817364738',100),
('Ship002','Sama Yousuf','03128847362',250),
('Ship003','Fatima Butt','03128472632',50),
('Ship004','Reem khan','03184756323',300)
select * from Shipper

insert into Taxing(TaxingID,TaxingDate,TaxingPercent)
values ('Tax001','2003-10-22',9),
('Tax002','2122-10-22',11),
('Tax003','2015-12-21',15),
('Tax004','2020-6-2',17)
select * from Taxing

INSERT INTO Vendor(VendorID,VendorName,VendorPhone_no,VendorEmail,VendorWebsite)
VALUES ('Ven001', 'maryam butt','03419283746','marButt@gmail.com','www.marbutt.com'),
('Ven002', 'Ayesha haseeb','03128847362','Aye_haseeb@gmail.com','www.HaseebAyesha.com'),
('Ven003', 'Nawfal Burhan','03827465910','NawBurr@gmail.com','www.NawBurr.com'),
('Ven004', 'Yousuf Imarn','03847261539','Imran.yousuf@gmail.com','www.YouImran.com')
select * from Vendor


--alter table RetProdCust_OrdTaxBridge add Subtotal int not null

--alter table Ret_Order alter column RetOrderPlacedDate datetime--







insert into CustCust_OrdBridge(customerID,CustomerOrderID)-- editt
values ('cust001','custord001'),
('cust001','custord004'),
('cust004','custord003'),
('cust003','custord002')
select * from CustCust_OrdBridge

insert into CustomerOrdProdEnd_ProdBridge(CustomerOrderID, ProductID,End_ProductID,servicesCharges)
values ('custord001','prod004','EndP003', 500),
('custord001','prod003','EndP003', 500),
('custord004','prod003','EndP001', 250),
('custord003','prod001','EndP002', 1500)
select * from CustomerOrdProdEnd_ProdBridge

insert into End_ProdEmployeeGodownBridge(EmployeeID,End_ProductID,GodownID)
values ('Emp002','Endp003','god001'),
('Emp002','Endp001','god001'),
('Emp001','Endp002','god004'),
('Emp003','Endp004','god003')
select * from End_ProdEmployeeGodownBridge

insert into LocCustomer_ordShipBridge(postalCode,CustomerOrderID, custAddress, ReceivedDate,ShippingCharges) ---------- edit
values ('POS003','custord001','Cecilia Chapman Nulla St.Mankato Mississippi','2202-09-27',190 ),
('POS001','custord003','Fusce Rd. Frederick Nebraska','2000-11-12', 200),
('POS001','custord004','Ap #651-8679 Sodales Av.Tamuning','2020-12-01',250 ),
('POS002','custord002','Iaculis St. Woodruff SC','2019-10-30', 100)
select * from LocCustomer_ordShipBridge

insert into LocShipperEmpRet_OrdBridge(PostalCode,EmployeeID,RetOrderID,ShipperID,ReceivedDate,ShippingCharges) -- purpose of total col??
values ('Pos003','Emp001','RetOrd002','Ship004','2012-02-01',2000),
('Pos002','Emp004','RetOrd001','Ship002','2019-12-11',6000),
('Pos003','Emp001','RetOrd004','Ship001','2022-06-19',15000),
('Pos004','Emp002','RetOrd003','Ship004','2014-04-08',12000)
select * from LocShipperEmpRet_OrdBridge

insert into ProductGodownBridge(ProductID,GodownID)
values('Prod003','God002'),
('Prod001','God004'),
('Prod004','God002'),
('Prod002','God003')
select * from ProductGodownBridge

insert into RetailerLocationGodownBridge(RetailerID,PostalCode,GoDownID)
values('Ret003','Pos001','God003'),
('Ret003','Pos003','God004'),
('Ret002','Pos004','God001'),
('Ret001','Pos002','God002')
select * from RetailerLocationGodownBridge

insert into RetProdCust_OrdTaxBridge(CustomerOrderID,RetailerID,ProductID,TaxingID,UnitPrice,remarks,discount,quantity,paymentTerms,Subtotal)
values ('CustOrd002','Ret003','Prod004','Tax001',10,'',0,1,'COD',10.9),
('CustOrd001','Ret002','Prod002','Tax004',20,'',0,1,'COD',23.4),
('CustOrd004','Ret001','Prod004','Tax001',40,'',0,1,'COD',43.6),
('CustOrd003','Ret003','Prod001','Tax003',100,'',0,1,'COD',115)
select * from RetProdCust_OrdTaxBridge

insert into RetRet_ordBridge(RetailerID,RetOrderID)
values ('Ret004','RetOrd002'),
('Ret004','RetOrd001'),
('Ret002','RetOrd003'),
('Ret001','RetOrd004')
select * from RetRet_ordBridge

insert into VendorLocationGodownBridge(PostalCode,GoDownID,VendorID)
values ('Pos003','God001','Ven004'),
('Pos001','God004','Ven004'),
('Pos003','God002','Ven001'),
('Pos004','God002','Ven003')
select * from VendorLocationGodownBridge

insert into VenProdRet_OrdTaxBridge(VendorID,RetOrderID,ProductID,TaxingID,UnitPrice,remarks,discount,quantity,paymentTerms,Subtotal)
values ('Ven002','RetOrd003','Prod004','Tax001',10,'',0,1,'COD',10.9),
('Ven001','RetOrd002','Prod002','Tax004',20,'',0,1,'COD',23.4),
('Ven004','RetOrd001','Prod004','Tax001',40,'',0,1,'COD',43.6),
('Ven003','RetOrd004','Prod001','Tax003',100,'',0,1,'COD',115)
select * from venProdRet_OrdTaxBridge

insert into VenRetail_TRANSACTION_Bridge(VendorID,RetailerID,RetBalance,RetCredit,VenBalance,VenCredit)
values ('ven003','Ret002',5000,0,10000,500),
('ven002','Ret001',5100,1000,20000,1500),
('ven004','Ret002',23000,4000,12000,5500),
('ven003','Ret004',25000,3000,50000,2500)
select * from VenRetail_TRANSACTION_Bridge

select * into NewRep from VenRetail_TRANSACTION_Bridge
select * from NewRep

--declare @RetCredBal int, @VenCMinRetC int, @newRetC int
--declare @count int
--set @count = (select count(*) from VenRetail_TRANSACTION_Bridge)
--print @count


--select VendorID, RetailerID,
--case 
--when VendorID
--from VenRetail_TRANSACTION_Bridge

select ROW_NUMBER() over () as vn from VenRetail_TRANSACTION_Bridge





--view query
create view TotalSC_vw
as select ShipperID, sum(ShippingCharges) as TotalCharges from LocShipperEmpRet_OrdBridge group by ShipperID
select * from TotalSC_vw
select * from LocShipperEmpRet_OrdBridge


--stored procedure query
create procedure proc_CustOrder
as begin
select * from CustomerOrder where OrderStatus = 'delivered'
end 
exec proc_CustOrder
select * from CustomerOrder
 

--inner join query
select ccob.CustomerID, CustName, ccob.CustomerOrderID, OrderStatus, CustomerOrderPlaced, Descriptions from CustCust_OrdBridge as ccob
inner join CustomerOrder as co on co.CustomerOrderID = ccob.CustomerOrderID
inner join Cust as c on c.CustomerID = ccob.CustomerID








select * from CustomerOrder
select * from cust
select * from Locations

select * from employee

select * from godown

select * from End_product

select * from Product

select * from Ret_Order

select * from Retailer

select * from Shipper

select * from Taxing

select * from Vendor

select * from CustCust_OrdBridge

select * from CustomerOrdProdEnd_ProdBridge

select * from End_ProdEmployeeGodownBridge

select * from LocCustomer_ordShipBridge

select * from LocShipperEmpRet_OrdBridge

select * from ProductGodownBridge

select * from RetailerLocationGodownBridge

select * from RetProdCust_OrdTaxBridge

select * from RetRet_ordBridge

select * from VendorLocationGodownBridge

select * from venProdRet_OrdTaxBridge

select * from VenRetail_TRANSACTION_Bridge




delete from End_product where End_ProductID='endp001'


