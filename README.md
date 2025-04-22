
📦 E-Commerce Database Design

*An Entity-Relationship Diagram (ERD) and SQL implementation for an online store.*

📌 Project Overview

This project designs a relational database for an e-commerce platform, including:

✔ Product management (categories, brands, variations)

✔ Inventory tracking (SKUs, stock levels)

✔ Attribute system (sizes, colors, custom features)

🛠️ Tech Stack

Database: MySQL (or PostgreSQL)

Design Tools:

ERD: draw.io / Lucidchart

💡 Key Design Decisions

Normalization:

Split product and product_item to handle variations (e.g., size/color).

Flexible Attributes:

Used attribute_type (text/number/boolean) for extensibility.

Performance:

Added indexes on frequently queried columns (product_id, sku).

SQL Scripting: MySQL Workbench / VSCode + SQL Extension

