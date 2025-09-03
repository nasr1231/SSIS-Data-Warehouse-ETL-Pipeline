USE Gravity_DWH;

CREATE TABLE Dim_Addresses(
	address_id_sk INT IDENTITY PRIMARY KEY ,
	address_id_bk INT , 
	street_no NVARCHAR(10) , 	
	street_name NVARCHAR(200) ,
	city NVARCHAR(100) ,
	country_id_bk INT NOT NULL ,
	country_name NVARCHAR(200) ,
	ssc TINYINT ,
	[start_date] DATE ,
	[end_date] DATE ,
	[is_current] TINYINT ,
	status_id_bk INT,
	[status] NVARCHAR(150)
)

CREATE TABLE Dim_Customers(
	customer_id_sk INT IDENTITY PRIMARY KEY ,
	customer_id_bk INT ,
	fname NVARCHAR(200) ,
	lname NVARCHAR(200) ,
	[email] NVARCHAR(350) 
)

CREATE TABLE address_customer_bridge(
	customer_id_fk INT NOT NULL,
	address_id_fk INT NOT NULL

	-- Creating Composite PK contains of dim_address pk and dim_customers pk
	CONSTRAINT pk_address_customer_bridge PRIMARY KEY(customer_id_fk, address_id_fk)
	
	-- Creating Foreign keys
	CONSTRAINT fk_bridge_customers FOREIGN KEY (customer_id_fk) REFERENCES Dim_Customers(customer_id_sk) ,
	CONSTRAINT fk_bridge_addresses FOREIGN KEY (address_id_fk) REFERENCES Dim_Addresses(address_id_sk)
)

CREATE TABLE Dim_Books(
	book_id_sk INT IDENTITY PRIMARY KEY ,
	bookid_bk INT NOT NULL , 
	[title] NVARCHAR(400) ,
	isbn13 NVARCHAR(13) ,
	language_id_bk INT ,
	language_name NVARCHAR(50) ,
	language_code NVARCHAR(8) ,
	pagesNo INT ,
	publisher_bk INT NOT NULL,
	publisher_name NVARCHAR(1000)
)

CREATE TABLE Dim_Authors(
	author_sk INT IDENTITY PRIMARY KEY ,
	author_bk INT ,
	author_name NVARCHAR(400)
)

CREATE TABLE bridge_book_author(
	author_id_fk INT ,
	book_id_fk INT ,

	-- Creating Composite PK contains of Dim_Books pk and Dim_AuthorSspk
	CONSTRAINT pk_bridge_books_author PRIMARY KEY (author_id_fk, book_id_fk) ,

	-- Creating Foreign keys
	CONSTRAINT fk_bridge_dim_authors FOREIGN KEY (author_id_fk) REFERENCES Dim_Authors(author_sk) ,
	CONSTRAINT fk_bridge_dim_books FOREIGN KEY (book_id_fk) REFERENCES Dim_Books(book_id_sk) 
)

CREATE TABLE Dim_order_history(
	history_id_sk INT IDENTITY PRIMARY KEY ,
	history_id_bk INT ,
	status_id_bk INT ,
	status_value NVARCHAR(20) ,
	status_date DATETIME
)

CREATE TABLE Dim_shipping_methods(
	method_id_sk INT IDENTITY PRIMARY KEY ,
	method_id_bk INT ,
	method_name NVARCHAR(100) ,
	[cost] DECIMAL (5, 2) ,
	[start_date] DATETIME ,
	[end_date] DATETIME ,
	is_current TINYINT
)

CREATE TABLE Fact_sales(
	order_id_sk INT IDENTITY(1,1) PRIMARY KEY ,
	order_id_bk_dd INT NOT NULL , -- degenrated id coming from the OLTP and not generated into DWH
	date_id_fk INT NOT NULL ,
	time_id_fk INT NOT NULL ,
	history_id_fk INT NOT NULL ,
	books_id_fk INT NOT NULL ,
	shipping_method_fk INT NOT NULL ,
	customer_id_fk INT NOT NULL ,
	dest_id_fk INT NOT NULL,
	
	-- Measures
	price DECIMAL(5, 2) ,

	-- Constraints ==> Foreign Keys
	CONSTRAINT fk_fact_sales_date FOREIGN KEY (date_id_fk) REFERENCES Dim_Date(Date_SK) ,
	CONSTRAINT fk_fact_dest_address FOREIGN KEY (dest_id_fk) REFERENCES Dim_Addresses(address_id_sk) ,
	CONSTRAINT fk_fact_sales_time FOREIGN KEY (time_id_fk) REFERENCES Dim_Time(time_SK) ,
	CONSTRAINT fk_fact_sales_history FOREIGN KEY (history_id_fk) REFERENCES Dim_order_history(history_id_sk) ,
	CONSTRAINT fk_fact_sales_book FOREIGN KEY (books_id_fk) REFERENCES Dim_Books(book_id_sk) ,
	CONSTRAINT fk_fact_sales_shipping_method FOREIGN KEY (shipping_method_fk) REFERENCES Dim_shipping_methods(method_id_sk) ,
	CONSTRAINT fk_fact_sales_customers FOREIGN KEY (customer_id_fk) REFERENCES Dim_Customers(customer_id_sk)	
)

drop table Fact_Sales

CREATE TABLE ETL_Execution_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    PackageName NVARCHAR(250),
    TaskName NVARCHAR(250),    
    [Status] NVARCHAR(50),        
    StartTime DATETIME,
    EndTime DATETIME,    
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Indexes for ETL
CREATE NONCLUSTERED INDEX IX_dim_address_BusinessKey
ON Dim_Addresses (street_no, street_name, city, country_name);

CREATE NONCLUSTERED INDEX IX_dim_date_Date
ON Dim_Date ([Date]);

CREATE NONCLUSTERED INDEX IX_dim_time_Time
ON Dim_Time ([Time]);