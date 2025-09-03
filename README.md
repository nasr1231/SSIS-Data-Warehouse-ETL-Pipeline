# SSIS-Data-Warehouse-ETL-Pipeline


## Description
This project showcases an end-to-end ETL pipeline using SQL Server Integration Services (SSIS) that extracts, transforms, and loads data from an OLTP database into a star schema data warehouse.  To efficiently track changes, an incremental load mechanism is built, and business reporting is done using a Power BI dashboard.

## Tech Stack
* **SQL Server** OLTP + DWH system
* **Power BI** for reporting and KPIs
* **SSIS** for ETL pipelines
* **Git & GitHub** for version control

---

## Folder Structure
```
SSIS-Data-Warehouse-ETL-Pipeline/
├── SSIS-Packages/
│   └── Final_ETL_Package.dtsx
├── SQL/
│   ├── DWH_Tables_DDL.sql
│   ├── Dim_Date.sql
│   └── Dim_Time.sql
├── Database/
│   └── gravity_books.sql
│   └── Gravity_DWH.sql
├── Reports/
│   └── PowerBI_Screenshots/
│   └── PowerBI_Screenshots/
└── README.md
```

---

## 🛋️ Project Architecture

1. **Source**: Normalized OLTP (gravity books)  

![OLTP Diagram](https://github.com/user-attachments/assets/77e48902-2f71-44b9-b5a9-16be0687b710)
* `Address` - Stores customer and order shipping addresses
* `Address Status` - Status of a customer’s address (e.g., active, inactive)
* `Author` - Information about book authors
* `Book` - Information about books available in the store
* `Book Author` - Relationship between books and their authors
* `Book Language` - Supported languages for books
* `Country` - List of countries for addresses and customers
* `Customer` - Customers who purchase books
* `Customer Address` - Relationship between customers and their addresses
* `Customer Order` - Orders placed by customers
* `Order History` - Status history of customer orders
* `Order Line` - Line items within each customer order
* `Order Status` - Possible statuses of an order (e.g., pending, shipped)
* `Publisher` - Information about book publishers
* `Shipping Method` - Available shipping methods and their costs

2. **SSIS ETL Process**:

   * Incremental Loads
   * Lookup transformations for foreign keys
   * Slowly changing components for the Address dimension
   * Updated logs for ETL Process start and end for each package
3. **Snowflake Schema Design**:

   * Fact Table: `Fact_Sales`
   * Dimension Tables: `address_customer_bridge`, `bridge_book_author`, `Dim_Authors`, `Dim_Addresses`, `Dim_Books`, `Dim_Customers`, `Dim_order_history`, `Dim_shipping_methods`, `Dim_Date`, `Dim_Time`
     ## OLAP Diagram Overview
     ![OLAP Diagram](https://github.com/user-attachments/assets/544c50a8-3ecc-4701-a50c-43ca0d3df01f)

4. **Power BI Dashboard**:

   

---

## How to Run the Project

1. **Restore Databases**
   - Restore the **OLTP** and **DW** databases from backup files or scripts.

2. **Open ETL Package**
   - Launch **Visual Studio (SQL Server Data Tools)**.
   - Open the file: `gravity.sln`.

3. **Configure Connections**
   - Check and update your **database connection strings**.

4. **Run ETL Tasks**
   - `ETL-Execution-Log` will be overwritten by the new ETL execution date.
   - Run **Fact** and **Address** data flows.
   - Update the `ETL-Execution-Log` table.

5. **Refresh Dashboard**
   - Open the **Power BI dashboard**.
   - Refresh the dataset to view the updated data.
     
## Notes
- Ensure the backup files or scripts are available before starting.
- Verify all connection strings in Visual Studio before execution.
- Power BI refresh might take a few minutes depending on dataset size.

---

## Reporting

### Sales Dashboard Report (2020-2023)
Overview: The Gravity Book Library dashboard summarizes sales performance from 2020 to 2023, with total revenue of $144.47K from 1.7K customers.
  -	Top Markets: China ($28K) and Indonesia ($20K) show strong purchasing power, reflecting high customer purchasing power.  
  -	Demographics: East Asia leads the sales with the largest segment (44%), driving significant sales.
  -	Categories: English Books lead sales, while French books lag, indicating underperformance.
  -	Financial Performance: Total sales reached $154.18K, of which $9.71K (6.3%) were lost due to cancelled or returned orders — a ratio that is within the normal      industry range and generally considered healthy.

For more insights and key findings from the 2020-2023 sales dashboard, please refer to [Sales Report](Reporting-Layer)

### Business Summary Dashboard
![Businesss Summary Dashboard](Reports/Business-Summary.png)

### Books Analysis Dashboard
![Books Dashboard](Reports/Books-Analysis.png)

### Customers Analysis Dashboard
![Customers Dashboard](Reports/Customers-Analysis.png)

### Orders Lifecycle & Sales Analysis Dashboard
![Orders Dashboard](Reports/Orders-Lifecycle.png)

### Shipping Performance Analysis Dashboard
![Shipping Dashboard](Reports/Shipping-Performance-Analysis.png)

If you have any questions or need clarification on anything in the project, feel free to reach out! I'd be more than happy to help and would love to assist you with any queries.
