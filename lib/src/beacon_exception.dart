class BeaconException implements Exception {
  final String message;
  BeaconException(this.message);

  @override
  String toString() {
    return 'BeaconException: $message';
  }
}
