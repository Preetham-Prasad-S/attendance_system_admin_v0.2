abstract interface class AppFailure {}

class AppAuthFailure implements AppFailure {
  const AppAuthFailure({required this.message});

  final String message;

  @override
  String toString() => message;
}
