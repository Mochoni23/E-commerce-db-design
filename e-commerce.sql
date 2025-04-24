CREATE DATABASE EcommerceDB;
USE EcommerceDB;
CREATE TABLE Brand(
BrandId INT PRIMARY KEY AUTO_INCREMENT,
BrandName VARCHAR(255),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
UpdateAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP  ON UPDATE  CURRENT_TIMESTAMP
);
CREATE TABLE ProductCategory(
CategoryId INT PRIMARY KEY AUTO_INCREMENT,
ProductCategoryId INT,
CategoryName VARCHAR(255)
 );
 CREATE TABLE Product(
 ProductId INT PRIMARY KEY AUTO_INCREMENT,
 ProductName VARCHAR(255),
 ProductDescription Text,
 BasePrice DECIMAL(10,2),
 BrandId INT,
 CategoryId INT,
 IsActive BOOLEAN DEFAULT TRUE,
 CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (BrandId) REFERENCES Brand(BrandId),
    FOREIGN KEY (CategoryId) REFERENCES ProductCategory(CategoryId),
    INDEX IdxproductName (ProductName),
    INDEX IdxBrandCategory (BrandId, CategoryId)
 );
 CREATE TABLE ProductImage (
    ImageId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    ImageUrl VARCHAR(255) NOT NULL,
    AltText VARCHAR(100),
    IsPrimary BOOLEAN DEFAULT FALSE,
    DisplayOrder INT DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
    INDEX IdxProductImages (ProductId)
);
CREATE TABLE Color (
    ColorId INT AUTO_INCREMENT PRIMARY KEY,
    ColorName VARCHAR(50) NOT NULL,
    HexCode VARCHAR(7),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE SizeCategory (
    SizeCategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE SizeOption (
    SizeId INT AUTO_INCREMENT PRIMARY KEY,
    SizeName VARCHAR(20) NOT NULL,
    SizeCategoryId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SizeCategoryId) REFERENCES SizeCategory(SizeCategoryId),
    INDEX IdxSizeCategory (SizeCategoryId)
);
CREATE TABLE ProductVariation (
    VariationId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT ,
    ColorId INT,
    SizeId INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
    FOREIGN KEY (ColorId) REFERENCES Color(ColorId),
    FOREIGN KEY (SizeId) REFERENCES SizeOption(SizeId),
    INDEX IdxProductVariations (ProductId)
);
CREATE TABLE ProductItem (
    ItemId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    VariationId INT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    PriceAdjustment DECIMAL(10, 2) DEFAULT 0.00,
    BarCode VARCHAR(100),
    IsActive BOOLEAN DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
    FOREIGN KEY (VariationId) REFERENCES productVariation(VariationId),
    INDEX IdxproductItems (ProductId),
    INDEX IdxSku (sku)
);
CREATE TABLE AttributeType (
    AttributeTypeId INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL,
    DataType ENUM('text', 'number', 'boolean', 'date') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE AttributeCategory (
    AttributeCategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ProductAttribute (
    AttributeId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    AttributeTypeId INT NOT NULL,
    AttributeCategoryId INT NOT NULL,
    AttributeName VARCHAR(100) NOT NULL,
    AttributeValue TEXT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
    FOREIGN KEY (AttributeTypeId) REFERENCES AttributeType(AttributeTypeId),
    FOREIGN KEY (AttributeCategoryId) REFERENCES AttributeCategory(AttributeCategoryId),
    INDEX IdxProductAttributes (ProductId)
);
-- Insert into Brand
INSERT INTO Brand (BrandName) VALUES 
('Nike'),
('Adidas'),
('Apple'),
('Samsung'),
('Levi''s');

-- Insert into ProductCategory (fixing the self-reference first)
INSERT INTO ProductCategory (CategoryName, ProductCategoryId) VALUES 
('Electronics', NULL),
('Clothing', NULL),
('Shoes', NULL),
('Smartphones', 1),
('Laptops', 1),
('Jeans', 2),
('T-Shirts', 2),
('Running Shoes', 3),
('Sneakers', 3);

-- Insert into Product
INSERT INTO Product (ProductName, ProductDescription, BasePrice, BrandId, CategoryId) VALUES 
('iPhone 15', 'Latest Apple smartphone with A16 chip', 999.00, 3, 4),
('MacBook Pro', '13-inch M2 chip laptop', 1299.00, 3, 5),
('Galaxy S23', 'Flagship Android smartphone', 799.00, 4, 4),
('501 Original Fit', 'Classic straight leg jeans', 59.50, 5, 6),
('Air Force 1', 'Iconic white sneakers', 110.00, 1, 8),
('Ultraboost', 'High-performance running shoes', 180.00, 2, 7),
('Classic Tee', '100% cotton crew neck', 19.99, 5, 7);

-- Insert into Color
INSERT INTO Color (ColorName, HexCode) VALUES 
('Black', '#000000'),
('White', '#FFFFFF'),
('Blue', '#0000FF'),
('Red', '#FF0000'),
('Green', '#00FF00'),
('Space Gray', '#657383'),
('Silver', '#C0C0C0');

-- Insert into SizeCategory
INSERT INTO SizeCategory (CategoryName) VALUES 
('Clothing'),
('Shoes'),
('Electronics');

-- Insert into SizeOption
INSERT INTO SizeOption (SizeName, SizeCategoryId) VALUES 
('S', 1), ('M', 1), ('L', 1), ('XL', 1), ('XXL', 1),
('38', 2), ('39', 2), ('40', 2), ('41', 2), ('42', 2), ('43', 2), ('44', 2),
('128GB', 3), ('256GB', 3), ('512GB', 3), ('1TB', 3);

-- Insert into ProductVariation
INSERT INTO ProductVariation (ProductId, ColorId, SizeId) VALUES 
-- iPhone variations (color + storage)
(1, 6, 13), (1, 6, 14), (1, 7, 13), (1, 7, 14),
-- Jeans variations (size only)
(4, NULL, 1), (4, NULL, 2), (4, NULL, 3),
-- Shoes variations (color + size)
(5, 1, 7), (5, 1, 8), (5, 2, 7), (5, 2, 8),
(6, 3, 9), (6, 4, 9), (6, 3, 10), (6, 4, 10);

-- Insert into ProductImage
INSERT INTO ProductImage (ProductId, ImageUrl, AltText, IsPrimary, DisplayOrder) VALUES 
(1, 'https://example.com/iphone15_1.jpg', 'iPhone 15 front view', TRUE, 1),
(1, 'https://example.com/iphone15_2.jpg', 'iPhone 15 back view', FALSE, 2),
(5, 'https://example.com/airforce1_1.jpg', 'Air Force 1 side view', TRUE, 1),
(5, 'https://example.com/airforce1_2.jpg', 'Air Force 1 top view', FALSE, 2),
(4, 'https://example.com/levis501_1.jpg', 'Levi''s 501 front view', TRUE, 1);

-- Insert into ProductItem
INSERT INTO ProductItem (ProductId, VariationId, sku, StockQuantity, PriceAdjustment, BarCode) VALUES 
-- iPhone items
(1, 1, 'IP15-SG-128', 50, 0, '123456789012'),
(1, 2, 'IP15-SG-256', 30, 100.00, '123456789013'),
(1, 3, 'IP15-SL-128', 45, 0, '123456789014'),
-- Jeans items
(4, 5, 'LEVI-501-S', 100, 0, '223456789012'),
(4, 6, 'LEVI-501-M', 150, 0, '223456789013'),
-- Shoes items
(5, 9, 'NIKE-AF1-WH-39', 25, 0, '323456789012'),
(5, 10, 'NIKE-AF1-WH-40', 20, 0, '323456789013'),
(6, 13, 'ADID-UB-RD-42', 15, 0, '423456789012');

-- Insert into AttributeType
INSERT INTO AttributeType (TypeName, DataType) VALUES 
('Text', 'text'),
('Number', 'number'),
('Boolean', 'boolean'),
('Date', 'date');

-- Insert into AttributeCategory
INSERT INTO AttributeCategory (CategoryName) VALUES 
('Technical Specifications'),
('Fabric/Material'),
('Dimensions'),
('Care Instructions');

-- Insert into ProductAttribute
INSERT INTO ProductAttribute (ProductId, AttributeTypeId, AttributeCategoryId, AttributeName, AttributeValue) VALUES 
-- iPhone attributes
(1, 1, 1, 'Processor', 'A16 Bionic'),
(1, 2, 1, 'RAM (GB)', '6'),
(1, 2, 3, 'Screen Size (inches)', '6.1'),
-- Jeans attributes
(4, 1, 2, 'Material', '100% Cotton'),
(4, 1, 4, 'Washing Instructions', 'Machine wash cold'),
-- Shoes attributes
(5, 1, 2, 'Upper Material', 'Leather'),
(5, 1, 3, 'Sole Material', 'Rubber'),
(6, 2, 3, 'Weight (oz)', '10.5');
