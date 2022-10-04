class MigrationError extends Error {
  final Object? message;

  MigrationError([this.message]);

  @override
  String toString() {
    if (message != null) {
      return "Migration failed: ${Error.safeToString(message)}";
    }
    return "Migration failed";
  }
}
