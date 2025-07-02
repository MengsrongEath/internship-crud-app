import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/api_response.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000'; // Change this to your backend URL

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Get all products
  static Future<ApiResponse<List<Product>>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: headers,
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = jsonResponse['data'];
        final List<Product> products = productsJson
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        return ApiResponse<List<Product>>(
          success: true,
          data: products,
          message: jsonResponse['message'],
        );
      } else {
        return ApiResponse<List<Product>>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch products',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return ApiResponse<List<Product>>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Get product by ID
  static Future<ApiResponse<Product>> getProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
        headers: headers,
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final Product product = Product.fromJson(jsonResponse['data']);
        return ApiResponse<Product>(
          success: true,
          data: product,
          message: jsonResponse['message'],
        );
      } else {
        return ApiResponse<Product>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to fetch product',
        );
      }
    } catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Create new product
  static Future<ApiResponse<Product>> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: headers,
        body: json.encode(product.toJson()),
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final Product createdProduct = Product.fromJson(jsonResponse['data']);
        return ApiResponse<Product>(
          success: true,
          data: createdProduct,
          message: jsonResponse['message'],
        );
      } else {
        return ApiResponse<Product>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to create product',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Update product
  static Future<ApiResponse<Product>> updateProduct(int id, Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/products/$id'),
        headers: headers,
        body: json.encode(product.toJson()),
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final Product updatedProduct = Product.fromJson(jsonResponse['data']);
        return ApiResponse<Product>(
          success: true,
          data: updatedProduct,
          message: jsonResponse['message'],
        );
      } else {
        return ApiResponse<Product>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to update product',
          errors: jsonResponse['errors'] != null
              ? List<String>.from(jsonResponse['errors'])
              : null,
        );
      }
    } catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Delete product
  static Future<ApiResponse<Product>> deleteProduct(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/products/$id'),
        headers: headers,
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final Product deletedProduct = Product.fromJson(jsonResponse['data']);
        return ApiResponse<Product>(
          success: true,
          data: deletedProduct,
          message: jsonResponse['message'],
        );
      } else {
        return ApiResponse<Product>(
          success: false,
          message: jsonResponse['message'] ?? 'Failed to delete product',
        );
      }
    } catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }
}