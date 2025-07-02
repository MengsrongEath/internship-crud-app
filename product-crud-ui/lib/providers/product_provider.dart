import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/api_response.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Fetch all products
  Future<void> fetchProducts() async {
    _setLoading(true);
    _setError(null);

    try {
      final ApiResponse<List<Product>> response = await ApiService.getAllProducts();

      if (response.success && response.data != null) {
        _products = response.data!;
        _setError(null);
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError('Failed to fetch products: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Add new product
  Future<bool> addProduct(Product product) async {
    _setLoading(true);
    _setError(null);

    try {
      final ApiResponse<Product> response = await ApiService.createProduct(product);

      if (response.success && response.data != null) {
        _products.insert(0, response.data!); // Add to beginning of list
        _setError(null);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        if (response.errors != null && response.errors!.isNotEmpty) {
          _setError('${response.message}\n${response.errors!.join('\n')}');
        }
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Failed to add product: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Update product
  Future<bool> updateProduct(int id, Product product) async {
    _setLoading(true);
    _setError(null);

    try {
      final ApiResponse<Product> response = await ApiService.updateProduct(id, product);

      if (response.success && response.data != null) {
        final index = _products.indexWhere((p) => p.productId == id);
        if (index != -1) {
          _products[index] = response.data!;
        }
        _setError(null);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        if (response.errors != null && response.errors!.isNotEmpty) {
          _setError('${response.message}\n${response.errors!.join('\n')}');
        }
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Failed to update product: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(int id) async {
    _setLoading(true);
    _setError(null);

    try {
      final ApiResponse<Product> response = await ApiService.deleteProduct(id);

      if (response.success) {
        _products.removeWhere((product) => product.productId == id);
        _setError(null);
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Failed to delete product: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Get product by ID (for editing)
  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.productId == id);
    } catch (e) {
      return null;
    }
  }

  // Clear error message
  void clearError() {
    _setError(null);
  }

  // Search products by name
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;

    return _products.where((product) =>
        product.productName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}