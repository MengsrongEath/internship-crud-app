# Flutter Frontend

A complete Flutter application for managing products with CRUD operations, built with Provider state management and connected to an Express.js backend with SQL Server.

## Features

- Product List: View all products with search functionality
- Add Product: Create new products with validation
- Edit Product: Update existing product information
- Delete Product: Remove products with confirmation dialog
- Pull-to-refresh: Refresh product list by pulling down
- Search: Filter products by name in real-time
- Loading States: Visual feedback during API operations
- Error Handling: Comprehensive error handling with user-friendly messages

## Technology

- Frontend: Flutter with Provider state management
- Backend: Express.js with SQL Server
- HTTP Client: http package for API communication
- State Management: Provider pattern

## Project Structure

![ui -project_structure](https://github.com/user-attachments/assets/95c25e0e-50d3-4ea0-a692-dfdba5f91263)

## Setup Instructions 

### Prerequisites

### 1. Flutter SDK: Install Flutter from flutter.dev

### 2. Backend: Ensure your Express.js backend is running on `http://localhost:3000`

### Installation

### 1. Clone the repository

``` bash
https://github.com/MengsrongEath/internship-crud-app/tree/main/product-crud-ui
cd product-crud-ui
```

### 2. Install dependencies

``` bash
flutter pub get
```

### 3. Configure API Base URL

- Open `lib/services/api_service.dart`
- Update the `baseUrl` constant if your backend runs on a different port:

``` bash
static const String baseUrl = 'http://localhost:3000'; // Change if needed
```

### 4. Run the app

``` bash
flutter run
```

## Backend Setup

- `GET /products` - Get all products
- `GET /products/:id` - Get product by ID
- `POST /products` - Create new product
- `PUT /products/:id` - Update product
- `DELETE /products/:id` - Delete product

# Usage

## Product List Screen

- View all products in a scrollable list
- Use the search bar to filter products by name
- Pull down to refresh the list
- Tap edit icon to modify a product
- Tap delete icon to remove a product (with confirmation)
- Tap the floating action button to add a new product

![product_list_screen](https://github.com/user-attachments/assets/9474c40e-99b1-4cd0-b44c-cb096b4eb676)

## Add Product Screen

- Fill in product name, price, and stock quantity
- All fields are required with validation
- Price must be a positive number
- Stock must be a non-negative integer
- Tap "Add Product" to save or "Cancel" to go back

![add_product_screen](https://github.com/user-attachments/assets/72f8ca68-499f-4b90-908f-4a944c465a20)

- add success screen

![add_success_product_screen](https://github.com/user-attachments/assets/41cedd3b-4f44-474a-833c-2f5839928d83)

## Edit Product Screen

- Form is pre-filled with existing product data
- Same validation rules as add product
- Tap "Update Product" to save changes or "Cancel" to discard

![edit_product_screen](https://github.com/user-attachments/assets/048dcdf2-66f8-4a1c-8c0e-3b4dce1734f0)

- edit success

![success_upadate_product_screen](https://github.com/user-attachments/assets/1f278490-1993-4387-b0a8-0755a27fe43e)

## Delete

- Tap "Delete" to delete or "Cancel" to go back

![delete_product_screen](https://github.com/user-attachments/assets/a172d01a-9276-4c9f-bbbd-4ed25fcead21)

- Delete success

![delete_success_product_screen](https://github.com/user-attachments/assets/184bad4f-0f75-497b-97cd-da2ac2b4bfc1)


# Validation 

- Product Name: Required, cannot be empty
- Price: Required, must be a positive number
- Stock: Required, must be a non-negative integer

# License

This project is licensed under the `MIT License`.





