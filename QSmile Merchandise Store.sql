CREATE DATABASE QSmileMerchandiseStoreSQL
USE QSmileMerchandiseStoreSQL

-- CREATE MEMBER TABLE
CREATE TABLE Member
(
	MemberID VARCHAR(6)
		CONSTRAINT chkMemberID CHECK (MemberID LIKE 'NRT[0-9][0-9][0-9]') NOT NULL,
	MemberName VARCHAR(100) NOT NULL,
	MemberAddress TEXT,
	PRIMARY KEY (MemberID) -- INI TERMASUK CONSTRAINT BUKAN?
)
SELECT * FROM Member

-- PROCEDURE ADD MEMBER
GO
CREATE PROCEDURE prcAddMember
	@name VARCHAR (100),
	@address TEXT
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (6)
	SET @nextid = (SELECT TOP 1 RIGHT (MemberID, 3)+1 FROM Member ORDER BY MemberID DESC)
		IF (@nextid IS NULL)
		BEGIN
			INSERT Member VALUES ('NRT001', @name, @address)
		END
		ELSE
		BEGIN
			IF (@nextid < 10)
			BEGIN
				SET @newid = 'NRT00' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				IF (@nextid < 100)
				BEGIN
					SET @newid = 'NRT0' + CAST (@nextid AS VARCHAR)
				END
				ELSE
				BEGIN
					SET @nextid = 'NRT' + CAST (@nextid AS VARCHAR)
				END
			END
		INSERT Member VALUES (@newid, @name, @address)
		END	
END
SELECT * FROM Member



-- CREATE SHIPPING TABLE
CREATE TABLE Shipping
(
	ShippingID VARCHAR(7)
		CONSTRAINT chkShippingID CHECK (ShippingID LIKE 'SHIP[0-9][0-9][0-9]') NOT NULL,
	MemberID VARCHAR(6) NOT NULL,
	ShippingAddress TEXT,
	PRIMARY KEY (ShippingID),
	FOREIGN KEY (MemberID) REFERENCES Member
)
SELECT * FROM Shipping

-- PROCEDURE ADD SHIPPING ADDRESS
GO
CREATE PROCEDURE prcAddShipping
	@memberid VARCHAR (6),
	@shippingaddress TEXT
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (7)
	SET @nextid = (SELECT TOP 1 RIGHT (ShippingID, 3)+1 FROM Shipping ORDER BY ShippingID DESC)
	IF (@nextid is null)
	BEGIN
		INSERT Shipping VALUES ('SHIP001', @memberid, @shippingaddress)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'SHIP00' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			IF (@nextid < 100)
			BEGIN
				SET @newid = 'SHIP0' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				SET @newid = 'SHIP' + CAST (@nextid AS VARCHAR)
			END
		END
	INSERT Shipping VALUES (@newid, @memberid, @shippingaddress)
	END
END
SELECT * FROM Shipping


-- CREATE ITEM TYPE TABLE
CREATE TABLE ItemType
(
	ItemTypeID VARCHAR(4)
		CONSTRAINT chkItemTypeID CHECK (ItemTypeID LIKE 'J[0-9][0-9][0-9]') NOT NULL,
	ItemTypeName VARCHAR(10) NOT NULL,
	ItemTypeInformation TEXT,
	PRIMARY KEY (ItemTypeID)
)
SELECT * FROM ItemType

-- PROCEDURE ADD ITEM TYPE
GO
CREATE PROCEDURE prcAddItemType
	@name VARCHAR (10),
	@information TEXT
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (4)
	SET @nextid = (SELECT TOP 1 RIGHT (ItemTypeID, 3)+1 FROM ItemType ORDER BY ItemTypeID DESC)
	IF (@nextid IS NULL)
	BEGIN
		INSERT ItemType VALUES ('J001', @name, @information)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'J00' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			IF (@nextid < 100)
			BEGIN
				SET @newid = 'J0' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				SET @newid = 'J' + CAST (@nextid AS VARCHAR)
			END
		END
		INSERT ItemType VALUES (@newid, @name, @information)
	END
END
SELECT * FROM ItemType


-- CREATE SUPPLIER TABLE
CREATE TABLE Supplier
(
	SupplierID VARCHAR(4)
		CONSTRAINT chkSupplierID CHECK (SupplierID LIKE 'S[0-9][0-9][0-9]') NOT NULL,
	SupplierName VARCHAR(50) NOT NULL,
	SupplierAddress TEXT,
	PRIMARY KEY (SupplierID)
)
SELECT * FROM Supplier

-- PROCEDURE ADD SUPPLIER
GO
CREATE PROCEDURE prcAddSupplier
	@name VARCHAR (50),
	@address TEXT
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (4)
	SET @nextid = (SELECT TOP 1 RIGHT (SupplierID, 3)+1 FROM Supplier ORDER BY SupplierID DESC)
	IF (@nextid IS NULL)
	BEGIN
		INSERT Supplier VALUES ('S001', @name, @address)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'S00' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			IF (@nextid < 100)
			BEGIN
				SET @newid = 'S0' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				SET @newid = 'S' + CAST (@nextid AS VARCHAR)
			END
		END
	INSERT Supplier VALUES (@newid, @name, @address)
	END
END
SELECT * FROM Supplier


-- CREATE ITEM TABLE
CREATE TABLE Item
(
	ItemID VARCHAR(5)
		CONSTRAINT chkItemID CHECK (ItemID LIKE 'B[0-9][0-9][0-9][0-9]') NOT NULL,
	ItemName VARCHAR(100)
		CONSTRAINT uqItemName UNIQUE, -- PAKE NOT NULL NGGA? 
	StockItem INT NOT NULL,
	ItemPrice BIGINT NOT NULL,
	ItemTypeID VARCHAR(4) NOT NULL,
	SupplierID VARCHAR(4) NOT NULL
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemTypeID) REFERENCES ItemType,
	FOREIGN KEY (SupplierID) REFERENCES Supplier
)
SELECT * FROM Item

--PROCEDURE ADD ITEM
GO
CREATE PROCEDURE prcAddItem
	@name VARCHAR (100),
	@stock INT,
	@price BIGINT,
	@type VARCHAR (4),
	@supplier VARCHAR (4)
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (5)
	SET @nextid = (SELECT TOP 1 RIGHT (ItemID, 4)+1 FROM Item ORDER BY ItemID DESC)
	IF (@nextid is null)
	BEGIN
		INSERT Item VALUES ('B0001', @name, @stock, @price, @type, @supplier)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'B000' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			IF (@nextid < 100)
			BEGIN
				SET @newid = 'B00' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				IF (@nextid < 1000)
				BEGIN
					SET @newid = 'B0' + CAST (@nextid AS VARCHAR)
				END
				ELSE
				BEGIN
					SET @newid = 'B' + CAST (@nextid AS VARCHAR)
				END
			END
		END
		INSERT Item VALUES (@newid, @name, @stock, @price, @type, @supplier)
	END
END

EXEC prcAddItem 'Hoodie Bigbang lastdance series', 10, 150000,'J001', 'S001'
SELECT * FROM Item


-- CREATE EMPLOYEE TABLE
CREATE TABLE Employee
(
	EmployeeID VARCHAR(6)
		CONSTRAINT chkEmployeeID CHECK (EmployeeID LIKE 'PNTR[0-9][0-9]') NOT NULL,
	EmployeeName VARCHAR(100) NOT NULL,
	EmployeeAddress TEXT
	PRIMARY KEY (EmployeeID)
)
SELECT * FROM Employee

--PROCEDURE ADD EMPLOYEE
GO
CREATE PROCEDURE prcAddEmployee
	@name VARCHAR(100),
	@address TEXT
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR (6)
	SET @nextid = (SELECT TOP 1 RIGHT (EmployeeID, 2)+1 FROM Employee ORDER BY EmployeeID DESC)
	IF (@nextid IS NULL)
	BEGIN
		INSERT Employee VALUES ('PNTR01', @name, @address)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'PNTR0' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			SET @newid = 'PNTR' + CAST (@nextid AS VARCHAR)
		END
		INSERT Employee VALUES (@newid, @name, @address)
	END
END
SELECT * FROM Item


-- CREATE TRANSACTION TYPE
CREATE TABLE TransactionType
(
	TransactionTypeID VARCHAR(5)
		CONSTRAINT chkTransactionTypeID CHECK (TransactiontypeID LIKE 'TRS[0-9][0-9]') NOT NULL,
	TransactionTypeName VARCHAR(10) NOT NULL
	PRIMARY KEY (TransactionTypeID)
)

INSERT TransactionType VALUES
('TRS01', 'Offline'),
('TRS02', 'Online')
SELECT * FROM TransactionType


-- CREATE TRANSACTION TABLE
CREATE TABLE Transactions
( 
	TransactionsID VARCHAR(4)
		CONSTRAINT chkTransactionID CHECK (TransactionsID LIKE 'T[0-9][0-9][0-9]') NOT NULL,
	TransactionTypeID VARCHAR(5) NOT NULL,
	EmployeeID VARCHAR(6) NOT NULL,
	ShippingID VARCHAR (7)
		CONSTRAINT DefOfflineTrans DEFAULT ('Offline Transaction'),
	TransactionDate DATETIME,
	TotalPayment INT -- BUKANNYA BIGINT?
		CONSTRAINT DefTotalPayment DEFAULT (0),
	NominalDiscount BIGINT
		CONSTRAINT defNominalDisc DEFAULT (0),
	FinalPayment BIGINT
	PRIMARY KEY (TransactionsID),
	FOREIGN KEY (EmployeeID) REFERENCES Employee,
	FOREIGN KEY (ShippingID) REFERENCES Shipping,
	FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType
)
SELECT * FROM Transactions

-- DATE TRIGGER ON TRANSACTIONS
GO
CREATE TRIGGER trgTransactionDate ON Transactions
FOR INSERT
AS
BEGIN
	DECLARE @idtrans VARCHAR (4)
	SET @idtrans = (SELECT TransactionsID FROM inserted)
	UPDATE Transactions SET TransactionDate = GETDATE() WHERE TransactionsID = @idtrans
END

-- PROCEDURE TRANSACTIONS (NEW TRANSACTION)
GO
CREATE PROCEDURE prcNewTransaction
	@type VARCHAR (5),
	@employee VARCHAR(6) NULL,
	@shipping VARCHAR (7) NULL
AS
BEGIN
	DECLARE @nextid INT
	DECLARE @newid VARCHAR(4)
	SET @nextid = (SELECT TOP 1 RIGHT (TransactionsID, 3)+1 FROM Transactions ORDER BY TransactionsID DESC)
	IF (@nextid IS NULL)
	BEGIN
		INSERT Transactions (TransactionsID, EmployeeID, ShippingID, TransactionTypeID) VALUES ('T001', @employee, @shipping, @type)
	END
	ELSE
	BEGIN
		IF (@nextid < 10)
		BEGIN
			SET @newid = 'T00' + CAST (@nextid AS VARCHAR)
		END
		ELSE
		BEGIN
			IF (@nextid < 100)
			BEGIN
				SET @newid = 'T0' + CAST (@nextid AS VARCHAR)
			END
			ELSE
			BEGIN
				SET @newid = 'T' + CAST (@nextid AS VARCHAR)
			END
		END
	INSERT Transactions (TransactionsID, EmployeeID, ShippingID, TransactionTypeID) values (@newid, @employee, @shipping, @type)
	END
END
SELECT * FROM Transactions


-- CREATE TRANSACTION DETAIL TABLE
Create TABLE TransactionDetail
(
	IDDetail INT IDENTITY (1,1),
	TransactionsID VARCHAR(4) NOT NULL,
	ItemID VARCHAR(5) NOT NULL,
	ItemQuantity INT,
	TotalPrice BIGINT,
	PRIMARY KEY (IDDetail),
	FOREIGN KEY (TransactionsID) REFERENCES Transactions,
	FOREIGN KEY (ItemID) REFERENCES Item
)
SELECT * FROM TransactionDetail
SELECT * FROM Transactions

-- TRIGGER ON TRANSACTION DETAIL
GO
CREATE TRIGGER trgDetailTrans ON TransactionDetail
FOR INSERT
AS
BEGIN
-- CALCULATE TOTAL PAYMENT
	DECLARE @itemID VARCHAR(5)
	DECLARE @itemPrice BIGINT
	DECLARE @ItemQuantity INT
	DECLARE @totalprice BIGINT
	DECLARE @totalpayment BIGINT 
	DECLARE @iddetail INT
	DECLARE @discount BIGINT
	SET @itemID = (SELECT ItemID FROM inserted)
	SET @itemPrice = (SELECT ItemPrice FROM Item WHERE ItemID = @itemID)
	SET @ItemQuantity = (SELECT ItemQuantity FROM inserted)
	SET @totalprice = @itemPrice * @ItemQuantity
	SET @iddetail = (SELECT IDDetail FROM Inserted)
	UPDATE TransactionDetail SET TotalPrice = @totalPrice WHERE IDDetail = @iddetail
-- CALCULATE TOTAL PAYMENT BEFORE DISCOUNT
	DECLARE @TransID VARCHAR (4)
	SET @TransID = (SELECT TransactionsID FROM inserted)
	SET @totalpayment = (SELECT SUM(TotalPrice) FROM TransactionDetail WHERE TransactionsID = @TransID)
	UPDATE Transactions SET TotalPayment = @totalpayment WHERE TransactionsID = @TransID
-- CALCULATE DISCOUNT PAYMENT
	DECLARE @finalpayment BIGINT
	DECLARE @shipping VARCHAR(7)
	DECLARE @member VARCHAR(6)
	SET @shipping = (SELECT ShippingID FROM Transactions WHERE TransactionsID = @TransID)
	SET @member = (SELECT MemberID FROM Shipping WHERE ShippingID = @shipping)
	IF @shipping = 'SHIP006' AND @member = 'NRT008'
	BEGIN
		UPDATE Transactions SET FinalPayment = @totalpayment WHERE TransactionsID = @TransID
	END
	ELSE
	BEGIN
		IF @totalpayment >= 100000
		BEGIN
			UPDATE Transactions SET NominalDiscount = (SELECT TotalPayment*10/100 FROM Transactions WHERE TransactionsID = @TransID) WHERE TransactionsID = @TransID
			SET @finalpayment = @totalpayment - (SELECT TotalPayment*10/100 FROM Transactions WHERE TransactionsID = @TransID)
			UPDATE Transactions SET FinalPayment = @finalpayment WHERE TransactionsID = @TransID
		END
		ELSE 
		BEGIN
			IF @totalpayment >= 300000
			BEGIN
				UPDATE Transactions SET NominalDiscount = (SELECT TotalPayment * 20/100 FROM Transactions WHERE TransactionsID = @TransID) WHERE TransactionsID = @TransID
				SET @finalpayment = @totalpayment - (SELECT TotalPayment * 20/100 FROM Transactions WHERE TransactionsID = @TransID)
				UPDATE Transactions SET FinalPayment = @finalpayment WHERE TransactionsID = @TransID
			END
			ELSE
			BEGIN
				IF @totalpayment >= 600000
				BEGIN
					UPDATE Transactions SET NominalDiscount = (SELECT TotalPayment*30/100 FROM Transactions WHERE TransactionsID = @TransID) WHERE TransactionsID = @TransID
					SET @finalpayment = @totalpayment - (SELECT TotalPayment*30/100 FROM Transactions WHERE TransactionsID = @TransID)
				UPDATE Transactions SET FinalPayment = @finalpayment WHERE TransactionsID = @TransID
				END
				ELSE
				BEGIN
					IF @totalpayment >= 900000
					BEGIN
						UPDATE Transactions SET NominalDiscount = (SELECT TotalPayment*40/100 FROM Transactions WHERE TransactionsID = @TransID) WHERE TransactionsID = @TransID
						SET @finalpayment = @totalpayment - (SELECT TotalPayment*40/100 FROM Transactions WHERE TransactionsID = @TransID)
						UPDATE Transactions SET FinalPayment = @finalpayment WHERE TransactionsID = @TransID
					END
					ELSE
					BEGIN
						UPDATE Transactions SET FinalPayment = @totalpayment WHERE TransactionsID = @TransID
					END
				END
			END
		END
	END
-- REDUCE STOCK ITEM
	DECLARE @oldstock INT
	DECLARE @newstock INT
	SET @oldstock = (SELECT StockItem FROM Item WHERE ItemID = @itemID)
	SET @newstock = @oldstock - @ItemQuantity
	UPDATE Item SET StockItem = @newstock WHERE ItemID = @itemID
END
SELECT * FROM TransactionDetail
SELECT * FROM Transactions


-- INSERTING DATA
select * from Member
exec prcAddMember 'Non-Member', 'Transaction was done at Store' -- Non-Member
exec prcAddMember 'Lisa', 'Jalanin Dulu aja, Depok'
exec prcAddMember 'Atlas', 'Jalan Rightway, Bekasi'
exec prcAddMember 'Benad', 'Jalan damai aja, jakarta'
exec prcAddMember 'Nio', 'Northhampstone UK'
exec prcAddMember 'Narto', 'Konoha, Brebes'
exec prcAddMember 'Kiara P', 'Jalan itu pokoknya'
exec prcAddMember 'Gaby', 'Jalan Candy, Cibinong'

Update Member
Set MemberAddress = 'Konohagakure, Banyumas'
where MemberID = 'NRT009'

select * from shipping
exec prcAddShipping 'NRT001', 'Transaction was done at Store' -- Offline Transactions
exec prcAddShipping 'NRT002', 'Jalanin Dulu aja, Depok'
exec prcAddShipping 'NRT003', 'Jalan Rightway, Bekasi'
exec prcAddShipping 'NRT004', 'Jalan damai aja, jakarta'
exec prcAddShipping 'NRT005', 'Northhampstone UK'
exec prcAddShipping 'NRT006', 'Konoha, Brebes'
exec prcAddShipping 'NRT007', 'Jalan itu pokoknya'
exec prcAddShipping 'NRT008', 'Jalan Candy, Cibinong'
exec prcAddShipping 'NRT009', 'Konohagakure, Banyumas'

select * from supplier
exec prcAddSupplier 'PT.Saranghae'. 'Hongdae'
exec prcAddSupplier 'PT. Sayang Indonesia', 'Cirebon'
exec prcAddSupplier 'PT. Kocoi Indonesia', 'Rangkas Bitung'
exec prcAddSupplier 'PT. GoodMicin', 'Cibaduyut'
exec prcAddSupplier 'PT. BandaiEntertainment', 'Depok'
exec prcAddSupplier 'PT. EroMangaKomik', 'Jakarta'
exec prcAddSupplier 'PT. Mangkulangit', 'Bekasi'
exec prcAddSupplier 'PT. GendongBumi', 'Bekasi'

select * from ItemType
exec prcAddItemType 'BG', 'Bag'
exec prcAddItemType 'CH', 'Clothes'
exec prcAddItemType 'ACCRS', 'Accessories'
exec prcAddItemType 'CB', 'Comic Book'
exec prcAddItemType 'WB', 'Water Bottle'

select * from Item
exec prcAddItem 'kaos official limited JKT48', 30, 80000, 'J002', 'S004'
exec prcAddItem 'Totebag new series Blackpink',	10,	50000,	'J001',	'S001'
exec prcAddItem 'Hoodie Bigbang lastdance series', 10, 150000, 'J002', 'S002'
exec prcAddItem 'Cap GD reddragon', 5, 50000, 'J003', 'S002'
exec prcAddItem 'Parkboom Necklace', 20, 75000,	'J003', 'S002'
exec prcAddItem 'Backpack wali Band grey', 50, 95000, 'J001', 'S003'
exec prcAddItem 'Buku komik Naruto', 20, 30000,	'J004',	'S005'
exec prcAddItem 'Totebag JKT48', 10, 50000,	'J001',	'S004'
exec prcAddItem 'Keychain JKT48 Tim J',	10, 30000, 'J003', 'S004'
exec prcAddItem 'Tumblr viavallen', 10, 35000, 'J005', 'S006'
exec prcAddItem 'Buku komik Doraemon pakage vol 50-55',	7, 120000, 'J004', 'S005'
exec prcAddItem 'Kaos official Viavallen', 5, 80000, 'J002', 'S006'
exec prcAddItem 'Backpack Blackpink', 5, 95000,	'J001',	'S001'

select * from Employee
exec prcAddEmployee 'Gibson', 'Jalan Nenek moyang, bogor'
exec prcAddEmployee 'Viatqua', 'Jalan air lancar, depok'
exec prcAddEmployee 'agatha', 'Jalan sendiri, bojong'
exec prcAddEmployee 'shinpo', 'jalan swadaya'
exec prcAddEmployee 'asus', 'jalan jalan yuk' --DELETE PNTR07

-- INSERTING TRANSACTION
exec prcNewTransaction 'TRS02', 'PNTR02', 'SHIP002'
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T001','B0009', 1)
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T001','B0009', 1)
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T001','B0009', 1)
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T001','B0009', 1)
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T001','B0009', 1)

select * from Transactions
select * from TransactionDetail
select * from Item
select * from Employee
select * from TransactionType
select * from Shipping
select * from Member

-- INSERTING TRANSACTION DETAIL
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T011','B0013', 1)
insert TransactionDetail (TransactionsID, ItemID, ItemQuantity) values ('T002','B0003', 2)

select * from Transactions

select ShippingID from Transactions order by ShippingID desc

select * from Member
select * from Shipping

exec prcNewTransaction 'TRS01', 'PNTR04', 'SHIP007'

-- CREATE VIEW 
CREATE VIEW vwSuppliesItemType AS
SELECT ItemName, StockItem, ItemPrice, ItemTypeInformation, SupplierName
FROM Item a
JOIN ItemType b ON a.ItemTypeID = b.ItemTypeID
JOIN Supplier c ON a.SupplierID = c.supplierID

CREATE VIEW vwTransactionView AS
SELECT b.TransactionsID, EmployeeName, TransactionTypeName, ShippingAddress, MemberName, TransactionDate, ItemName, ItemQuantity, TotalPayment, NominalDiscount, FinalPayment 
FROM Shipping a
JOIN Transactions b ON a.ShippingID = b.ShippingID
JOIN Employee c ON c.EmployeeID = b.EmployeeID
JOIN TransactionDetail e ON e.TransactionsID = b.TransactionsID
JOIN Item d ON d.ItemID = e.ItemID
JOIN Member f ON f.MemberID = a.MemberID
JOIN TransactionType g ON g.TransactionTypeID = b.TransactionTypeID

CREATE VIEW vwShipperAddress AS
SELECT b.ShippingID, MemberName, MemberAddress, ShippingAddress
FROM Member a
JOIN Shipping b ON a.MemberID = b.MemberID

SELECT * FROM vwTransactionView
SELECT * FROM vwSuppliesItemType
SELECT * FROM vwShipperAddress







--AKHIRNYA SELESAI JUGA
	'PENTING'
-- EXECUTE ULANG TRIGGER DETAILTRANSAKSI 
-- EXECUTE ULANG PROCEDURE TRANSAKSI
-- UPDATE TABLE MEMBER DAN SHIPPING DENGAN DATA MEMBER YANG TRANSAKSI OFFLINE

	'PETUNJUK'
-- MEMBER YANG TRANSAKSINYA OFFLINE DI PISAHIN SUPAYA DIA JUGA DAPET DISKON, KASIAN KALO GA DAPET
-- JADI SETIAP MEMBER YANG TRANSAKSINYA OFFLINE PAKE SHIPPING ID 'SHIP007', SUPAYA DIA BISA DAPET DISKON
-- KALO NON MEMBER PAKENYA 'SHIP006'
-- SIP
-- BYE BITCHES HAPPY HOLIDAY KECUALI BUAT YANG BIKIN LAPORAN HAHAHAHAHA (KETAWA JAHAT)
--	(bercanda, nio.)

-------- KASUS --------
-- SETIAP MEMBER YANG MEMILIKI NAMA YANG SAMA DAN ALAMAT YANG SAMA AKAN TERUS BERTAMBAH DENGAN MEMBER ID YANG BERBEDA