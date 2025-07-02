# Backend API

A RESTful API built with Express.js and SQL Server for managing products.

## Features

- Complete CRUD operations for products
- Input validation
- Error handling
- CORS enabled for flutter integration
- Environment-based configuration
- SQL Server integration with connection

## Prerequisites

- Node.js
- SQL Server (Local or Remote)
- npm or yarn

## Installation 

### 1. Clone this repository to your local machine:

``` bash
https://github.com/MengsrongEath/internship-crud-app/tree/main/product-crud-backend
cd product-crud-backend
```

### 2. Install dependencies

``` bash
npm install
```

### 3. Set up environment variables

``` bash
cp .env.example .env
```

### Edit the `.env` file with your database credentials:

```
DB_SERVER=localhost
DB_DATABASE=ProductDB
DB_USER=your_username
DB_PASSWORD=your_password
DB_PORT=1433
PORT=3000
```

### 4. Set up the database

- Create a database named `ProductDB` in your SQL Server

# Running the Application

## Development Mode

``` bash
npm run dev
```

## Production Mode

``` bash
npm start
```

## The API will be available at `http://localhost:3000`

# API Endpoints

![api_endpoints](https://github.com/user-attachments/assets/a6c68e08-6e65-407b-85fc-a2b067b0d9fd)

# API Usage Examples

## Get All Products

![get_all_product](https://github.com/user-attachments/assets/517c38ef-e8f6-49e7-a627-8854d5e7d1ca)

## Get Product by ID

![get_product_by_id](https://github.com/user-attachments/assets/a7a1526f-bfd3-46ad-ab1d-1085ac977e8b)

## Create New Product

![create_new_product](https://github.com/user-attachments/assets/b48641f8-ab35-445d-85bb-74ca394766fb)

## Update Product

![update_product](https://github.com/user-attachments/assets/119801dd-2cad-4cd8-8b52-2b36ddd23446)

## Delete Product

![delete_product](https://github.com/user-attachments/assets/fd0098a1-62a5-4150-8abd-ad92e8476b88)

# Validation

- Product Name: Required, cannot be empty
- Price: Required, must be a positive number
- Stock: Required, must be a non-negative integer

# Error Handling

- 400: Bad Request (validation errors, invalid input)
- 404: Not Found (product doesn't exist)
- 500: Internal Server Error (database connection issues, server errors)

# Database

``` sql
CREATE TABLE PRODUCTS (
    PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
    PRODUCTNAME NVARCHAR(100) NOT NULL,
    PRICE DECIMAL(10, 2) NOT NULL,
    STOCK INT NOT NULL
);
```

# Project Structure

![project_structure](https://github.com/user-attachments/assets/8a0bc1d0-098a-4e85-97a7-684a3c454ef8)





