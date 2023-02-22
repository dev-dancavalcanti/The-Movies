/// 1: user-not-found - Auth
///
/// 2: wrong-password - Auth
///
/// 3: weak-password - Auth
///
/// 4: email-already-in-use - Auth
///
/// 5: invalid-email - Auth
///
/// 6: operation-not-allowed - Auth
///
/// 7: invalid-email - Auth
///
/// 8: missing-email - Auth
///
/// 9: too-many-requests - Auth
///
/// 10: requires-recent-login - Auth
///
/// 11: user-mismatch - Auth
///
class FirebaseException implements Exception {
  final int statusCode;
  final String message;

  const FirebaseException([this.statusCode = 0, this.message = '']);

  @override
  String toString() => "${(FirebaseException).toString()}: $statusCode: $message";
}
