abstract interface class AppException implements Exception {}

class AppAuthException implements AppException {
  const AppAuthException({required this.message});

  final String message;

  @override
  String toString() => message;
}

class AppUnknownException implements AppException {
  const AppUnknownException({required this.message});

  final String message;

  @override
  String toString() => message;
}
