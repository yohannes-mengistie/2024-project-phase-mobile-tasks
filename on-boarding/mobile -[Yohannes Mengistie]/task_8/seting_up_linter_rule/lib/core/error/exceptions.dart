class ServerException implements Exception {
  final String message;

  ServerException([this.message = "An error occurred on the server."]);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "An error occurred on the server."]);
}
