class BootstrapException implements Exception {
  const BootstrapException(this.message, {this.details, this.cause});

  final String message;
  final String? details;
  final Object? cause;

  @override
  String toString() => message;
}
