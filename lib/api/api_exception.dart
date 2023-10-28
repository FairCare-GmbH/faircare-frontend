class ApiException implements Exception {
  final int code;
  final List<String> messages;

  ApiException({required this.code, required this.messages});

  @override
  String toString() {
    return '$messages';
  }
}
