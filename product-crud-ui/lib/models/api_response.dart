class ApiResponse<T> {
  final bool success;
  final T? data;
  final String message;
  final List<String>? errors;

  ApiResponse({
    required this.success,
    this.data,
    required this.message,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      data: json['data'] != null && fromJsonT != null ? fromJsonT(json['data']) : null,
      message: json['message'] as String,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
    );
  }
}