CREATE DATABASE Retail;

USE Retail;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15),
    City NVARCHAR(100),
    State NVARCHAR(100),
    PostalCode NVARCHAR(20)
);

-- Create Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(15),
    City NVARCHAR(100),
    State NVARCHAR(100),
    PostalCode NVARCHAR(20)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Price DECIMAL(10, 2) CHECK (Price >= 0),
    SupplierID INT,
    StockQuantity INT CHECK (StockQuantity >= 0),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10, 2) CHECK (Price >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Inventory Table
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT UNIQUE,
    StockQuantity INT CHECK (StockQuantity >= 0),
    ReorderLevel INT CHECK (ReorderLevel >= 0),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(15),
    City NVARCHAR(100),
    State NVARCHAR(100),
    PostalCode NVARCHAR(20),
    Position NVARCHAR(50),
    HireDate DATE NOT NULL,
    ManagerID INT NULL,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(10, 2) CHECK (PaymentAmount >= 0),
    PaymentMethod NVARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Shipping Table
CREATE TABLE Shipping (
    ShippingID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT UNIQUE,
    ShippingDate DATE,
    ShippingMethod NVARCHAR(50),
    TrackingNumber NVARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);